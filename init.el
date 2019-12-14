(require 'package)
(setq inhibit-startup-message t
      package-user-dir "~/.emacs.d/site-packages"
      package-archives '(("org" . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(if (not package-archive-contents)
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; basic settings
(when (display-graphic-p)
  (setq initial-frame-alist '((width . 90)
                              (height . 50))))

(setq next-screen-context-lines (max 5 (round (* 0.6 50))))

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(when (string-equal system-type "gnu/linux")
  ;; font for Thai language
  (set-fontset-font t 'unicode "Norasi" nil 'prepend))

(fset 'yes-or-no-p 'y-or-n-p)
(show-paren-mode t)
(setq require-final-newline t
      load-prefer-newer t
      backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq initial-scratch-message ""
      visible-bell t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq w32-recognize-altgr nil)

;; For English keyboard intl., with AltGr dead keys
(global-set-key (kbd "œ") 'counsel-M-x)
;; end

;; appearance
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-eighties t)
  )

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  )

(use-package all-the-icons
  :ensure t
  :defer 0
  )

(use-package all-the-icons-ivy
  :ensure t
  :after all-the-icons
  :config
  (all-the-icons-ivy-setup)
  )

(use-package all-the-icons-dired
  :ensure t
  :after all-the-icons
  :hook
  (dired-mode . all-the-icons-dired-mode)
  )

(column-number-mode t)
;; end

;; misc. tools
(use-package saveplace
  :config
  (setq-default save-place t)
  (setq save-place-file (expand-file-name ".places" user-emacs-directory)))

(use-package rainbow-delimiters
  :ensure t
  :hook
  (emacs-lisp-mode . rainbow-delimiters-mode)
  (lisp-mode . rainbow-delimiters-mode))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package ido
  :disabled t
  :init
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer)
  :hook
  (ibuffer-mode . (lambda ()
                    (ibuffer-auto-mode 1)
                    (ibuffer-switch-to-saved-filter-groups "default")))
  :init
  (setq ibuffer-saved-filter-groups
        '(("default"
           ("dired" (mode . dired-mode))
           ("org" (name . "^.*org$"))
           ("magit" (mode . magit-mode))
           ("web" (or (mode . web-mode)
                      (mode . js2-mode)))
           ("shell" (or (mode . eshell-mode)
                        (mode . shell-mode)))
           ("programming" (or
                           (mode . python-mode)
                           (mode . c++-mode)
                           (mode . emacs-lisp-mode)
                           (mode . lisp-mode)))
           ("emacs" (or
                     (name . "^\\*Packages\\*$")
                     (name . "^\\*scratch\\*$")
                     (name . "^\\*Messages\\*$")
                     (name . "^\\*Error\\*$")
                     (name . "^\\*Warnings\\*$")))
           )))
  (setq ibuffer-show-empty-filter-groups nil
        ibuffer-expert t))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :config
  (global-undo-tree-mode 1)
  (defalias 'redo 'undo-tree-redo))

(use-package counsel
  :ensure t)

(use-package ivy
  :ensure t
  :after counsel
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map ivy-minibuffer-map
         ("C-l" . ivy-backward-delete-char))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-display-style 'fancy)
  )

(use-package swiper
  :ensure t
  :after ivy
  :bind ("C-s" . swiper)
  :config (progn
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

(use-package avy
  :ensure t
  :bind (("C-:" . avy-goto-char)
         ("C-S-j" . avy-goto-word-1))
  :config
  (setq avy-keys (number-sequence ?a ?z)))

(use-package ace-window
  :ensure t
  :bind
  ("C-x q" . ace-window))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :bind
  ("C-c p" . projectile-command-map)
  :config
  (counsel-projectile-mode 1))

(use-package expand-region
  :ensure t
  :bind
  ("C-=" . er/expand-region))

(use-package unfill
  :bind ([remap fill-paragraph] . unfill-toggle))
;; end

;; specific mode settings
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package ox-reveal
  :ensure t
  :defer
  :config
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  (setq org-reveal-mathjax t))
;; end

;; keep everything up to date!!
(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))
;; end
