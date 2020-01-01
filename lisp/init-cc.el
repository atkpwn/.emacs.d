(use-package cc-mode
  :defer t
  :hook
  ((c-mode . lsp)
   (c++-mode . lsp))
  :init
  (require 'lsp)
  :config
  (setq c-default-style "stroustrup")
  )

(provide 'init-cc)
