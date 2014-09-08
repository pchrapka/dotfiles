;; -*- mode: emacs-lisp -*-
;; ;; Simple .emacs configuration

;; ;; ---------------------
;; ;; -- Global Settings --
;; ;; ---------------------
;; (add-to-list 'load-path "~/.emacs.d")
;; (require 'cl)
;; (require 'ido)
;; (require 'ffap)
;; (require 'uniquify)
;; (require 'ansi-color)
;; (require 'recentf)
;; (require 'linum)
;; (require 'smooth-scrolling)
;; (require 'whitespace)
;; (require 'dired-x)
;; (require 'compile)
;; (ido-mode t)
;; (menu-bar-mode -1)
;; (normal-erase-is-backspace-mode 1)
;; (put 'downcase-region 'disabled nil)
;; (put 'upcase-region 'disabled nil)
;; (setq column-number-mode t)
;; (setq inhibit-startup-message t)
;; (setq save-abbrevs nil)
;; (setq show-trailing-whitespace t)
;; (setq suggest-key-bindings t)
;; (setq vc-follow-symlinks t)

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:inherit autoface-default :strike-through nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
;;  '(column-marker-1 ((t (:background "red"))))
;;  '(diff-added ((t (:foreground "cyan"))))
;;  '(flymake-errline ((((class color) (background light)) (:background "Red"))))
;;  '(font-lock-comment-face ((((class color) (min-colors 8) (background light)) (:foreground "red"))))
;;  '(fundamental-mode-default ((t (:inherit default))))
;;  '(highlight ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
;;  '(isearch ((((class color) (min-colors 8)) (:background "yellow" :foreground "black"))))
;;  '(linum ((t (:foreground "black" :weight bold))))
;;  '(region ((((class color) (min-colors 8)) (:background "white" :foreground "magenta"))))
;;  '(secondary-selection ((((class color) (min-colors 8)) (:background "gray" :foreground "cyan"))))
;;  '(show-paren-match ((((class color) (background light)) (:background "black"))))
;;  '(vertical-border ((t nil)))
;; )

;; ;; ------------
;; ;; -- Macros --
;; ;; ------------
;; (load "defuns-config.el")
;; (fset 'align-equals "\C-[xalign-regex\C-m=\C-m")
;; (global-set-key "\M-=" 'align-equals)
;; (global-set-key "\C-x\C-m" 'execute-extended-command)
;; (global-set-key "\C-c;" 'comment-or-uncomment-region)
;; (global-set-key "\M-n" 'next5)
;; (global-set-key "\M-p" 'prev5)
;; (global-set-key "\M-o" 'other-window)
;; (global-set-key "\M-i" 'back-window)
;; (global-set-key "\C-z" 'zap-to-char)
;; (global-set-key "\C-h" 'backward-delete-char)
;; (global-set-key "\M-d" 'delete-word)
;; (global-set-key "\M-h" 'backward-delete-word)
;; (global-set-key "\M-u" 'zap-to-char)


;;;;;;;;;;;;;;;;;;
;;
;; Setup package archives and cleanup
;;
;;;;;;;;;;;;;;;;;;

(setq debug-on-error t)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)

  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  )
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;; Not using melpa becuase of issue with org-trello

;; remove org-mode shipped with emacs from the load-path
(require 'cl)
(setq load-path (remove-if (lambda (x) (string-match-p "org$" x)) load-path))

;;;;;;;;;;;;;;;;;;
;;
;; el-get
;; Fetch, Install, Update, etc
;;
;;;;;;;;;;;;;;;;;;

;;(setq el-get-verbose t) ;; for debugging

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(progn (print "here"))
(el-get 'sync)

(setq el-get-user-package-directory "~/.emacs.d/el-get-user/packages")

(setq el-get-sources
      '(
	(:name cdlatex-mode
	       :after (progn
			(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex) ; with AUCTeX LaTeX mode 
			(add-hook 'latex-mode-hook 'turn-on-cdlatex) ; with Emacs latex mode
			))
      ))

(setq my-packages
      (append
       '(el-get 
	 	escreen
	 	color-theme
	 	color-theme-solarized
	 	switch-window 
	 	hl-line+
	 	fuzzy
	 	smex)
       (mapcar 'el-get-source-name el-get-sources)))
(progn (print 'my-packages))
(progn (print 'el-get-sources))

;; Other packages
;;zenburn-theme
;;color-theme-solarized

(el-get 'sync my-packages)

;;;;;;;;;;;;;;;;;;
;;
;; Color theme
;;
;;;;;;;;;;;;;;;;;;

;;(load-theme 'zenburn t)
(load-theme 'solarized-dark t)  ;;ends up being gray in cygwin, no solution found


;;;;;;;;;;;;;;;;;;
;;
;; hl-line
;;
;;;;;;;;;;;;;;;;;;
;;(set-face-background hl-line-face "gray13")
(global-hl-line-mode t) ; turn it on for all modes by default

;;;;;;;;;;;;;;;;;;
;;
;; Latex
;;
;;;;;;;;;;;;;;;;;;


;; Load Auctex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(require 'tex-mik)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

;; Turn on Reftex by default
(setq reftex-enable-partial-scans t)
(setq reftex-save-parse-info t)
(setq reftex-use-multiple-selection-buffers t)
(setq reftex-plug-into-AUCTeX t)
(setq bib-cite-use-reftex-view-crossref t) 
;; FIXME
;;(setq reftex-bibpath-environment-variables
;;               '("/cygdrive/c/Users/Phil/Documents/School/References/"))

;; Makes emacs notice changes made on disk			
(global-auto-revert-mode t)

;;;;;;;;;;;;;;;;;;
;;
;; Org-mode
;;
;;;;;;;;;;;;;;;;;;

;; Getting a copy
;; cd ~
;; git clone git://orgmode.org/org-mode.git
;; Get the tags
;; git fetch --tags
;; git tag
;; git checkout release_7.02
;;
;; Or always run the stable release
;; git checkout -b stable origin/maint
;; git pull
;;
;; Update instructions
;; git pull
;; make uncompiled

;; FIXME
;;(add-to-list 'load-path (expand-file-name "~/org-mode/lisp"))
;; FIXME
;;(load-file "~/.emacs.d/el-get-user/packages/init-org-mode.el")

;; TODO Move init-org-mode.el somewhere else
