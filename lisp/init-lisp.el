(use-package lisp-mode
  :init
  (defvar lisp--prettify-symbols-alist
    '(("lambda"  . ?λ)
      ("."       . ?•)))
  :hook
  ((emacs-lisp-mode lisp-mode) .
   (lambda ()
     (setq-local prettify-symbols-alist lisp--prettify-symbols-alist)
     (prettify-symbols-mode 1)
     (eldoc-mode 1))))

(use-package smartparens
  :config
  (sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
  (sp-local-pair 'lisp-mode       "'" nil :actions nil))

(provide 'init-lisp)
