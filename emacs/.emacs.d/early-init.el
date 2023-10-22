(setq user-emacs-cache-directory (expand-file-name "~/.cache/emacs/"))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name  "var/eln-cache/" user-emacs-cache-directory))))

