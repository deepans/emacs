(defun find-subdirs-containing (dir pattern)
  "Return a list of all deep subdirectories of DIR that contain files
that match PATTERN."
  (let* ((ret nil)
	 (files (directory-files dir))
	 (max-lisp-eval-depth 3000))
    (while files
      (let* ((file (car files))
	     (path (expand-file-name file dir)))
	(if (and (file-directory-p path)
		 (not (string-match "^\\.+" file)))
	    (setq ret (append ret (find-subdirs-containing path pattern)))
	  (if (string-match pattern file)
	      (add-to-list 'ret dir))))
      (setq files (cdr files)))
    ret))

(setq initial-load-path load-path)
(setq load-path (append (find-subdirs-containing emacs-path "\\.el$") initial-load-path))

(defun append-path (path1 path2)
  (format "%s/%s" path1  path2)
)