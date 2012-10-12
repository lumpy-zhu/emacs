
;;; cmake site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/cmake")
(autoload 'cmake-mode "cmake-mode" "Major mode for editing CMake files." t)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))
