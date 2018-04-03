(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-basic-offset 3)
 '(c-default-style
   (quote
    ((c-mode . "linux")
     (java-mode . "java")
     (other . "gnu"))))
 '(inhibit-startup-screen t)
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default indent-tabs-mode-nil)
(setq-default tab-width 3)
(setq c-default-style "linux"
      c-basic-offset 3)
(require 'ido)
(ido-mode t)
(tool-bar-mode)
(setq column-number-mode t)
(scroll-bar-mode 1)
(load-theme 'wombat)
(global-set-key [C-S-iso-lefttab]  'next-error)
(global-linum-mode t)
(add-hook 'c-mode-hook (lambda () (setq comment-start "// "
                                        comment-end   "")))
(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))
(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode 1)
(setq split-height-threshold 1200)
(setq split-width-threshold 2000)
(global-set-key (kbd "M-RET") 'other-window)
(setq compilation-exit-message-function
(lambda (status code msg)
(when (and (eq status 'exit) (zerop code))
(bury-buffer "*compilation*")
(replace-buffer-in-windows "*compilation*"))
(cons msg code)))
(global-set-key (kbd "C-x c") 'recompile)
(setq compilation-scroll-output 'first-error)
(setq backup-directory-alist `(("." . "~/.saves")))
(global-set-key (kbd "C-c C-v") 'uncomment-region)
(defun request-kill-permission ()
  (interactive)
  (y-or-n-p "Do you really want to kill emacs? "))
(add-hook 'kill-emacs-query-functions #'request-kill-permission)
(when (fboundp 'winner-mode)
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
                (revert-buffer t t t)))))
        (select-frame frm1)
        (delete-frame frm2)))))
