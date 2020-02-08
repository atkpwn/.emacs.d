(use-package org
  :ensure t
  :init
  (defvar org--prettify-symbols-alist
    '(("#+BEGIN_SRC" . ?↧)
      ("#+END_SRC"   . ?↥)))
  :hook
  (org-mode . (lambda ()
                (setq-local prettify-symbols-alist org--prettify-symbols-alist)
                (prettify-symbols-mode 1)
                (eldoc-mode 1)))
  :custom
  (org-confirm-babel-evaluate nil)
  :config
  (setq org-hide-emphasis-markers t)
  (eval-after-load 'org-src
    '(define-key org-src-mode-map
       (kbd "C-x C-s") '(lambda ()
                          (interactive)
                          (org-edit-src-save)
                          (save-buffer))))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell      . t)
     (python     . t)))
  (add-to-list 'org-babel-default-header-args:python
               '(:results . "output")))

(use-package org-bullets
  :ensure t
  :hook
  (org-mode . org-bullets-mode))

(provide 'init-org)
