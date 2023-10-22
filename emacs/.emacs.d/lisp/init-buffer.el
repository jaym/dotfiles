(use-package recentf
  :elpaca nil
  :ensure nil
  :hook (after-init . recentf-mode)
  :init
  (setq recentf-max-saved-items 250
        recentf-exclude '("/tmp/"))
  :config
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-var-directory))
  (add-to-list 'recentf-exclude
               (recentf-expand-file-name no-littering-etc-directory))
  )

(my/leader-def
  "b" '(:ignore t :wk "buffer")
  "b b" '(consult-buffer :wk "Switch buffer")
  "b i" '(ibuffer :wk "Ibuffer")
  "b k" '(kill-this-buffer :wk "Kill this buffer")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer"))

(my/leader-def
  "f" '(:ignore t :wk "file")
  "f c" '((lambda () (interactive) (find-file "~/.emacs.d/")) :wk "Edit emacs config")
  "f f" '(find-file :wk "Find file")
  "f r" '(consult-recent-file :wk "Recent file")
  "f s" '(save-buffer :wk "Save file"))

(my/leader-def
  "m" '(:ignore t :wk "mode")
  "m m" '(consult-mode-command :wk "Mode command")
  "m M" '(consult-minor-mode-menu :wk "Minor mode menu"))

(provide 'init-buffer)
