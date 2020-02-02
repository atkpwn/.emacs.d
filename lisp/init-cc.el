(use-package cc-mode
  :defer t
  :hook
  ((c-mode . lsp)
   (c++-mode . lsp))
  :init
  (require 'lsp)
  :config
  (setq c-default-style "stroustrup"))

(use-package smartparens
  :config
  (setq-default sp-escape-quotes-after-insert nil))

(provide 'init-cc)
