(use-package tramp
  ;; Consider adding the following to .bash_profile of the server:
  ;; if test "$TERM" = "dumb"; then
  ;;     export PS1="> "
  ;; fi
  :custom
  (tramp-password-prompt-regexp
   (concat
    "^.*"
    (regexp-opt
     '(;; OTP
       "OTP"
       ;; English
       "password" "Password"
       ;; Deutsch
       "passwort" "Passwort")
     t)
    ".*:\0? *"))
  )

(provide 'init-tramp)
