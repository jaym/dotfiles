(use-package lsp-mode
  :commands lsp
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)))

;; optionally
(use-package lsp-ui
  :after (lsp-mode)
  :bind (:map lsp-ui-peek-mode-map
	      ("j" . #'lsp-ui-peek--select-next)
	      ("k" . #'lsp-ui-peek--select-prev)
	      ("C-j" . #'lsp-ui-peek--select-next-file)
	      ("C-k" . #'lsp-ui-peek--select-prev-file))
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :config
  (my/comma-leader-def
    "d" 'consult-lsp-diagnostics
    "h" 'lsp-ui-doc-show
    "H" 'lsp-ui-doc-hide)

  ;; Taken from doom emacs
  (setq lsp-ui-peek-enable t
        lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 72         ; 150 (default) is too wide
        ;; Don't show symbol definitions in the sideline. They are pretty noisy,
        ;; and there is a bug preventing Flycheck errors from being shown (the
        ;; errors flash briefly and then disappear).
        ;; lsp-ui-sideline-show-hover nil
        ;; Re-enable icon scaling (it's disabled by default upstream for Emacs
        ;; 26.x compatibility; see emacs-lsp/lsp-ui#573)
        lsp-ui-sideline-actions-icon lsp-ui-sideline-actions-icon-default))

(use-package consult-lsp
  :after (lsp-mode)
  :bind (:map lsp-mode-map
	      ([remap xref-find-apropos] . #'consult-lsp-symbols)))

(use-package flycheck)

(provide 'init-lsp)
