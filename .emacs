
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(c-default-style (quote ((c-mode . "linux") (java-mode . "java") (other . "gnu"))))
 '(c-basic-offset 3)
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
(add-hook 'c-mode-hook (lambda () (setq comment-start "//"
				       comment-end   "")))

