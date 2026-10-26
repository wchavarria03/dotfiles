;;; org-calendar.el --- Google Calendar in the org agenda (org-gcal) -*- lexical-binding: t; -*-

;; Loaded from config.el with (load! "org-calendar"), after org-config.
;;
;; Credentials live in the private secrets repo, not here:
;;   ~/personal/secrets/emacs/gcal.el
;;     (setq org-gcal-client-id     "xxxx.apps.googleusercontent.com"
;;           org-gcal-client-secret "xxxx")
;;
;; Each calendar syncs into its own file in ~/personal/notes/calendar/
;; (gitignored: the files are rewritten on every sync).
;;
;; Keys:  SPC o C  choose which calendars the agenda shows
;;        SPC o G  sync now (fetch from Google and push local edits)

(defvar my/gcal-calendars
  '(("wchavarria03@gmail.com" "Personal" "cal_personal")
    ("49da83187c73c208919df0ff22906817fddd5bbf0efc5414302e881bed6e884f@group.calendar.google.com"
     "Bike Stuff" "cal_bike")
    ("anv8kapls98qnoevo0n64f7qn0@group.calendar.google.com"
     "Dream Team Family" "cal_family")
    ("daf51ba85f7f420ac79d4590f2860f161bb229a3766ec2eff780d9e0e464b437@group.calendar.google.com"
     "Gym & Training" "cal_training")
    ;; Work account: only syncs if it is shared with wchavarria03@gmail.com
    ;; (org-gcal logs in with one Google account).
    ("wchavarria@ltvco.com" "Work" "cal_work"))
  "Google calendars to sync, as (CALENDAR-ID NAME TAG).
CALENDAR-ID: Google Calendar > Settings > (the calendar) > Integrate calendar.
NAME: shown in the agenda and the toggle. TAG: file name and agenda tag
\(lowercase snake_case), so =/= in the agenda can filter by calendar.")

(defvar my/gcal-dir (expand-file-name "../calendar/" org-directory)
  "Folder for the synced calendar files.")

(defvar my/gcal-hidden nil
  "Names of the calendars currently hidden from the agenda.")

(defvar my/gcal-secrets (expand-file-name "~/personal/secrets/emacs/gcal.el")
  "File that sets `org-gcal-client-id' and `org-gcal-client-secret'.")

(defun my/gcal-file (tag)
  (expand-file-name (concat tag ".org") my/gcal-dir))

(defun my/gcal-ensure-files ()
  "Create each calendar's file with a header, the first time only."
  (make-directory my/gcal-dir t)
  (dolist (cal my/gcal-calendars)
    (let ((file (my/gcal-file (nth 2 cal))))
      (unless (file-exists-p file)
        (with-temp-file file
          (insert (format "#+title: Calendar — %s\n#+category: %s\n#+filetags: :calendar:%s:\n\n"
                          (nth 1 cal) (nth 1 cal) (nth 2 cal))))))))

(defun my/agenda-refresh-files ()
  "Agenda = the notes plus every calendar that isn't hidden."
  (setq org-agenda-files
        (cons org-directory
              (cl-loop for (_id name tag) in my/gcal-calendars
                       unless (member name my/gcal-hidden)
                       collect (my/gcal-file tag)))))

(defun my/agenda-toggle-calendars ()
  "Pick which Google calendars the agenda shows (stays until changed)."
  (interactive)
  (let* ((names (mapcar #'cadr my/gcal-calendars))
         (shown-now (cl-set-difference names my/gcal-hidden :test #'equal))
         (shown (completing-read-multiple
                 "Show calendars (comma separated): " names nil t
                 (string-join shown-now ","))))
    (setq my/gcal-hidden (cl-set-difference names shown :test #'equal))
    (my/agenda-refresh-files)
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (when (derived-mode-p 'org-agenda-mode) (org-agenda-redo t))))
    (message "Agenda shows: %s" (if shown (string-join shown ", ") "no calendars"))))

(after! org
  (my/gcal-ensure-files)
  (my/agenda-refresh-files))

(use-package! org-gcal
  :after org
  :commands (org-gcal-sync org-gcal-fetch org-gcal-post-at-point org-gcal-delete-at-point)
  :init
  (setq org-gcal-fetch-file-alist
        (mapcar (lambda (cal) (cons (car cal) (my/gcal-file (nth 2 cal)))) my/gcal-calendars)
        org-gcal-up-days 30                      ; past events kept in the files
        org-gcal-down-days 90                    ; future events fetched
        org-gcal-recurring-events-mode 'nested   ; instances under their series
        org-gcal-update-cancelled-events-with-todo t   ; cancelled -> CANCELLED
        org-gcal-remove-api-cancelled-events t   ; deleted in Google -> removed here, no prompt
        plstore-cache-passphrase-for-symmetric-encryption t)
  (if (file-exists-p my/gcal-secrets)
      (load my/gcal-secrets nil t)
    (message "org-gcal: %s not found, calendar sync is off" my/gcal-secrets))
  :config
  ;; org-gcal's login library (oauth2-auto) keeps its own copy of the client
  ;; ID/secret; without this it can fall back to a built-in client that Google
  ;; rejects with "Error 401: invalid_client".
  (when (fboundp 'org-gcal-reload-client-id-secret)
    (org-gcal-reload-client-id-secret)))

(defun my/gcal-ready-p ()
  "Non-nil when credentials are set and the first login has been done."
  (and (bound-and-true-p org-gcal-client-id)
       (not (string-empty-p org-gcal-client-id))
       (require 'org-gcal nil t)
       (boundp 'oauth2-auto-plstore)
       (file-exists-p oauth2-auto-plstore)))

(defun my/gcal-fetch-in-background ()
  "Timer job: pull new, changed and cancelled events. Never pushes."
  (when (my/gcal-ready-p)
    (org-gcal-fetch)))

;; Only the notes daemon syncs on a timer (every 15 min, first run after 2 min).
;; It skips silently until the first interactive login (SPC o G) has stored a token.
(when (equal (daemonp) "notes")
  (run-with-timer 120 (* 15 60) #'my/gcal-fetch-in-background))

(map! :leader
      :desc "Toggle calendars" "o C" #'my/agenda-toggle-calendars
      :desc "Sync Google Calendar" "o G" #'org-gcal-sync)
