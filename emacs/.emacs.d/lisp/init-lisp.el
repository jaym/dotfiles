(use-package lispy
  :diminish
  :defines (lispy-mode-map)
  :hook ((emacs-lisp-mode . lispy-mode)))

(use-package lispyville
  :init
  (general-add-hook '(lispy-mode-hook) #'lispyville-mode)
  :config
  (lispyville-set-key-theme '(operators c-w c-u prettify additional-movement slurp/barf-lispy
                              additional additional-insert escape insert)))

(use-package sly
  :general
  (:states '(normal insert) :keymaps 'sly-mrepl-mode-map
	    (kbd "<up>") 'sly-mrepl-previous-input-or-button
	    (kbd "<down>") 'sly-mrepl-next-input-or-button)
  :init
  (setq inferior-lisp-program "/usr/bin/sbcl")
  (setq-default sly-symbol-completion-mode nil)
  :commands (sly sly-scratch)
  :hook (lisp-mode . sly-mode))

(provide 'init-lisp)
