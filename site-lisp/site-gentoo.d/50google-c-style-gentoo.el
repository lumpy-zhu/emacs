
;;; google-c-style site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/google-c-style")
(autoload 'google-set-c-style "google-c-style"
  "Set the current buffer's c-style to Google C/C++ Programming Style." t)
(autoload 'google-make-newline-indent "google-c-style"
  "Sets up preferred newline behavior." t)
