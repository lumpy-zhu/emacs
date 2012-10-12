
;;; yasnippet site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/yasnippet")
(autoload 'yas/initialize "yasnippet" "Do necessary initialization.")
(autoload 'yas/load-directory "yasnippet"
  "Load snippet definition from a directory hierarchy." t)
