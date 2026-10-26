;;; org-config.el --- org, org-roam, agenda, capture templates -*- lexical-binding: t; -*-

;; Loaded from config.el with (load! "org-config").

;;; Paths -------------------------------------------------------------------

(setq org-directory "~/personal/notes/second-brain/"
      org-roam-directory org-directory
      org-roam-dailies-directory "daily/"
      org-attach-id-dir "attachments/")

;;; Org ---------------------------------------------------------------------

(after! org
  (setq org-log-done 'time
        org-agenda-files (list org-directory)
        org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@)" "|" "DONE(d)" "CANCELLED(c@)")))

  ;; Allowed tags (see conventions.org). Groups are mutually exclusive in the
  ;; interactive tag selector; topic tags stay free.
  (setq org-tag-persistent-alist
        '((:startgroup) ("health") ("cycling") ("career") ("streaming") ("finance")
          ("dogs") ("work") ("home") ("harness") (:endgroup)
          (:startgroup) ("moc") ("project") ("decision") ("research") ("log") ("idea") (:endgroup)
          (:startgroup) ("active") ("not_started") ("blocked") ("on_hold") ("deprioritized") ("sleeping") (:endgroup))))

(map! :after evil-org
      :map evil-org-mode-map
      :n "M-h" #'org-metaleft
      :n "M-l" #'org-metaright
      :n "M-k" #'org-metaup
      :n "M-j" #'org-metadown)

;;; Org-roam ----------------------------------------------------------------

(defvar my/area-prompt
  "%^{Area|health|cycling|career|streaming|finance|dogs|work|home|harness}"
  "Capture prompt for the one required area tag.")

(defvar my/home-link
  "[[id:873e51f7-facc-41c0-8953-0a6242094525][Home]]"
  "Link to the root MOC.")

(defvar my/decisions-index-link
  "[[id:4b388eec-6e2e-4aab-b52d-3539e098d593][Decisions Index]]"
  "Link to the Decisions Index MOC.")

(defun my/roam-head (kind-tags)
  "Header for a new note: title plus the area prompt and KIND-TAGS."
  (concat "#+title: ${title}\n#+filetags: :" my/area-prompt ":" kind-tags "\n\n"))

;;; Quick capture (alt-shift-n) --------------------------------------------
;; Goes to the ideas inbox, in the format ideas_inbox.org describes.

(after! org
  (setq org-capture-templates
        `(("t" "TODO" entry (file+headline "ideas_todos.org" "TODOs")
           ,(concat "* TODO %? :" my/area-prompt ":\n:PROPERTIES:\n:CREATED: %u\n:END:")
           :prepend nil)
          ("i" "Idea" entry (file+headline "ideas_todos.org" "Ideas")
           ,(concat "* %? :" my/area-prompt ":idea:\n:PROPERTIES:\n:CREATED: %u\n:END:")
           :prepend nil))))

(after! org-roam
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:30}" 'face 'org-tag))
        org-roam-capture-templates
        `(("n" "note" plain
           "Part of %?.\n\nRelated: \n"
           :target (file+head "${slug}.org" ,(my/roam-head ""))
           :unnarrowed t)
          ("p" "project" plain
           "Part of %?.\n\n* Goal\n\n* TODO First step\n"
           :target (file+head "${slug}.org" ,(my/roam-head "project:active:"))
           :unnarrowed t)
          ("m" "moc" plain
           ,(concat "Part of " my/home-link ".\n\n* %?\n")
           :target (file+head "${slug}.org" ,(my/roam-head "moc:"))
           :unnarrowed t)
          ("r" "research" plain
           "Part of %?.\n\n* Question\n\n* Findings\n\n* Sources\n"
           :target (file+head "${slug}.org" ,(my/roam-head "research:"))
           :unnarrowed t)
          ("d" "decision" plain
           ,(concat "Part of " my/decisions-index-link
                    ".\n\n* Context\n%?\n\n* Options considered\n\n* Decision\n\n* Why\n\n* Sources\n\n* Revisit when\n")
           :target (file+head "${slug}.org"
                              ,(concat ":PROPERTIES:\n:STATUS: proposed\n:END:\n"
                                       (my/roam-head "decision:")))
           :unnarrowed t)
          ("i" "idea" plain
           "Part of %?.\n\n* Idea\n"
           :target (file+head "${slug}.org" ,(my/roam-head "idea:not_started:"))
           :unnarrowed t)
          ;; Title = the event, e.g. "ZRL R2 Points Race Watopia"; the date is
          ;; prefixed to the title and the file name, like the existing clip notes.
          ("c" "streaming-clip-log" plain
           (file ,(expand-file-name "../templates/streaming-clip-log.org" org-directory))
           :target (file+head "%<%Y_%m_%d>_${slug}.org"
                              ,(concat ":PROPERTIES:\n:DATE: %<%Y-%m-%d>\n:EVENT: ${title}\n"
                                       ":EVENT_TYPE: %^{Event type|race|training|ftp-test|meetup|outdoor}\n"
                                       ":STATUS: to-cut\n:TYPE: clip-log\n:END:\n"
                                       "#+title: %<%Y-%m-%d> — ${title}\n"
                                       "#+filetags: :streaming:clips:wallyrides:log:\n\n"))
           :unnarrowed t)))
  (org-roam-db-autosync-mode))

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t))
