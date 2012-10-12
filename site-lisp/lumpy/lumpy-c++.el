(require 'google-c-style)

;; 定义}的行为,这个有点像visual studio所做的
(defun lumpy-newline-and-indent ()
  "auto insert new line when '}'"
  (interactive)
  (if (looking-at "}")
      (progn
    (newline-and-indent)
    (newline-and-indent)
    (previous-line)
    (indent-for-tab-command))
    (newline-and-indent)))


(defun lumpy-c++-mode()
  ;; ecb
  ;;(require 'ecb)
  
  ;; doxymacs
  ;; 这是文档注释的好工具
  (require 'doxymacs)
  (doxymacs-font-lock)
  (setq c-doc-comment-style '((c++-mode . gtkdoc)))

  ;; cscope
  ;; 虽说这个东西不怎么样,但是别的工具更不怎么样
  (require 'xcscope)

  ;; google c style
  ;; google的风格,很不错.
  (google-set-c-style)
  (google-make-newline-indent)

  ;; yasnippet
  ;; yas-bundle是我编译后的yasnippet,这样使用起来更快. 
  (require 'yas-bundle)
  (yas/minor-mode t)

  ;; auto-complete
  ;; clang使用编译器给出的补全,无疑是最为强大的.
  (auto-complete-mode t)
  (setq ac-use-quick-help nil)
  (require 'auto-complete-clang)
  (setq ac-clang-flags
    '("-stdlib=libc++"
      "-I."
      "-I.."
      "-I../include"
      "-I/opt/cuda/include"
      "-I/usr/local/include"
      "-I/usr/lib/clang/3.1/include"
      "-I/usr/include"
      ))
  ;; 自动补全的快捷键.
  ;; 我是不喜欢在出现.或是->时自动弹出补全的, 我只有我想要补全时,才会补全.
  (setq ac-auto-start nil)
  (define-key c-mode-base-map   [?\H-\-] 'ac-complete-clang)  
  (define-key ac-completing-map [return] 'ac-complete)
  (define-key ac-completing-map [tab]    'ac-expand)
  (define-key ac-completing-map [?\H-n]  'ac-next)
  (define-key ac-completing-map [?\H-p]  'ac-previous)

  ;; key-map
  ;; 还是快捷键
  (define-key c-mode-base-map [return]  'lumpy-newline-and-indent)
  (define-key c-mode-base-map [f5]  'gdb)
  (define-key c-mode-base-map [f7]  'smart-run)
  
  ;; 没办法,这东西需要定义2次!!!, .emacs定义的,在cc-mode里没用.
  (define-key c-mode-base-map [?\(] 'skeleton-pair-insert-maybe)
  (define-key c-mode-base-map [?\[] 'skeleton-pair-insert-maybe)
  (define-key c-mode-base-map [?\"] 'skeleton-pair-insert-maybe)
  (define-key c-mode-base-map [?\{] 'skeleton-pair-insert-maybe)

  ;; doxymacs
  ;; 自动插入注释的快捷键, 
  ;; 为什么是8呢, 因为2上面是@, 看起来有点像版权符号(我近视,所以像!), 那么这就是文件注释了
  ;; 为什么是8呢, 因为8上面是*, 这个看起来像 /** */ 就当成块注释好啦
  ;; 为什么是9呢, 因为9上面是(, 就当成函数注释好啦
  ;; 为什么是;呢, 因为这代表语句的结束,也就是在屁股后面加注释
  ;; 为什么是/呢, 这是普通单行注释了~
  (define-key c-mode-base-map [?\H-2]   'doxymacs-insert-file-comment)
  (define-key c-mode-base-map [?\H-8]  'doxymacs-insert-blank-multiline-comment)
  (define-key c-mode-base-map [?\H-9]   'doxymacs-insert-function-comment)
  (define-key c-mode-base-map [?\H-\;]  'doxymacs-insert-member-comment)
  (define-key c-mode-base-map [?\H-\/]  'doxymacs-insert-blank-singleline-comment)

  ;; hide-show mode
  ;; 代码折叠功能
  (hs-minor-mode)
  (define-key c-mode-base-map [?\s-s]   'hs-show-block)
  (define-key c-mode-base-map [?\s-h]   'hs-hide-block)

  ;; extra types
  ;; 有一些我经常用的类型,我都是把它们它成是内部类型的~, 请高亮它们
  (setq c++-font-lock-extra-types 
    (append 
     '("byte" "ubyte" "ushort" "ulong" "cfloat" "cdouble")	c++-font-lock-extra-types)))

;; extra types
;; 再添加一些需要高亮的东西. 这些正则表达式不怎么好写,有些我也没有写好.
(font-lock-add-keywords
 'c++-mode  
 '(("\\<__[0-9a-zA-Z_$]*__\\>"                              . font-lock-keyword-face)
   ("\\<[0-9][\s.0-9a-fA-FeExX]*\\>"                        . 'font-lock-number-face)
   ("\\<\\(typeof\\|decltype\\|auto\\|alias\\)\\>"          . font-lock-keyword-face)
   ("\\<\\(pure\\|restrict\\|elif\\)\\>"                    . font-lock-keyword-face)
   ("\\<\\(static_assert\\|assert\\|ensure\\|ensafe\\)\\>"  . font-lock-warning-face)
   ("\\<_n?\\(b\\|t\\)?\\(x\\|y\\|z\\)\\>"                  . font-lock-constant-face)))

;; lumpy mode
(add-hook 'c++-mode-hook 'lumpy-c++-mode)

(provide 'lumpy-c++)
