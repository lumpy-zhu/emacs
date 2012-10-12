
;;; auctex site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/auctex")
(require 'tex-site)

;; detect needed steps after rebuild
(setq TeX-parse-self t)
