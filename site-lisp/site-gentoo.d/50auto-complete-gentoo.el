
;;; auto-complete site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/auto-complete")
(autoload 'auto-complete-mode "auto-complete" "AutoComplete mode" t)
(setq ac-dictionary-directories "/usr/share/emacs/etc/auto-complete/dict")
