(setq emacs-editor-path (append-path emacs-path  "edit-clojure-tools"))

;; clojure-mode
(require 'clojure-mode)
(add-to-list 'auto-mode-alist '("\\.clj$" . clojure-mode))

;; slime
(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))

(setq inferior-lisp-program "clj-env-dir")
(require 'slime)
(slime-setup)

;; syntax highlighting in the slime repl
(add-hook 'slime-repl-mode-hook 'clojure-mode-font-lock-setup)

;; paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)

;; midje mode
(require 'midje-mode)
(add-hook 'clojure-mode-hook 'midje-mode)
