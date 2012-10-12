
;;; gtk-doc site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/gtk-doc")

(autoload 'gtk-doc-insert "gtk-doc"
  "Add a documentation header to the current function." t)
(autoload 'gtk-doc-insert-section "gtk-doc"
  "Add a section documentation header at the current position." t)
