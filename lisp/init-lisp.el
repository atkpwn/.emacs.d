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

(use-package paren
  :custom
  (show-paren-priority -1)
  :config
  (add-hook 'after-save-hook 'check-parens nil t)
  (setq show-paren-delay 0)
  (set-face-background 'show-paren-match (face-background 'default))
  (set-face-foreground 'show-paren-match "#afa")
  (set-face-attribute  'show-paren-match nil :weight 'extra-bold)
  (set-face-background 'show-paren-mismatch "#a33")
  (set-face-attribute  'show-paren-mismatch nil :weight 'extra-bold))

(provide 'init-lisp)
