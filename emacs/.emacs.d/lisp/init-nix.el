(use-package lsp-nix
  :elpaca nil
  :after (lsp-mode)
  :demand t
  :custom
  (lsp-nix-nil-formatter ["nixpkgs-fmt"]))

(use-package nix-mode
  :hook (nix-mode . lsp-deferred)
  :after (nix-mode)
  :mode ("\\.nix\\'" "\\.nix.in\\'"))

(use-package nix-drv-mode
  :elpaca nil
  :after (nix-mode)
  :mode "\\.drv\\'")

(use-package nix-shell
  :elpaca nil
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))

(use-package nix-repl
  :elpaca nil
  :after (nix-mode)
  :commands (nix-repl))

;; (with-eval-after-load 'lsp-mode
;;   (lsp-register-client
;;     (make-lsp-client :new-connection (lsp-stdio-connection "nixd")
;;                      :major-modes '(nix-mode)
;;                      :priority 0
;;                      :server-id 'nixd)))

(provide 'init-nix)
