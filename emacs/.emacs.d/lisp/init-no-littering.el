;; https://github.com/emacscollective/no-littering

(use-package no-littering
             :demand t
             :init
              (setq no-littering-etc-directory (expand-file-name "etc/" user-emacs-cache-directory)
                    no-littering-var-directory (expand-file-name "var/" user-emacs-cache-directory))
             :config
             (no-littering-theme-backups))
(elpaca-wait)

(provide 'init-no-littering)
