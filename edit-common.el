(setq emacs-editor-path (append-path emacs-path  "edit-common-tools"))

; yasnippet 0.6.1
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory (append-path emacs-editor-path "yasnippet-0.6.1c/snippets"))

(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)

; Auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (append-path emacs-editor-path "auto-complete-1.3.1/dict"))
(ac-config-default)
