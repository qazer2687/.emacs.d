;;;; Qazer's Emacs Configuration

;; Encoding
(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")

;; Paths
(defvar user-data-directory           (expand-file-name ""                user-emacs-directory))
(defvar user-cache-directory          (expand-file-name ".cache"          user-emacs-directory))
(defvar user-backup-directory         (expand-file-name ".backups"        user-emacs-directory))
(defvar user-autosave-directory       (expand-file-name ".autosaves"      user-emacs-directory))
(defvar user-modules-directory        (expand-file-name "modules"         user-emacs-directory))
(setq custom-file                     (expand-file-name "custom.el"       user-emacs-directory))

(make-directory user-cache-directory t)
(make-directory user-backup-directory t)
(make-directory user-autosave-directory t)
(make-directory user-modules-directory t)

(setq backup-directory-alist `(("." . ,user-backup-directory)))
(setq auto-save-file-name-transforms `((".*" ,(concat user-autosave-directory "/") t)))
(setq auto-save-list-file-prefix nil)


;; Configuration
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 0)
(menu-bar-mode -1)
(setq auto-repeat-mode t)
(column-number-mode)
(setq visible-bell t)
(global-display-line-numbers-mode)
; disable line numbers for certain modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(set-face-attribute 'default
 nil
  :font "LiterationMono Nerd Font Mono"
  :height 120)

;; Bindings
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Packages
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(require 'use-package)
(setq use-package-always-ensure t)

;; Modules
(mapc (lambda (file)
        (let ((module-file (concat file ".el")))
          (load-file (expand-file-name module-file user-modules-directory))))
      '("all-the-icons"
        "counsel"
        "doom-modeline"
        "doom-themes"
        "elcord"
        "evil"
        "ivy"
        "rainbow-delimiters"
        "which-key"
        ))

