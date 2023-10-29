(use-package org
             :elpaca nil
             :custom
             (require 'org-protocol)
             (org-startup-indented t))

(use-package evil-org
             :after org
             :hook (org-mode . evil-org-mode)
             :config
             (require 'evil-org)
             (evil-org-set-key-theme '(navigation insert textobjects additional calendar))
             (require 'evil-org-agenda)
             (evil-org-agenda-set-keys)
             (evil-define-key 'normal 'evil-org-mode
                              (kbd "RET") 'org-open-at-point))

(use-package toc-org
             :commands toc-org-enable
             :init (add-hook 'org-mode-hook 'toc-org-enable))


;; | Typing the below + TAB | Expands to ...         |
;; | <a                     | BEGIN_EXPORT           |
;; | <c                     | BEGIN_CENTER           |
;; | <C                     | BEGIN_CENTER           |
;; | <e                     | BEGIN_EXAMPLE          |
;; | <E                     | BEGIN_EXPORT           |
;; | <h                     | BEGIN_EXPORT html      |
;; | <l                     | BEGIN_EXPORT latex     |
;; | <q                     | BEGIN_QUOTE            |
;; | <s                     | BEGIN_SRC              |
;; | <v                     | BEGIN_VERSE            |
;; | <el                    | #+BEGIN_SRC emacs-lisp |

(use-package org-tempo
             :elpaca nil
             :after org
             :config
             (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp")))

(use-package org-protocol-capture-html
  :elpaca (:host github :repo "alphapapa/org-protocol-capture-html"))

(use-package org-capture
  :after org-protocol-capture-html
  :elpaca nil
  :ensure nil
  :bind ("C-c c" . org-capture)
  :bind ("C-c l" . org-store-link)
  :config
  (defun transform-square-brackets-to-round-ones(string-to-transform)
    "Transforms [ into ( and ] into ), other chars left unchanged."
    (concat 
     (mapcar #'(lambda (c) (if (equal c ?[) ?\( (if (equal c ?]) ?\) c))) string-to-transform))
    )
  
  (require 'org-protocol-capture-html)
  (setq org-capture-templates 
    '(("w" "Work Task" entry (file "~/sync/work.org") "* TODO %?" :empty-lines 1)
      ("p" "Protocol")
      ("pw" "Protocol" entry (file+headline "~/sync/inbox.org" "Inbox")
        "* %a\n:PROPERTIES:\n:CREATED: %U\n:Source: %:link\n:END:\n\n%?\n%:initial" :empty-lines 1)
      ("ps" "Protocol" entry (file+headline "~/sync/inbox.org" "Inbox")
        "* %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:Source: %:link\n#+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n%?" :empty-lines 1)
      ("pL" "Link from browser" entry (file+headline "~/sync/links.org" "Links")
       "* [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]] :BOOKMARK:\n:PROPERTIES:\n:CREATED: %U\n:Source: %:link\n:END:\n%i\n%?\n" :empty-lines 1))))


(use-package org-modern
             :ensure t
             :custom
             (org-modern-hide-stars nil) ; adds extra indentation
             (org-modern-table nil)
             (org-modern-list 
               '(;; (?- . "-")
                 (?* . "•")
                 (?+ . "‣")))
             :hook
             (org-mode . org-modern-mode)
             (org-agenda-finalize . org-modern-agenda))

(use-package org-modern-indent
             :elpaca (org-modern-indent :host github :repo "jdtsmith/org-modern-indent")
             :config
             (add-hook 'org-mode-hook #'org-modern-indent-mode 90))

(use-package denote
  :after
  consult
  :general
  (my/leader-def
    "n" '(:ignore t :wk "notes")
    "n n" '(denote-create-note :wk "New note") 
    "n o" '(denote-open-or-create :wk "Open note")
    "n l" '(denote-add-links :wk "Add links")
    "n L" '(denote-add-missing-links :wk "Add missing links")
    "n b" '(denote-show-backlinks-buffer :wk "Show backlinks"))
  :custom
  (denote-directory (expand-file-name "~/sync/notes"))
  (denote-known-keywords '("emacs" "programming" "linux" "k8s" "deeplearning"))
  :config
  (add-hook 'dired-mode-hook 'denote-dired-mode))

(provide 'init-org)
