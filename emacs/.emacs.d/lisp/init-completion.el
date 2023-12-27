(use-package consult
        :demand t
        :hook (completion-list-mode . consult-preview-at-point)
        :config
        (setq consult-narrow-key "<"))

(use-package consult-notes
  :elpaca (:type git :host github :repo "mclear-tools/consult-notes")
  :commands (consult-notes
             consult-notes-search-in-all-notes)
  :config
  (setq consult-notes-org-headings-files '("~/sync/inbox.org"))
  (consult-notes-org-headings-mode)
  (consult-notes-denote-mode))

(use-package company
  :bind (("M-/" . #'company-complete-common-or-cycle)
	 ("<tab>" . #'company-complete-common-or-cycle))
  ((:map company-active-map
	 ("C-w" . nil)
	 ("M-." . #'company-show-location)
	 ("<tab>" . #'company-complete)))
  :custom
  (company-tooltip-align-annotations t "aligns annotation to the right")
  (company-tooltip-limit 12 "bigger popup window")
  (company-idle-delay .5 "decrease delay before autocompletion popup shows")
  (company-minimum-prefix-length 1)
  (company-require-match nil)
  (company-dabbrev-ignore-case nil)
  (company-dabbrev-downcase nil)
  (company-global-modes '(not erc-mode message-mode help-mode gud-mode eshell-mode shell-mode))
  :config
  (global-company-mode))

(use-package company-statistics
  :hook (company-mode . company-statistics-mode))

(use-package company-quickhelp
  :hook (company-mode . company-quickhelp-mode))

(use-package company-box
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-scrollbar nil))

(use-package hotfuzz)

(use-package orderless
  :ensure t)

(setq completion-styles '(hotfuzz orderless basic)
        completion-category-defaults nil
        orderless-matching-styles '(orderless-flex)
        completion-category-overrides '((file (styles partial-completion))))

;; Add extensions
(use-package cape
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion functions takes precedence over the global list.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-emoji))

(provide 'init-completion)
