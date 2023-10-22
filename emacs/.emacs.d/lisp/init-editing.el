(use-package parinfer-rust-mode
  :hook emacs-lisp-mode
  :custom
  (parinfer-rust-auto-download t)
  (parinfer-rust-library-directory (expand-file-name "parinfer/lib/" no-littering-var-directory))
  :init
  (setq parinfer-rust-auto-download t))

(provide 'init-editing)
