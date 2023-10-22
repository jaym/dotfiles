(use-package general
             :config
             (general-evil-setup)
             (general-create-definer my/leader-def
                                     :states '(normal insert visual emacs)
                                     :keymaps 'override
                                     :prefix "SPC"
                                     :global-prefix "M-SPC"))

(use-package hydra)

;; Wait until general is ready and configured so that future
;; uses of :general in use-package as well as the definer
;; can be used immediately.
(elpaca-wait)

(my/leader-def "u" 'universal-argument)
(global-set-key (kbd "C-M-u") 'universal-argument)

(use-package which-key
  :init
    (which-key-mode 1)
  :config
  (setq which-key-side-window-location 'bottom
          which-key-sort-order #'which-key-key-order-alpha
          which-key-sort-uppercase-first nil
          which-key-add-column-padding 1
          which-key-max-display-columns nil
          which-key-min-display-lines 6
          which-key-side-window-slot -10
          which-key-side-window-max-height 0.25
          which-key-idle-delay 0.8
          which-key-max-description-length 25
          which-key-allow-imprecise-window-fit t
          which-key-separator " → " ))


(provide 'init-keybindings)
