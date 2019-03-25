;;Don't put autosaves in workspace
(setq backup-directory-alist `(("." . "~/.saves")))

;;No welcome screen
(setq inhibit-splash-screen t)

;;Undo/redo buffer-window management
(winner-mode 1)

;;Which function is the cursor in, displayed on overlay
(which-func-mode)

;;Nice theme
(load-theme 'tango-dark)

;;3-space tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
(setq c-default-style "linux"
		c-basic-offset 3)

;;Sweet path autocompletion
(require 'ido)
(ido-mode t)

;;No ugly bar overlay
(tool-bar-mode -1)
(menu-bar-mode -1)

;;Show column number in overlay, useful for coding standard page-width
(setq column-number-mode t)

;;No scroll bar
(scroll-bar-mode -1)


;;Jump between compilation errors/warnings keybind
(global-set-key [C-S-iso-lefttab] 'next-error)

;;Comment out region keybind
(add-hook 'c-mode-hook (lambda () (setq comment-start "// "
													 comment-end   "")))

;;Show path to buffer in menu bar
(setq frame-title-format
		'(:eval
		  (if buffer-file-name
				(replace-regexp-in-string
				 "\\\\" "/"
				 (replace-regexp-in-string
				  (regexp-quote (getenv "HOME")) "-"
				  (convert-standard-filename buffer-file-name)))
			 (buffer-name))))

;;Auto-highlight matching parenthesis without delay
(setq show-paren-delay 0)
(show-paren-mode 1)

;;Auto-match when typing opening characters
(electric-pair-mode 1)

;;Prevent auto-split to new windows
(setq split-height-threshold 1200)
(setq split-width-threshold 2000)

;;Other window but backwards
(defun other-window-backwards()
  "Invoke other window with -1."
  (interactive)
  (other-window -1))

;;Keybinds for other window ( & backwards)
(global-set-key (kbd "s-<return>") 'other-window)
(global-set-key (kbd "S-s-<return>") 'other-window-backwards)

;;Recompile keybind
(global-set-key (kbd "C-x c") 'recompile)

;;Auto scroll compilation output until error
(setq compilation-scroll-output t)

;;Keybind uncomment region
(global-set-key (kbd "C-c C-v") 'uncomment-region)

;;Ask before exit
(defun request-kill-permission ()
  (interactive)
  (y-or-n-p "Do you really want to kill emacs? "))
(add-hook 'kill-emacs-query-functions #'request-kill-permission)

;;Reload all open buffers from disk
(defun revert-all-buffers ()
  "Iterate through the list of buffers and revert them, e.g. after a
    new branch has been checked out."
  (interactive)
  (when (yes-or-no-p "Are you sure - any changes in open buffers will be lost! ")
    (let ((frm1 (selected-frame)))
      (make-frame)
      (let ((frm2 (next-frame frm1)))
        (select-frame frm2)
        (make-frame-invisible)
        (dolist (x (buffer-list))
          (let ((test-buffer (buffer-name x)))
            (when (not (string-match "\*" test-buffer))
              (when (not (file-exists-p (buffer-file-name x)))
                (select-frame frm1)
                (when (yes-or-no-p (concat "File no longer exists (" (buffer-name x) "). Close buffer? "))
                  (kill-buffer (buffer-name x)))
                (select-frame frm2))
              (when (file-exists-p (buffer-file-name x))
                (switch-to-buffer (buffer-name x))
                (revert-buffer t t t)))))
        (select-frame frm1)
        (delete-frame frm2)))))

;;No idea
(put 'downcase-region 'disabled nil)

;;Text scale keybinds
(global-set-key [C-kp-add] 'text-scale-increase)
(global-set-key [C-kp-subtract] 'text-scale-decrease)

;;Empty scratch
(setq initial-scratch-message "")

;;Follow symbolic links when opened
(setq vc-follow-symlinks t)

;;No line wraps
(set-default 'truncate-lines t)

;;Dired listing
(setq dired-listing-switches "-alhF")

;;Scroll half page
(defun scroll-half-page (direction)
  "Scroll half page in parameter direction"
  (let ((opos (cdr (nth 6 (posn-at-point)))))
	 ;;opos = original position line relative to window
	 (move-to-window-line nil)
	 (if direction
		  (recenter-top-bottom -1)
		(recenter-top-bottom 0))
	 (move-to-window-line opos)))

(defun scroll-half-page-down ()
  "Scroll half page down"
  (interactive)
  (scroll-half-page nil))

(defun scroll-half-page-up ()
  "Scroll half page up"
  (interactive)
  (scroll-half-page t))

;;Keybind half page scrolls
(global-set-key (kbd "C-v") 'scroll-half-page-down)
(global-set-key (kbd "M-v") 'scroll-half-page-up)

;;Delete trailing whitespace save hook
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;fancy calendar
;;(setq view-diary-entries-initially t
;;		mark-diary-entries-in-calendar t
;;		number-of-diary-entries 7)
;;(add-hook 'diary-display-hook 'fancy-diary display)
;;(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

;;remote machine
;;(defun connect-remote ()
;;  (interactive)
;;  (dired "/ssh:$USER@host:/"))

;;Octave command line
(add-hook 'inferior-octave-mode-hook
			 (lambda ()
				(define-key inferior-octave-mode-map [up]
				  'comint-previous-input)
				(define-key inferior-octave-mode-map [down]
				  'comint-next-input)))

;;Custom
(custom-set-variables
 '(show-paren-mode t))

(custom-set-faces
 )
