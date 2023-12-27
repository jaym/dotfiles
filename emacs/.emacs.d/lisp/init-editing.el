(setq-default fill-column 80)

(add-hook 'text-mode-hook 'visual-line-mode)

(use-package evil-nerd-commenter
  :after evil
  :general
  (my/comma-leader-def "c" '(:wk "comment")
                 "c <SPC>" '(evilnc-comment-or-uncomment-lines :wk "Toggle Lines")
                 "cp" '(evilnc-comment-or-uncomment-paragraphs :wk "Toggle Paragraph")
                 "c\\" '(evilnc-comment-operator :wk "Operator")))

(provide 'init-editing)
