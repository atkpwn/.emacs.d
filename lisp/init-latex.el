(use-package tex-site
  :ensure auctex
  :mode ("\\.tex\\'" . LaTeX-mode)
  :hook
  (LaTeX-mode . (lambda ()
                  (smartparens-mode)
                  (prettify-symbols-mode 1)
                  (linum-on)
                  (visual-line-mode)
                  (LaTeX-math-mode)
                  (setq TeX-master (guess-TeX-master (buffer-file-name)))))
  :config
  (defun guess-TeX-master (filename)
    ;; From https://www.emacswiki.org/emacs/AUCTeX#toc22
    "Guess the master file for FILENAME from currently open .tex files."
    (let ((candidate nil)
          (filename (file-name-nondirectory filename)))
      (save-excursion
        (dolist (buffer (buffer-list))
          (with-current-buffer buffer
            (let ((name (buffer-name))
                  (file buffer-file-name))
              (if (and file (string-match "\\.tex$" file))
                  (progn
                    (goto-char (point-min))
                    (if (re-search-forward (concat "\\\\input{" filename "}") nil t)
                        (setq candidate file))
                    (if (re-search-forward (concat "\\\\include{" (file-name-sans-extension filename) "}") nil t)
                        (setq candidate file))))))))
      (if candidate
          (message "TeX master document: %s" (file-name-nondirectory candidate)))
      candidate))

  (setq TeX-PDF-mode t
        TeX-auto-save t
        TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq TeX-source-correlate-method 'synctex
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t)
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (add-hook 'TeX-after-compilation-finished-functions #'TeX-revert-document-buffer)
  (autoload 'predictive-mode "predictive" "predictive" t)
  (set-default 'predictive-auto-add-to-dict t)
  (setq predictive-main-dict 'rpg-dictionary
        predictive-auto-learn t
        predictive-add-to-dict-ask nil
        predictive-use-auto-learn-cache nil
        predictive-which-dict t))

(use-package reftex
  :hook
  (LaTeX-mode . (lambda ()
                  (turn-on-reftex)
                  (reftex-isearch-minor-mode)))
  :config
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-cite-prompt-optional-args t))

(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-tools-install)
  :config
  (pdf-loader-install))

(provide 'init-latex)
