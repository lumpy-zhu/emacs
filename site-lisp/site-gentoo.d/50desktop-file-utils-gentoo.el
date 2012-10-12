
;;; desktop-file-utils site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/desktop-file-utils")
(autoload 'desktop-entry-mode "desktop-entry-mode" "Desktop Entry mode" t)
(add-to-list 'auto-mode-alist
 '("\\.desktop\\(\\.in\\)?$" . desktop-entry-mode))
(add-hook 'desktop-entry-mode-hook 'turn-on-font-lock)
