(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package gptel
  :init
  (setq-default gptel-model "openchat"
		gptel-backend (gptel-make-ollama "mars"
						 :host "mars.local:11434"
						 :models '("openchat" "zephyr")
						 :stream t))
  :bind ("C-c RET" . gptel-send)
  :config
  (my/leader-def
    "g" '(:ignore t :wk "gpt")
    "g o" '(gptel :wk "Open Chat")
    "g m" '(gptel-menu :wk "Open Menu"))
  (setq gptel-default-mode 'markdown-mode))

(provide 'init-ai)

