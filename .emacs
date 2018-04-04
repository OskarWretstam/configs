(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 3)         ;; Indent by 3 spaces?
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (java-mode . "java")
     (other . "gnu"))))      ;; No idea what this does
 '(inhibit-startup-screen t) ;; No welcome message
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default indent-tabs-mode-nil) ;;No tabs
(setq-default tab-width 3)          ;;Tab is 3 spaces
(setq c-default-style "linux"
      c-basic-offset 3)             ;;Tab is 3 spaces again
(require 'ido)
(ido-mode t)                        ;;Browse files quicker
(tool-bar-mode -1)                  ;;Disable toolbar
(setq column-number-mode t)         ;;Show column number for marker in bottom bar
(scroll-bar-mode 1)                 ;;Scroll bar for each buffer
(load-theme 'wombat)                ;;Theme not useable in red enviroment
(global-set-key [C-S-iso-lefttab]  'next-error)                 ;;Next compilation error/warning ctrl-shift-tab
(global-linum-mode t)                                           ;;Line numbers in each buffer
(add-hook 'c-mode-hook (lambda () (setq comment-start "// "
                                        comment-end   "")))     ;;C-style comment marked region Ctrl-c Ctrl-c
(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))                                          ;;Show path to file in top emacs name bar
(setq show-paren-delay 0)                                       ;;Highlight parenthesis without delay
(show-paren-mode 1)                                             ;;Highlight matching parenthesis
(electric-pair-mode 1)                                          ;;Insert matching parenthesis
(setq split-height-threshold 1200)                              ;;/Prevent emacs from auto-split into
(setq split-width-threshold 2000)                               ;;\more than two windows
(global-set-key (kbd "M-RET") 'other-window)                    ;;Cycle windows with meta-ret
(setq compilation-exit-message-function
(lambda (status code msg)
(when (and (eq status 'exit) (zerop code))
(bury-buffer "*compilation*")
(replace-buffer-in-windows "*compilation*"))                    ;;/Auto-close compilation buffer if
(cons msg code)))                                               ;;\no errors.
(global-set-key (kbd "C-x c") 'recompile)                       ;;Recompile with ctrl-x c
(setq compilation-scroll-output 'first-error)                   ;;Scroll compilation buffer with output
(setq backup-directory-alist `(("." . "~/.saves")))             ;;Put auto-save files in ~/.saves
(global-set-key (kbd "C-c C-v") 'uncomment-region)              ;;uncomment marked region ctrl-c ctrl-v
(defun request-kill-permission ()
  (interactive)
  (y-or-n-p "Do you really want to kill emacs? "))
(add-hook 'kill-emacs-query-functions #'request-kill-permission) ;;Ask before killing emacs
(when (fboundp 'winner-mode)                                     ;;Undo/redo window-splits
      (winner-mode 1))
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
                (revert-buffer t t t)))))                       ;; /Re-read all open buffers from disk
        (select-frame frm1)                                     ;;|with meta-x revert-all-buffers
        (delete-frame frm2)))))                                 ;; \when git branch switch or checkout
(add-hook 'before-save-hook 'delete-trailing-whitespace)        ;;Remove trailing whitespace at save
(put 'downcase-region 'disabled nil)                            ;;Enable region to lowercase ctrl-x ctrl-l
(global-set-key [C-kp-add] 'text-scale-increase)                ;;/ctrl-keypad+ increase text size
(global-set-key [C-kp-subtract] 'text-scale-decrease)           ;;\ctrl-keypad- decrease text size
