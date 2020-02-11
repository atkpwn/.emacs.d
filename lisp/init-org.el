(use-package org
  :ensure t
  :init
  (defvar org--prettify-symbols-alist
    '(("#+BEGIN_SRC" . ?↧)
      ("#+END_SRC"   . ?↥)))
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture)
   :map org-src-mode-map
   ("C-x C-s" . (lambda ()
                  (interactive)
                  (org-edit-src-exit)
                  (save-buffer))))
  :hook
  (org-mode . (lambda ()
                (setq-local prettify-symbols-alist org--prettify-symbols-alist)
                (prettify-symbols-mode 1)
                (eldoc-mode 1)))
  :custom
  (org-confirm-babel-evaluate nil)
  (org-hide-emphasis-markers nil)
  (org-log-done t)
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell      . t)
     (python     . t)))
  (add-to-list 'org-babel-default-header-args:python
               '(:results . "output"))
  (defhydra hydra-org-motion (org-mode-map "C-c")
    "org hydra"
    ("p" org-previous-visible-heading "previous visible heading")
    ("n" org-next-visible-heading     "next visible heading")))

(use-package org-bullets
  :ensure t
  :hook
  (org-mode . org-bullets-mode))

(provide 'init-org)
