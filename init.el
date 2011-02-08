;; Disable ridiculous looking scrollbar
(scroll-bar-mode -1)
;; Disable stupid toolbar
(tool-bar-mode -1)
;"y and n" instead of Yes and No
(fset 'yes-or-no-p 'y-or-n-p)
;show matching paranthesis
(show-paren-mode t)
;set default font size
(set-face-attribute 'default nil :height 80)
;shell color mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

; change font size
(defun sacha/increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun sacha/decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                  (face-attribute 'default :height)))))
(global-set-key (kbd "C-+") 'sacha/increase-font-size)
(global-set-key (kbd "C--") 'sacha/decrease-font-size)

; copy - paste - emacs - other apps
(setq x-select-enable-clipboard t)

;; Get rid of the startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

; 80 column marker
;(add-to-list 'load-path "/home/deepans/tools/emacs-tools/column-marker")
;(require 'column-marker)

;; Highlight column 80 in python mode.
(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))

; Redo
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/redo")
(require 'redo+)
  (global-set-key (kbd "C-?") 'redo)

;; Kills live buffers, leaves some emacs work buffers
;; optained from http://www.chrislott.org/geek/emacs/dotemacs.html
(defun nuke-buffers (&optional list)
  "For each buffer in LIST, kill it silently if unmodified. Otherwise ask.
LIST defaults to all existing live buffers."
  (interactive)
  (if (null list)
      (setq list (buffer-list)))
  (while list
    (let* ((buffer (car list))
           (name (buffer-name buffer)))
      (and (not (string-equal name ""))
           ;(not (string-equal name "*Messages*"))
          ;; (not (string-equal name "*Buffer List*"))
           ;(not (string-equal name "*buffer-selection*"))
           ;(not (string-equal name "*Shell Command Output*"))
           (not (string-equal name "*scratch*"))
           (/= (aref name 0) ? )
           (if (buffer-modified-p buffer)
               (if (yes-or-no-p
                    (format "Buffer %s has been edited. Kill? " name))
                   (kill-buffer buffer))
             (kill-buffer buffer))))
    (setq list (cdr list))))

;; find-recursive
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/find-recursive")
(require 'find-recursive)

(add-to-list 'load-path "/home/deepans/tools/emacs-tools/anything/anything-config")
(require 'anything-config)

;; Ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;; js2-mode
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/js2-mode")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; Auto Indentation
;(define-key global-map (kbd "RET") 'newline-and-indent)

;; Paste with original indentations
(dolist (command '(yank yank-pop))
  (eval `(defadvice, command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode scheme-mode
						     haskell-mode ruby-mode
						     rspec-mode   python-mode
						     c-mode       c++-mode
						     objc-mode    latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))

;color-theme
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/color-theme-6.6.0")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (load-file "/home/deepans/tools/emacs-tools/color-theme-6.6.0/themes/color-theme-twilight.el")
     (color-theme-twilight)))

;; CEDET
(load-file "/home/deepans/tools/emacs-tools/cedet-1.0pre7/common/cedet.el")
(global-ede-mode 1)
(semantic-load-enable-code-helpers)
(global-srecode-minor-mode 1)

; ECB
(add-to-list 'load-path
	     "/home/deepans/tools/emacs-tools/ecb-2.40")
(require 'ecb)
;(require 'ecb-autoloads)
(setq ecb-layout-name "left14")
(setq ecb-layout-window-sizes (quote (("left14" (0.2564102564102564 . 0.6949152542372882) (0.2564102564102564 . 0.23728813559322035)))))
(setq ecb-source-path (quote ("/" "/home/deepans/Public")))

;; mumamo / nxhtml mode
(load "/home/deepans/tools/emacs-tools/nxhtml-2.08-100425/autostart.el")
(setq
      nxhtml-global-minor-mode t
      mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcome t
      indent-region-mode t
      rng-nxml-auto-validate-flag nil
      nxml-degraded t)
     (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))
; (setq mumamo-background-colors nil)
; (add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))


; yasnippet 0.6.1
(add-to-list 'load-path
           "/home/deepans/tools/emacs-tools/yasnippet-0.6.1")
    (require 'yasnippet-bundle) ;; not yasnippet-bundle
    (yas/initialize)
    (yas/load-directory "/home/deepans/tools/emacs-tools/yasnippet-0.6.1")

(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)

; Pymacs + Ropemacs
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/Pymacs-0.24-beta2")
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

; Python Electric Pairs
(add-hook 'python-mode-hook
     (lambda ()
      (define-key python-mode-map "\"" 'electric-pair)
      (define-key python-mode-map "\'" 'electric-pair)
      (define-key python-mode-map "(" 'electric-pair)
      (define-key python-mode-map "[" 'electric-pair)
      (define-key python-mode-map "{" 'electric-pair)))
(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))


; Python - bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda ()
     (define-key python-mode-map "\C-m" 'newline-and-indent)))

; Python - set indent to 4 chars
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; Pyflakes
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pyflakes" (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
(add-hook 'python-mode-hook 'flymake-mode)

; dont warn while killing python process
(add-hook 'inferior-python-mode-hook
          (lambda ()
            (set-process-query-on-exit-flag (get-process "Python") nil)))

; Auto complete
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "/home/deepans/tools/emacs-tools/auto-complete-1.3.1/dict")
(ac-config-default)

; Ruby-mode
(autoload 'ruby-mode "ruby-mode" "Major mode for editing ruby scripts" t)
(setq auto-mode-alist  (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("\\.rhtml$" . html-mode) auto-mode-alist))
(setq auto-mode-alist  (cons '("\\.erb$" . ruby-mode) auto-mode-alist))

; Ruby-electric
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/ruby-electric")
(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode t)))
(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            (define-key ruby-mode-map "\C-m" 'newline-and-indent)
	    (require 'ruby-electric)
            (ruby-electric-mode t)
            ))

; Ruby REPL mode
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/inf-ruby")
(require 'inf-ruby)

; Rails mode
(setq load-path (cons (expand-file-name "/home/deepans/tools/emacs-tools/emacs-rails") load-path))
  (require 'rails-autoload)

;; yasnippet rails
(load "/home/deepans/tools/emacs-tools/yasnippet-rails/setup.el")


; Ruby - bind RET to new line indent
(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;; flymake - Ruby
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/flymake-ruby")
(require 'flymake-ruby)
  (add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; I don't like the default colors :)
;(set-face-background 'flymake-errline "red4")
;(set-face-background 'flymake-warnline "dark slate blue")

;; Rinari
       (add-to-list 'load-path "/home/deepans/tools/emacs-tools/rinari-rails/rinari")
       (require 'rinari)

; Line Numbers
(global-linum-mode 1)

; Window numbering mode
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/emacs-rails/window-numbering-mode")
(require 'window-numbering)
(window-numbering-mode 1)

;; android-mode
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/android-mode")
(require 'android-mode)
(setq android-mode-sdk-dir "/home/deepans/tools/android-sdk-linux_86")

;; clojure-mode
(add-to-list 'load-path "/home/deepans/tools/clojure-tools/clojure-mode")
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(add-to-list 'load-path "/home/deepans/tools/clojure-tools/slime")
(setq inferior-lisp-program "clj-env-dir")
(require 'slime)
(slime-setup)

;; paredit
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/paredit")
   (autoload 'enable-paredit-mode "paredit"
     "Turn on pseudo-structural editing of Lisp code."
     t)

; midje mode
(add-to-list 'load-path "/home/deepans/tools/emacs-tools/midje-mode")
(require 'midje-mode)
(add-hook 'clojure-mode-hook 'midje-mode)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

