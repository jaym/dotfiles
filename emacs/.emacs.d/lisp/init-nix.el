(use-package nix-mode
  :mode ("\\.nix\\'" "\\.nix.in\\'"))

(use-package nix-drv-mode
  :elpaca nix-mode
  :mode "\\.drv\\'")

(use-package nix-shell
  :elpaca nix-mode
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))

(use-package nix-repl
  :elpaca nix-mode
  :commands (nix-repl))

(provide 'init-nix)
