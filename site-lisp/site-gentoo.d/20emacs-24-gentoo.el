
;;; emacs-24 site-lisp configuration

(when (string-match "\\`24\\.2\\>" emacs-version)
  ;;(setq find-function-C-source-directory
  ;;      "/usr/share/emacs/24.2/src")
  (let ((path (getenv "INFOPATH"))
	(dir "/usr/share/info/emacs-24")
	(re "\\`/usr/share/info\\>"))
    (and path
	 ;; move Emacs Info dir before anything else in /usr/share/info
	 (let* ((p (cons nil (split-string path ":" t))) (q p))
	   (while (and (cdr q) (not (string-match re (cadr q))))
	     (setq q (cdr q)))
	   (setcdr q (cons dir (delete dir (cdr q))))
	   (setq Info-directory-list (prune-directory-list (cdr p)))))))
