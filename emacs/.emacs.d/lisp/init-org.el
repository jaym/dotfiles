(use-package org
             :elpaca nil
             :custom
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

(use-package denote)

(provide 'init-org)
