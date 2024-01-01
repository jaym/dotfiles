(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package gptel
  :init
  (setq-default gptel-model "zephyr"
		gptel-backend (gptel-make-ollama "mars"
						 :host "mars.local:11434"
						 :models '("openchat" "zephyr" "dolphin-mixtral:8x7b-v2.5-q3_K_S")
						 :stream t))
  :bind ("C-c RET" . gptel-send)
  :config
  (my/leader-def
    "g" '(:ignore t :wk "gpt")
    "g o" '(gptel :wk "Open Chat")
    "g m" '(gptel-menu :wk "Open Menu"))
  (setq gptel-default-mode 'markdown-mode))

(use-package copilot
  :ensure t
  :elpaca (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :hook (emacs-lisp-mode . (lambda ()
			     (setq-local copilot--indent-warning-printed-p t)))
  :bind (:map copilot-completion-map
	      ("<tab>" . copilot-accept-completion)))

(use-package ellama
  :init
  (require 'llm-ollama)
  (setopt ellama-provider
		  (make-llm-ollama
		   :host "mars.local"
		   :port 11434
		   :chat-model "openchat" :embedding-model "openchat")))

(provide 'init-ai)

