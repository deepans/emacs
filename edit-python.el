(setq emacs-editor-path (append-path emacs-path  "edit-python-tools"))

(require 'python)

; Install Pymacs (Python part)
; pip install https://github.com/pinard/Pymacs/tarball/v0.24-beta2

; Install Ropemacs and Rope
; sudo pip install http://bitbucket.org/agr/ropemacs/get/tip.tar.gz

; Pymacs + Ropemacs
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)


;(autoload 'python-mode "python-mode.el" "Python mode." t)
;(setq auto-mode-alist (append '(("/*.\.py$" . python-mode)) auto-mode-alist))
;(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;(require 'python-mode)


; Python - bind RET to py-newline-and-indent
(add-hook 'python-mode-hook '(lambda ()
                               (define-key python-mode-map "\C-m" 'newline-and-indent)))

; Python - set indent to 4 chars
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

; Install PyFlakes and pep8
; sudo pip install pyflakes pep8
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

