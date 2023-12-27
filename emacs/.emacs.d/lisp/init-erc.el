(use-package erc
  :ensure t
  :config
  (setq erc-nick "jaym"
	erc-user-full-name "Jay M"
	erc-fill-column 80
	erc-fill-function 'erc-fill-static
	erc-fill-static-center 20
	erc-track-position-in-mode-line nil
	erc-join-buffer 'bury
	erc-track-exclude-server-buffer t
	erc-track-visibility nil))

(use-package erc-image
  :ensure t
  :after erc
  :config
  (setq erc-image-inline-rescale 300)
  (add-to-list 'erc-modules 'image))

(use-package znc
  :after erc
  :commands (znc-erc znc-all)
  :init
  (setq my/znc-networks '(oftc))
  (let* ((password (secrets-get-secret "Login" "ZNC-mars"))
         (define-net (lambda (net)
                       (list net (concat "jaym/" (symbol-name net) ) password))))
    (setq znc-servers
          (list (list "mars.local" 5000 t (mapcar define-net my/znc-networks))))))

(provide 'init-erc)
