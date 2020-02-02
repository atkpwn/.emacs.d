(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)
  (venv-workon "p3"))

(use-package py-autopep8
  :ensure
  :hook
  (python-mode . py-autopep8-enable-on-save))

(provide 'init-python)
