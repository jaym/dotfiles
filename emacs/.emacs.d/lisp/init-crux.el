
(defun my/crux-vterm (buffer-name)
  (vterm buffer-name))

(use-package crux
  :ensure t
  :bind (("C-c n" . crux-cleanup-buffer-or-region)
	 ("C-c f" . crux-recentf-ido-find-file)
	 ("C-M-z" . crux-indent-defun)
	 ("C-c u" . crux-view-url)
	 ("C-c e" . crux-eval-and-replace)
	 ("C-c w" . crux-swap-windows)
	 ("C-c D" . crux-delete-file-and-buffer)
	 ("C-c r" . crux-rename-buffer-and-file)
	 ("C-c t" . crux-visit-term-buffer)
	 ("C-c k" . crux-kill-other-buffers)
	 ("C-c TAB" . crux-indent-rigidly-and-copy-to-clipboard)
	 ("C-c s" . crux-ispell-word-then-abbrev))
  :config
  (setq crux-term-func #'my/crux-vterm)
  (crux-reopen-as-root-mode 1)
  (setq crux-term-buffer-name "multi"))

(provide 'init-crux)
