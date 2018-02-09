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
