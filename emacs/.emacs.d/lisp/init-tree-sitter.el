;; -*- lexical-binding: t; -*-

(use-package tree-sitter
  :commands (global-tree-sitter-mode)
  :hook
  ((tree-sitter-after-on . tree-sitter-hl-mode)
   (after-init . global-tree-sitter-mode))
  :ensure t)

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)

(provide 'init-tree-sitter)
