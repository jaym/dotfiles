(setq tab-always-indent 'complete) ;; enable tab completion

(use-package consult
        :hook (completion-list-mode . consult-preview-at-point)
        :config
        (setq consult-narrow-key "<"))

(use-package corfu
             :hook
             (eval-expression-minibuffer-setup . corfu-mode)
             :init
             (global-corfu-mode) 
             :custom
             (corfu-cycle t) ;; allows cycling through candidates
             (corfu-auto nil) ;; disables auto-completion
             :bind
             (:map corfu-map ("SPC" . corfu-insert-separator)))



;; Add extensions
(use-package cape
             ;; Bind dedicated completion commands
             ;; Alternative prefix keys: C-c p, M-p, M-+, ...
             :bind (("C-c p p" . completion-at-point) ;; capf
                    ("C-c p t" . complete-tag)        ;; etags
                    ("C-c p d" . cape-dabbrev)        ;; or dabbrev-completion
                    ("C-c p h" . cape-history)
                    ("C-c p f" . cape-file)
                    ("C-c p k" . cape-keyword)
                    ("C-c p s" . cape-elisp-symbol)
                    ("C-c p e" . cape-elisp-block)
                    ("C-c p a" . cape-abbrev)
                    ("C-c p l" . cape-line)
                    ("C-c p w" . cape-dict)
                    ("C-c p :" . cape-emoji)
                    ("C-c p \\" . cape-tex)
                    ("C-c p _" . cape-tex)
                    ("C-c p ^" . cape-tex)
                    ("C-c p &" . cape-sgml)
                    ("C-c p r" . cape-rfc1345))
             :init
             ;; Add to the global default value of `completion-at-point-functions' which is
             ;; used by `completion-at-point'.  The order of the functions matters, the
             ;; first function returning a result wins.  Note that the list of buffer-local
             ;; completion functions takes precedence over the global list.
             (add-to-list 'completion-at-point-functions #'cape-dabbrev)
             (add-to-list 'completion-at-point-functions #'cape-file)
             (add-to-list 'completion-at-point-functions #'cape-elisp-block)
             )

(provide 'init-completion)
