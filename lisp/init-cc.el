(use-package cc-mode
  :disabled
  :hook
  ((c-mode   . lsp)
   (c++-mode . lsp))
  :init
  (require 'lsp)
  :config
  (setq c-default-style "google-c-style"))

(use-package google-c-style
  :ensure t
  :hook
  ((c-mode c++-mode) . google-set-c-style))

(use-package smartparens
  :config
  (setq-default sp-escape-quotes-after-insert nil))

(provide 'init-cc)
