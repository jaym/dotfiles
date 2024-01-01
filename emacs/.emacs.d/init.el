;;; init.el --- Emacs Configuration -*- lexical-binding: t -*-

;; Load custom.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(require 'use-package)
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6)

(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 16777216
                  gc-cons-percentage 0.1)))


(defun jdm/reload-init()
  "Reload init.el."
  (interactive)
  (message "Reloading init.el...")
  (load user-init-file nil 'nomessage)
  (message "Reloading init.el... done."))

(require 'init-elpaca)
(require 'init-util)
(require 'init-no-littering)
(require 'init-workspace)
(require 'init-evil)
(require 'init-keybindings)
(require 'init-help)
(require 'init-ui)
(require 'init-tree-sitter)
(require 'init-org)
(require 'init-completion)
(require 'init-buffer)
(require 'init-editing)
(require 'init-proced)
(require 'init-elfeed)
(require 'init-shell)
(require 'init-crux)
(require 'init-erc)
(require 'init-ai)

(require 'init-lsp)
(require 'init-magit)
(require 'init-lisp)
(require 'init-golang)
(require 'init-nix)
(require 'init-rust)

(load custom-file :noerror)
