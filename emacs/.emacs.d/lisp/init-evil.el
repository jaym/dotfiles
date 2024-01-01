(use-package evil
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-integration t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-u-delete t)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  ;; just in case anybody gets the idea to change the
  ;; default value to true
  (setq evil-want-Y-yank-to-eol nil)

  ;; I don't want C-a and C-e to be taken over in
  ;; insert mode
  (setq evil-insert-state-bindings
	`(([insert] . evil-enter-replace-state)
	  ("\C-q" . evil-quoted-insert)
	  ("\C-v" . evil-quoted-insert)
	  ("\C-o" . evil-execute-in-normal-state)
	  ("\C-r" . evil-paste-from-register)
	  ("\C-n" . evil-complete-next)	    ;; Completion commands
	  ("\C-p" . evil-complete-previous) ;; don't yet behave correctly
	  ("\C-x\C-n" . evil-complete-next-line) ;; in replace state
	  ("\C-x\C-p" . evil-complete-previous-line) ;; TODO - fix this
	  ("\C-t" . evil-shift-right-line)
	  ("\C-d" . evil-shift-left-line)
	  ([remap delete-backward-char] . evil-delete-backward-char-and-join)
	  ([S-left] . evil-backward-word-begin)
	  ([S-right] . evil-forward-word-begin)
	  ("\C-w" . evil-delete-backward-word)
	  ("\C-u" . evil-delete-back-to-indentation)
	  ([mouse-2] . mouse-yank-primary)))

  (evil-mode)

  (evil-define-key 'motion 'global (kbd "SPC") nil)
  :config
  (evil-define-command my/save-and-kill-buffer (file &optional bang)
    :repeat nil
    (interactive "<f><!>")
    (evil-write nil nil nil file bang)
    (kill-this-buffer))

  (evil-ex-define-cmd "q" 'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'my/save-and-kill-buffer)
  (evil-ex-define-cmd "Q" 'evil-quit))

(use-package undo-tree
  :after evil
  :diminish
  :init
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history nil)
  (evil-set-undo-system 'undo-tree))

(use-package evil-collection
  :after evil
  :config
  ;; (setq evil-collection-setup-minibuffer t)
  (setq evil-collection-mode-list (remove 'lispy evil-collection-mode-list))
  (evil-collection-init))

(use-package evil-set-option
  :after evil
  :ensure t
  :elpaca (evil-set-option
           :host github
           :repo "FrostyX/evil-set-option"
           :branch "display-fill-column-indicator-mode")
  :config
  (evil-set-option-mode))

(provide 'init-evil)
