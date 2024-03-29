;; (use-package modus-themes
;;   :defer t
;;   :custom
;;   (modus-themes-completions
;;    '((matches . (extrabold background intense))
;;      (selection . (semibold accented intense))
;;      (popup . (accented))
;;      (t . (extrabold intense))))
;;   (modus-themes-org-blocks 'tinted-background)
;;   (modus-themes-mixed-fonts t)
;;   (modus-themes-headings
;;    '((0 . (1.4))
;;      (1 . (1.4))
;;      (2 . (1.1))
;;      (t . (1.05))))
;;   (modus-themes-common-palette-overrides
;;    '((cursor pink)
;;      (fg-heading-0 magenta-warmer)
;;      (bg-heading-0 bg-magenta-nuanced)

;;      (fg-heading-1 magenta-warmer)

;;      (fg-heading-2 blue-warmer)

;;      (fg-heading-3 cyan-warmer)))
  
  
;;   (modus-themes-bold-constructs t)
;;   (modus-themes-italic-constructs t))

;; (defun me/init-theme ()
;;   (load-theme 'modus-operandi-tinted t))

;; (add-hook 'emacs-startup-hook #'me/init-theme)

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-selenized-light t))

(use-package persistent-soft
  :demand t)
(use-package unicode-fonts
  :demand t
  :after persistent-soft
  :config
  (unicode-fonts-setup))

(use-package all-the-icons
  :custom
  (all-the-icons-scale-factor 1))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(set-face-attribute 'default nil
                    :font "Hack"
                    :height 140
                    :weight 'light)
;; ;; Makes commented text and keywords italics.
;; ;; This is working in emacsclient but not emacs.
;; ;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
                    :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
                    :slant 'italic)

(defun jdm/set-font-faces ()
  (message "Setting faces!")
  (set-face-attribute 'default nil :font "Fira Code Retina" :height 130)

  ;; Set the fixed pitch face
  (set-face-attribute 'fixed-pitch nil :font "Fira Code Retina" :height 130)

  ;; Set the variable pitch face
  (set-face-attribute 'variable-pitch nil :font "Cantarell" :height 140 :weight 'regular))

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame
                  (jdm/set-font-faces))))
    (jdm/set-font-faces))


;; Use hydras for zooming
(defhydra hydra-zoom ()
  "zoom"
  ("g" text-scale-increase "in")
  ("l" text-scale-decrease "out")
  ("r" (text-scale-set 0) "reset"))

(my/leader-def "z" '(hydra-zoom/body :which-key "zoom"))


;; Enable vertico
(use-package vertico
  :bind
  ((:map vertico-map
	 ("C-u" . 'evil-delete-back-to-indentation)
	 ("C-n" . 'vertico-next)
	 ("C-p" . 'vertico-previous)
	 ("C-k" . 'vertico-previous)
	 ("C-j" . 'vertico-next)))
  :init
  (vertico-mode)
  (vertico-mouse-mode)
  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t))


;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package all-the-icons-completion
  :after all-the-icons
  :config
  (add-hook 'marginalia-mode-hook #'all-the-icons-completion-mode)
  (all-the-icons-completion-mode))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-buffer-enable nil)
  (setq doom-modeline-project-detection 'auto)
  (setq doom-modeline-icon t))

(setq scroll-margin 7
      scroll-conservatively 7
      scroll-preserve-screen-position t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq display-line-numbers-width-start t)
(global-display-line-numbers-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)
(setq confirm-nonexistent-file-or-buffer nil)
(setq
 warning-suppress-log-types '((comp) (comp) (:warning))
 warning-suppress-types '((comp) (:warning)))

(setq inhibit-startup-screen t)

(provide 'init-ui)
