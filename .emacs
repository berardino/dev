(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(load-theme 'monokai t)
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require 'projectile)
(require 'helm-config)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(helm-mode 1)

(helm-autoresize-mode 1)


(setq x-select-enable-clipboard t)

(setq frame-title-format '(buffer-file-name "%f" ("%b")))


(global-linum-mode 1)
(setq linum-format "%d ")
(setq find-file-visit-truename t)

(tool-bar-mode -1)
(menu-bar-mode -1)


(setq tab-width 4
      indent-tabs-mode nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(set-frame-font "Menlo:pixelsize=13")

(add-to-list 'default-frame-alist
             (cons 'font "Menlo:pixelsize=12"))

(setq ring-bell-function 'ignore)
(setq make-backup-files nil)

(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)

(require 'whitespace)
(setq whitespace-style '(tabs tab-mark trailing))
(global-whitespace-mode 1)

(setq sml/no-confirm-load-theme t)
(set-face-attribute 'mode-line nil
                    :foreground "Black"
                    :background "DarkOrange"
                    :box nil)
(setq sml/theme 'powerline)
(sml/setup)

(require 'drag-stuff)
(drag-stuff-mode t)
(drag-stuff-global-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("26614652a4b3515b4bbbb9828d71e206cc249b67c9142c06239ed3418eff95e2" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(elpy-enable)

(require 'iedit)
(global-set-key (kbd "C-;") 'iedit-mode)

(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")
(require 'magit)

