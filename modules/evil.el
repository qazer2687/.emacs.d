(use-package evil
  ;; disable emacs mode
  :config
    (dolist (state '(normal insert visual motion replace operator))
      (evil-global-set-key state (kbd "C-z") nil))
  :init (evil-mode 1))