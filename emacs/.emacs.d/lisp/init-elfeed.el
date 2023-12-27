
(use-package elfeed
  :bind (("C-x w" . elfeed))
  :config
  (add-hook 'elfeed-new-entry-hook
	    (elfeed-make-tagger :feed-url "youtube\\.com"
				:add '(video youtube)))
  (setq elfeed-feeds
	'(
	  ("https://eli.thegreenplace.net/feeds/all.atom.xml" blog)
	  ("https://jvns.ca/atom.xml" blog)
	  ("https://fasterthanli.me/index.xml" blog)
	  ("https://simonwillison.net/atom/entries/" blog)
	  ("https://nullprogram.com/feed/" blog)
	  ("https://iximiuz.com/feed.atom" blog)
	  ("https://www.youtube.com/feeds/videos.xml?channel_id=UCZHmQk67mSJgfCCTn7xBfew" ml)
	  ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtAcpQcYerN8xxZJYTfWBMw" ml)
	  )))

(use-package elfeed-tube
  :ensure t ;; or :straight t
  :after elfeed
  :demand t
  :config
  ;; (setq elfeed-tube-auto-save-p nil) ; default value
  ;; (setq elfeed-tube-auto-fetch-p t)  ; default value
  (elfeed-tube-setup)

  :bind (:map elfeed-show-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)
         :map elfeed-search-mode-map
         ("F" . elfeed-tube-fetch)
         ([remap save-buffer] . elfeed-tube-save)))

(use-package elfeed-tube-mpv
  :ensure t ;; or :straight t
  :bind (:map elfeed-show-mode-map
              ("C-c C-f" . elfeed-tube-mpv-follow-mode)
              ("C-c C-w" . elfeed-tube-mpv-where)))

(provide 'init-elfeed)
