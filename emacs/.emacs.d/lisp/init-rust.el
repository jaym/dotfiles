(use-package rustic
  :custom
  (rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))
  (lsp-rust-analyzer-cargo-watch-command "clippy")
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  (lsp-rust-analyzer-display-chaining-hints t)
  (lsp-rust-analyzer-display-closure-return-type-hints t))

(provide 'init-rust)
