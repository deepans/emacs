(setq emacs-editor-path (append-path emacs-path  "editor-tools"))

;; Disable ridiculous looking scrollbar
(scroll-bar-mode -1)

;; Disable stupid toolbar
(tool-bar-mode -1)

;;"y and n" instead of Yes and No
(fset 'yes-or-no-p 'y-or-n-p)

;;show matching paranthesis
(show-paren-mode t)

;;set default font size
;(set-face-attribute 'default nil :height 100)

;;shell color mode
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

;; copy - paste - emacs - other apps
(setq x-select-enable-clipboard t)

;; Get rid of the startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; redo+ mode
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

;; find file recursively using regular expression for file names
(require 'find-recursive)

;; narrow down and select candidates for executing action
(require 'anything-config)

;; ido - auto complete
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

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


;; color theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (load-file (append-path emacs-editor-path  "blackboard-emacs/color-theme-blackboard.el"))
     (color-theme-blackboard)))
     ;(load-file (append-path emacs-editor-path  "twilight-emacs/color-theme-twilight.el"))
     ;(color-theme-twilight)))

;; CEDET
(require 'cedet)
(global-ede-mode 1)
(semantic-load-enable-code-helpers)
(global-srecode-minor-mode 1)

;; Emacs code browser
(require 'ecb)
(setq ecb-layout-name "left14")
(setq ecb-layout-window-sizes (quote (("left14" (0.2564102564102564 . 0.6949152542372882) (0.2564102564102564 . 0.23728813559322035)))))
(setq ecb-source-path (quote ("/" "/home/deepans")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("/home/deepans"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; use only spaces and no tabs
(setq-default indent-tabs-mode nil)    
(setq default-tab-width 4)

; Line Numbers
(global-linum-mode 1)

; Window numbering mode
(require 'window-numbering)
(window-numbering-mode 1)