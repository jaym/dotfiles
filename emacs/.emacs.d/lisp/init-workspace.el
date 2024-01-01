(use-package winner-mode
  :elpaca nil
  :hook (after-init . winner-mode)
  :config
  ;; Per-workspace `winner-mode' history
  (add-to-list 'window-persistent-parameters '(winner-ring . t)))

(use-package ace-window
  :bind (("M-o" . ace-window))
  :custom
  (aw-dispatch-alist
   '((?x aw-delete-window "Delete Window")
     (?m aw-swap-window "Swap Windows")
     (?M aw-move-window "Move Window")
     (?c aw-copy-window "Copy Window")
     (?j aw-switch-buffer-in-window "Select Buffer")
     (?n aw-flip-window)
     (?u aw-switch-buffer-other-window "Switch Buffer Other Window")
     (?c aw-split-window-fair "Split Fair Window")
     (?v aw-split-window-vert "Split Vert Window")
     (?s aw-split-window-horz "Split Horz Window")
     (?o delete-other-windows "Delete Other Windows")
     (?? aw-show-dispatch-help))
   aw-dispatch-always t)
  (aw-dispatch-always t)
  (aw-keys '(?a ?d ?f ?g ?h ?q ?w ?p ?y)))

;; (setq display-buffer-base-action
;;       '((display-buffer-reuse-window
;;          ace-display-buffer)))

;; (setq display-buffer-alist `(("\\*help\\[R" (display-buffer-reuse-mode-window
;;                                              ace-display-buffer)
;;                               (reusable-frames . nil))
;;                              ("\\*R" nil (reusable-frames . nil))
;;                              ,(cons "\\*helm" display-buffer-fallback-action)
;;                              ("magit-diff:" nil
;;                               (inhibit-same-window . t))))



(use-package consult
  :demand t
  :hook (completion-list-mode . consult-preview-at-point)
  :bind
  (
   ([remap repeat-complex-command] . consult-complex-command)
   ([remap switch-to-buffer] . consult-buffer)
   ([remap switch-to-buffer-other-window] . consult-buffer-other-window)
   ([remap switch-to-buffer-other-frame] . consult-buffer-other-frame)
   ([remap bookmark-jump] . consult-bookmark)
   ([remap project-switch-to-buffer] . consult-project-buffer)
   ([remap yank-pop] . consult-yank-pop)
   ([remap apropos] . consult-apropos)
   ([remap goto-line] . consult-goto-line)
   ([remap imenu] . consult-imenu)
   ([remap flymake-show-diagnostic] . consult-flymake)
   ([remap flymake-show-buffer-diagnostics] . consult-flymake)
   ([remap flymake-show-diagnostics-buffer] . consult-flymake)
   ([remap customize] . consult-customize)
   ([remap load-theme] . consult-theme)
   ([remap locate] . consult-locate)
   ([remap rgrep] . consult-grep)
   ([remap vc-git-grep] . consult-git-grep)
   ([remap isearch-forward] . consult-line)
   ([remap multi-occur] . consult-multi-occur)
   ([remap recentf-open-files] . consult-recent-file)
   ;; Custom M-# bindings for fast register access
   ("M-#" . consult-register-load)
   ("M-'" . consult-register-store) ;; orig. abbrev-prefix-mark (unrelated)
   ("C-M-#" . consult-register)
   ("M-g o" . consult-outline)	   ;; Alternative: consult-org-heading
   ("M-g m" . consult-mark)
   ("M-g i" . consult-imenu)
   ("M-g k" . consult-global-mark)
   ("M-g I" . consult-imenu-multi)
   ;; M-s bindings in `search-map'
   ("M-s d" . consult-find) ;; Alternative: consult-fd
   ("M-s c" . consult-locate)
   ("M-s g" . consult-grep)
   ("M-s G" . consult-git-grep)
   ("M-s r" . consult-ripgrep)
   ("M-s l" . consult-line)
   ("M-s L" . consult-line-multi)
   ("M-s k" . consult-keep-lines)
   ("M-s u" . consult-focus-lines)
   ;; Isearch integration
   ("M-s e" . consult-isearch-history)
   :map isearch-mode-map
   ("M-e" . consult-isearch-history) ;; orig. isearch-edit-string
   ("M-s e" . consult-isearch-history) ;; orig. isearch-edit-string
   ("M-s l" . consult-line)	;; needed by consult-line to detect isearch
   ("M-s L" . consult-line-multi) ;; needed by consult-line to detect isearch
   ;; Minibuffer history
   :map minibuffer-local-map
   ("M-s" . consult-history) ;; orig. next-matching-history-element
   ("M-r" . consult-history))
  :config
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
	xref-show-definitions-function #'consult-xref)
  (setq consult-narrow-key "<"))

(use-package consult-notes
  :elpaca (:type git :host github :repo "mclear-tools/consult-notes")
  :commands (consult-notes
	     consult-notes-search-in-all-notes)
  :config
  (setq consult-notes-org-headings-files '("~/sync/inbox.org"))
  (consult-notes-org-headings-mode)
  (consult-notes-denote-mode))

(use-package
  consult-tramp
  :elpaca (:host github :repo "Ladicle/consult-tramp")
  :after consult
  :bind ("C-c d t" . consult-tramp)
  :custom
  (consult-tramp-method "ssh")
  (consult-tramp-enable-shosts nil))


(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
  :config
  (setq projectile-project-search-path '("~/workspace/" "~/workspace/sandbox/" )))

(use-package consult-projectile
  :after consult
  :bind ((:map projectile-mode-map
	       ("M-p" . consult-projectile))
	 ([remap projectile-recentf] . consult-projectile-recentf)
	 ([remap projectile-switch-to-buffer] . consult-projectile-switch-to-buffer)
	 ([remap projectile-find-file] . consult-projectile-find-file)
	 ([remap projectile-find-dir] . consult-projectile-find-dir)
	 ([remap projectile-switch-project] . consult-projectile-switch-project)
	 ([remap projectile-grep] . consult-grep)
	 ([remap projectile-ripgrep] . consult-ripgrep)))

(use-package perspective
  :hook (after-init . persp-mode)
  :bind (("C-x C-b" . persp-ibuffer)
         ("C-x b" . persp-switch-to-buffer*)
         ("C-x k" . persp-kill-buffer*))
  :custom
  (persp-mode-prefix-key (kbd "C-x x"))
  (persp-initial-frame-name "main"))

(use-package persp-projectile
  :bind (:map projectile-mode-map
              ("C-x x S" . projectile-persp-switch-project)))

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

;; (use-package treemacs-magit
;;   :after (treemacs magit)
;;   :ensure t)

(use-package treemacs-perspective
  :after (treemacs perspective)
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package envrc
  :elpaca (envrc :host github :repo "siddharthverma314/envrc")
  :config
  (setq envrc-remote t)
  (envrc-global-mode))

(provide 'init-workspace)
