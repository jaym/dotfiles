(use-package helpful
  :general
  (my/leader-def
    "h i" '(info :wk "Info")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h B" '(general-describe-keybindings :wk "General Describe Keybindings")
    "h f" '(helpful-function :wk "Describe function")
    "h k" '(helpful-key :wk "Describe key")
    "h m" '(describe-mode :wk "Describe mode")
    "h v" '(helpful-variable :wk "Describe variable")
    "h ." '(helpful-at-point :wk "Describe symbol at point"))
  :config
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable))
(provide 'init-help)
