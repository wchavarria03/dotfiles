;;; init.el --- Personal Emacs config -*- lexical-binding: t; -*-

;;; PACKAGES
;; MELPA is where most community packages live. `use-package' is built in
;; (Emacs 29+); `:ensure t' installs a package the first time it is needed.
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq use-package-always-ensure t)

;;; Housekeeping
;; Keep `M-x customize' output out of this file.
;;(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
;;(load custom-file 'noerror)

;; TODO: backups/autosaves. Decide: disable them, or send them to a single
;; directory (see `backup-directory-alist').

;;; UI
;; TODO: turn off the toolbar and menu bar (`tool-bar-mode', `menu-bar-mode')
;;'display-line-numbers-type', 'global-display-line-numbers-mode')
;; and pick a font (`set-face-attribute' on the `default' face).

;;; Editing
;; TODO: install `evil' with `use-package'. Start with `(setq evil-want-keybinding nil)'
;; before it loads, then enable `evil-mode'. Add `evil-collection' afterwards.

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))


(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))
;;; Completion
;; TODO: `vertico' (minibuffer UI), `orderless' (matching), `which-key' (key hints).

;;; Keybindings
;; TODO: port your nvim keys here (leader, `jk' escape, window splits).
;; Rules of thumb: keep `C-x', `C-c' and `M-x'; bind your own keys under a
;; leader or `C-c <letter>'; never rebind `C-g'.
;; WezTerm owns `C-h/j/k/l' (smart-splits) in terminal Emacs, so don't rebind
;; them. Use `C-w h/j/k/l' (evil) for windows and `F1' for help.
(keymap-global-set "C-c f" #'find-file)

;; Leader: SPC in normal and motion states (evil's `,' is already repeat-find).
(evil-set-leader '(normal motion) (kbd "SPC"))

;; Window movement: SPC w h/j/k/l. `windmove' is built in.
(evil-define-key '(normal motion) 'global
  (kbd "<leader>wh") #'windmove-left
  (kbd "<leader>wj") #'windmove-down
  (kbd "<leader>wk") #'windmove-up
  (kbd "<leader>wl") #'windmove-right)

;;; INIT.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
