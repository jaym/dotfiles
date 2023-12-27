(require 'cl)

;; https://www.emacswiki.org/emacs/EshellAndEmacsServer
(defun server-eshell ()
  "Command to be called by emacs-client to start a new shell.

A new eshell will be created. When the frame is closed, the buffer is deleted or the shell exits,
then hooks will take care that the other actions happen. For example, when the frame is closed,
then the buffer will be deleted and the client disconnected.

Also creates a local binding of 'C-x #' to kill the buffer."
  (lexical-let ((buf (eshell t))
                (client (first server-clients))
                (frame (selected-frame)))
    (labels ((close (&optional arg)
                    (when (not (boundp 'cve/recurse))
                      (let ((cve/recurse t))
			(delete-frame frame)
			(kill-buffer buf)
			(server-delete-client client)))))
      (add-hook 'eshell-exit-hook #'close t t)
      (add-hook 'delete-frame-functions #'close t t))
    (local-set-key (kbd "C-x #") (lambda () (interactive) (kill-buffer buf)))
    (delete-other-windows)
    nil))

(use-package with-editor
  :init
  (setq with-editor-emacsclient-executable "/usr/bin/emacsclient")
  :config
  (shell-command-with-editor-mode t)
  (add-hook 'shell-mode-hook  'with-editor-export-editor)
  (add-hook 'eshell-mode-hook 'with-editor-export-editor)
  (add-hook 'term-exec-hook   'with-editor-export-editor)
  (add-hook 'vterm-mode-hook  'with-editor-export-editor)
  )

(defun comint-fix-window-size ()
  "Change process window size."
  (when (derived-mode-p 'comint-mode)
    (set-process-window-size (get-buffer-process (current-buffer))
                         (window-height)
                         (window-width))))

(defun my-shell-mode-hook ()
  ;; add this hook as buffer local, so it runs once per window.
  (add-hook 'window-configuration-change-hook 'comint-fix-window-size nil t)
  (display-line-numbers-mode -1))

(add-hook 'vterm-mode-hook 'my-shell-mode-hook)
(add-hook 'shell-mode-hook 'my-shell-mode-hook)
(add-hook 'eshell-mode-hook 'my-shell-mode-hook)

(defun efs/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  ;; Bind some useful keys for evil-mode
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "C-r") 'consult-history)
  (evil-define-key '(normal insert visual) eshell-mode-map (kbd "<home>") 'eshell-bol)
  (evil-normalize-keymaps)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell
  :ensure nil
  :elpaca nil
  :init
  (setq eshell-aliases-file "~/.emacs.d/eshell/aliases")
  :hook (eshell-first-time-mode . efs/configure-eshell))

(use-package eshell-git-prompt
  :config
  (eshell-git-prompt-use-theme 'robbyrussell))

(defun my/vterm-new ()
  "Open a new vterm"
  (interactive)
  )

(use-package vterm
  :hook
  (vterm-mode . evil-emacs-state)
  (vterm-copy-mode . meliache/evil-normal-in-vterm-copy-mode)
  :config
  (setq vterm-tramp-shells '(("docker" "/bin/bash")
                             ("ssh" "zsh")))
  (defun meliache/evil-normal-in-vterm-copy-mode ()
    (if (bound-and-true-p vterm-copy-mode)
        (evil-normal-state)
      (evil-emacs-state))))

(provide 'init-shell)
