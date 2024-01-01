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

(defun my/persp-kill-this-buffer ()
  (interactive)
  (persp-kill-buffer* (current-buffer)))

(my/leader-def
  "b" '(:ignore t :wk "buffer")
  "b k" '(my/persp-kill-this-buffer :wk "Kill buffer")
  "b n" '(next-buffer :wk "Next buffer")
  "b p" '(previous-buffer :wk "Previous buffer")
  "b r" '(revert-buffer :wk "Reload buffer"))

(defun my/eshell-other-frame ()
  (interactive)
  (let ((new-frame (make-frame)))
    (select-frame new-frame)
    (delete-other-windows)
    (eshell)))

(my/leader-def
  "F" '(:ignore  t :wk "frame")
  "F n" '(make-frame :wk "New")
  "F d" '(dired-other-frame :wk "Dired" )
  "F s" '(my/eshell-other-frame))

(my/leader-def
  "f" '(:ignore t :wk "file")
  "f c" '((lambda () (interactive) (consult-find "~/.emacs.d/")) :wk "Edit emacs config")
  "f f" '(find-file :wk "Find file")
  "f r" '(consult-recent-file :wk "Recent file")
  "f s" '(save-buffer :wk "Save file"))

(my/leader-def
  "p" '(:ignore t :wk "project")
  "p b" '(consult-project-buffer :wk "Switch buffer"))

(my/leader-def
  "m" '(:ignore t :wk "mode")
  "m m" '(consult-mode-command :wk "Mode command")
  "m M" '(consult-minor-mode-menu :wk "Minor mode menu"))

(provide 'init-buffer)
