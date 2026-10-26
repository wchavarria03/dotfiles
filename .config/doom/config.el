;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Walter Chavarria"
      user-mail-address "wchavarria03@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 14 :weight 'regular))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq catppuccin-flavor 'mocha
      doom-theme 'catppuccin)

;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; List and run Makefile targets (SPC p m); picks among sub-Makefiles in monorepos.
(use-package! makefile-executor
  :commands (makefile-executor-execute-target
             makefile-executor-execute-project-target
             makefile-executor-execute-last)
  :init
  (map! :leader
        :desc "Make target" "p m" #'makefile-executor-execute-project-target))

;; 
;;;
;;; Tools come from Mason (Neovim) via PATH; don't download duplicates
;;; ------------------------------------------------------------------
(setq lsp-enable-suggest-server-download nil)

;;
;;; Go  (gopls + gofumpt + staticcheck)
;;; ------------------------------------------------------------------
(after! lsp-go
  (setq lsp-go-use-gofumpt t
        lsp-go-analyses '((unusedparams . t) (shadow . t) (nilness . t)))
  (lsp-register-custom-settings
   '(("gopls.staticcheck" t t)
     ("gopls.completeUnimported" t t)
     ("gopls.hints.parameterNames" t t)
     ("gopls.hints.assignVariableTypes" t t))))

;; Format Go via gopls (gofumpt + organize imports)
(add-hook! '(go-mode-hook go-ts-mode-hook)
  (setq-local +format-with-lsp t))

;;; ------------------------------------------------------------------
;;; Python  (basedpyright for types, ruff for lint + format)
;;; ------------------------------------------------------------------
(after! lsp-pyright
  (setq lsp-pyright-langserver-command "basedpyright"
        lsp-pyright-type-checking-mode "standard"))

(after! lsp-mode
  (setq lsp-ruff-server-command '("ruff" "server")
        lsp-headerline-breadcrumb-enable t
        lsp-inlay-hint-enable t
        lsp-file-watch-threshold 3000))

(set-formatter! 'ruff '("ruff" "format" "--stdin-filename" filepath "-")
  :modes '(python-mode python-ts-mode))

;; Virtualenvs: in each project run
;;   uv venv --python "$(asdf which python)"
;;   echo 'source .venv/bin/activate' > .envrc && direnv allow

;;; ------------------------------------------------------------------
;;; Frame titles: "Notes Emacs" / "Code Emacs" per daemon, so aerospace can
;;; route frames (see .config/aerospace/emacs_utils.sh).
;;; ------------------------------------------------------------------
(setq frame-title-format
      '((:eval (pcase (bound-and-true-p server-name)
                 ("notes" "Notes Emacs")
                 ("code" "Code Emacs")
                 (_ "Emacs")))
        " — %b"))

;;; ------------------------------------------------------------------
;;; Notes: org, org-roam, agenda, capture templates (see org-config.el)
;;; ------------------------------------------------------------------
(load! "org-config")
