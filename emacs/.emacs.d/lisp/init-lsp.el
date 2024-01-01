(use-package lsp-mode
  :commands lsp
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)))

;; optionally
(use-package lsp-ui
  :after (lsp-mode)
  :bind (:map lsp-mode-map
	      ("M-?" . #'lsp-find-references)
	      ("C-c C-d" . #'lsp-describe-thing-at-point)
	      ("C-c C-j" . #'lsp-find-definition)
	      ("C-c C-r" . #'lsp-rename)
	      ("C-c C-a" . #'lsp-execute-code-action))
  :bind (:map lsp-ui-peek-mode-map
	      ("j" . #'lsp-ui-peek--select-next)
	      ("k" . #'lsp-ui-peek--select-prev)
	      ("C-j" . #'lsp-ui-peek--select-next-file)
	      ("C-k" . #'lsp-ui-peek--select-prev-file))
  :hook (lsp-mode . lsp-ui-mode)
  :commands lsp-ui-mode
  :custom-face
  :config
  (my/comma-leader-def
    "d" 'consult-lsp-diagnostics
    "h" 'lsp-ui-doc-toggle)
  
  ;; Taken from doom emacs
  (setq lsp-ui-peek-enable t
	lsp-ui-doc-max-height 16
	lsp-ui-doc-max-width 150
	lsp-ui-doc-position 'at-point
	lsp-ui-doc-enhanced-markdown nil
	lsp-ui-peek-always-show t
	lsp-inlay-hint-enable t
	lsp-auto-execute-action nil
	lsp-ui-sideline-actions-icon lsp-ui-sideline-actions-icon-default))

(use-package consult-lsp
  :after (lsp-mode)
  :bind (:map lsp-mode-map
	      ([remap xref-find-apropos] . #'consult-lsp-symbols)))

(use-package lsp-treemacs
  :after lsp
  ) 

(use-package flycheck)

(provide 'init-lsp)
