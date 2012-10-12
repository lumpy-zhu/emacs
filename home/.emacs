
                                        ;=== global ===
;; 关闭启动消息
(setq inhibit-startup-message t)

;; 名字太长不好.
(fset 'yes-or-no-p 'y-or-n-p)

;; 我不需要backup文件,我都是用git管理的
(setq make-backup-files nil)

;; 哥对大小写是敏感的,我希望emacs也是
(setq case-fold-search t)

;; 我喜欢tab是4字节的
(setq tab-width 4)
(setq default-tab-width 4)
(setq tab-stop-list 
	  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216 220 224 228 232 236 240))

;; 神马,50步笑100步,我要后退一亿步的
(setq undo-outer-limit  256000000) ; 256M
(setq undo-strong-limit 64000000)  ; 64M
(setq undo-limit		32000000)  ; 32M
(setq minibuffer-max-depth nil)

										;=== minor modes ===
;; 列号显示
(column-number-mode t)
;; 有色模式
(global-font-lock-mode t)
;; 行号
(global-linum-mode t)
;; 括号配对显示
(setq skeleton-pair t)
(show-paren-mode t)

                                        ;=== key-bindings ===
;; 关于搜索的快捷键和缩写名
(global-set-key [?\H-g] 'goto-line)
(global-set-key [?\H-s] 'isearch-forward-regexp)
(global-set-key [?\H-r] 'isearch-backward-regexp)
(global-set-key [?\H-f] 'forward-word)
(global-set-key [?\H-b] 'backward-word)
(fset 'sr 'isearch-forward-regexp)		;; Search Regexp
(fset 'rs 'replace-string)				;; Replace String
(fset 'rr 'replace-regexp)				;; Replace Regexp

;; 成对输入的()[]{}""
(global-set-key [?\(]   'skeleton-pair-insert-maybe)
(global-set-key [?\[]   'skeleton-pair-insert-maybe)
(global-set-key [?\"]   'skeleton-pair-insert-maybe)
(global-set-key [?\{]   'skeleton-pair-insert-maybe)


										;=== lisps ===
;; emacs的undo和redo是很坑爹的,必须处理一下.
(require 'redo+)
(setq undo-no-redo t)
(global-set-key [?\H-\[] 'undo)
(global-set-key [?\H-\]] 'redo)

;; 查找一样坑爹,有时我只是想看看某个字符都在哪里出现了,并不是希望光标跳过去.
(require 'highlight-symbol)
(global-set-key [?\H-l]	 'highlight-symbol-at-point)
(global-set-key [?\H-n]	 'highlight-symbol-next)
(global-set-key [?\H-p]	 'highlight-symbol-prev)

;; 就是建文件的模板,我目前没配置这个东西.
(require 'file-template)

;; 这是个强大的东西,自动补全
(require 'auto-complete)
(auto-complete-mode t)

;; 输入cc,会编译当前文件~. 有makefile就用make,没有就调用一些默认的编译命令,比如gcc
(require 'smart-compile+)
(fset 'cc 'smart-compile)

										;=== tramp ===
;; 远程编辑的. 也是打开sudo的好工具. 比如/sudo::/etc/make.conf就可以的.
(require 'tramp)
(setq tramp-default-method "sudo")
(setq tramp-default-host   "localhost")
(setq tramp-default-user   "root")


                                        ;=== Mode ===
;; 关联扩展名
(autoload 'd-mode       "d-mode"        "Major 
mode for editing D code." t)
(autoload 'yaml-mode    "yaml-mode"     "Major mode for editing yaml script" t)
(setq auto-mode-alist
      (append
       '(("\\.d$"               . d-mode)
		 ("wscript"             . python-mode)
		 ("SConstruct"          . python-mode)
		 ("\\.[Cc][uUcC]$"      . c++-mode)
		 ("\\.[hk]$"            . c++-mode)
		 ("\\.y\\(a\\)?ml$"     . yaml-mode)
		 ("\\.m$"               . octave-mode)
		 )
       auto-mode-alist))

										;=== look & feel ===
;; 中文用Microsoft Yahei显示
(set-fontset-font t 'han "Microsoft YaHei")

;; 定义一个新字体显示的函数(这里只定义了前景色)
(defun new-face (face color )
  "Create a face from a color"
  (make-face face)
  (set-face-foreground face color))

;; 定义个字体
(new-face 'font-lock-number-face "violet")

										;=== modes ===
;; c++
;; 我的c++配置文件
(require 'lumpy-c++)

;; LaTeX
;; 这个和大家的一样
(add-hook 
 'LaTeX-mode-hook
 (lambda ()
   (setq TeX-auto-untabify t)
   (setq TeX-engine 'xetex)
   (setq TeX-show-compilation t)
   (setq Tex-auto-save t)
   (setq Tex-parse-self t)
   (setq TeX-save-query nil)
   (setq Tex-electric-escape t)
   (setq Tex-parse-self t)

   (turn-on-reftex)
   (TeX-global-PDF-mode t)
   (LaTex-math-mode t)
   (imenu-add-menubar-index)

   (define-key LaTeX-mode-map [?\s-e]	'LaTeX-environment)
   (define-key LaTeX-mode-map [?\s-j]	'LaTeX-insert-item)
   (define-key LaTeX-mode-map [?\s-s]	'Later-section)
   (define-key LaTeX-mode-map [?\s-\*]	'LaTeX-mark-section)
   (define-key LaTeX-mode-map [?\s-\.]	'LaTeX-mark-environment)
   (define-key LaTeX-mode-map [?\s-\]]	'LaTeX-close-environment)
   ))

										;=== indent ===
;; 使用astyle,可以格式化源代码
(defun astyle-region (pmin pmax)
  (interactive "r")
  (shell-command-on-region pmin pmax
                           "astyle"
                           (current-buffer) t 
                           (get-buffer-create "*Astyle Errors*") t))



