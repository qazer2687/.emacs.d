;;;; Qazer's Emacs Configuration

;; Encoding
(prefer-coding-system 'utf-8-unix)
(set-language-environment "UTF-8")

;; Paths
(defvar user-data-directory           (expand-file-name ""                user-emacs-directory))
(defvar user-cache-directory          (expand-file-name ".cache"          user-emacs-directory))
(defvar user-backup-directory         (expand-file-name ".backups"        user-emacs-directory))
(defvar user-autosave-directory       (expand-file-name ".autosaves"      user-emacs-directory))
(setq custom-file                     (expand-file-name "custom.el"       user-emacs-directory))

(make-directory user-cache-directory t)
(make-directory user-backup-directory t)
(make-directory user-autosave-directory t)

;; Set backup directory
(setq backup-directory-alist `(("." . ,user-backup-directory)))

;; Set autosave directory
(setq auto-save-file-name-transforms `((".*" ,(concat user-autosave-directory "/") t)))


(setq auto-save-list-file-prefix nil)

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

;; Font
(set-face-attribute 'default
 nil
  :font "LiterationMono Nerd Font Mono"
  :height 120)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)



(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
    :map ivy-minibuffer-map
    ("TAB" . ivy-alt-done)	
    ("C-l" . ivy-alt-done)
    ("C-j" . ivy-next-line)
    ("C-k" . ivy-previous-line)
    :map ivy-switch-buffer-map
    ("C-k" . ivy-previous-line)
    ("C-l" . ivy-donie)
    ("C-d" . ivy-switch-buffer-kill)
    :map ivy-reverse-i-search-map
    ("C-k" . ivy-previous-line)
    ("C-d" . ivy-reverse-i-search-kill))
  :init
  (ivy-mode))

(use-package doom-modeline
  :custom (doom-modeline-height 40)
  :init (doom-modeline-mode 1))

(use-package evil
  ;; disable emacs mode
  :config
    (dolist (state '(normal insert visual motion replace operator))
      (evil-global-set-key state (kbd "C-z") nil))
  :init (evil-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :diminish which-key-mode
  :custom (which-key-idle-delay 0)
  :init (which-key-mode))

(use-package counsel
  :bind (("M-x" . counsel-M-x)
	 ("C-x b" . counsel-ibuffer)
	 ("C-x C-f" . counsel-find-file)
	 :map minibuffer-local-map
	 ("C-r" . counsel-minibuffer-history))
  :config (setq ivy-initial-inputs-alist nil)
  :init (counsel-mode))
(global-set-key (kbd "C-M-j") 'counsel-switch-buffer)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-gruvbox t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config))

(use-package elcord
  :custom (elcord-display-buffer-details nil)
  :init (elcord-mode))

;; NOTE: When loading this configuration for the first time, run the command below so that mode line icons are displayed correctly:
;;
;; M-x all-the-icons-install-fonts

(use-package all-the-icons)
