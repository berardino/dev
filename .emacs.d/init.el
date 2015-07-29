(require 'package)

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))

(package-initialize)


(defun require-package (package &optional min-version no-refresh)
  "Ask elpa to install given PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(require-package 'bind-key)
(require-package 'dash)
(require-package 'drag-stuff)
(require-package 'exec-path-from-shell)
(require-package 'expand-region)
(require-package 'f)
(require-package 'flycheck)
(require-package 'htmlize)
(require-package 'idle-highlight-mode)
(require-package 'magit)
(require-package 'multiple-cursors)
(require-package 'popwin)
(require-package 's)
(require-package 'smartparens)
(require-package 'web-mode)
(require-package 'yasnippet)
(require-package 'ensime)
(require-package 'projectile)
(require-package 'helm-projectile)
(require-package 'whitespace)
(require-package 'iedit)
(require-package 'smart-mode-line)
(require-package 'powerline)
(require-package 'smart-mode-line-powerline-theme)
(require-package 'elpy)
(require-package 'irony)
(require-package 'flycheck-irony)
(require-package 'company-irony)
(require-package 'sr-speedbar)
(require-package 'groovy-mode)
(require-package 'grails-mode)
(require-package 'neotree)
(require-package 'zenburn-theme)
(require-package 'emacs-eclim)
(require-package 'puppet-mode)


(require 'iedit)
(global-set-key (kbd "C-;") 'iedit-mode)

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(require 'sr-speedbar)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

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
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)

(helm-mode 1)

(helm-autoresize-mode 1)


(setq x-select-enable-clipboard t)

(setq frame-title-format '(buffer-file-name "%f" ("%b")))


(global-linum-mode 1)
(setq linum-format "%d ")
(setq find-file-visit-truename t)

(menu-bar-mode -1)
(if (display-graphic-p)
    (progn
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))


(setq-default indent-tabs-mode nil)
(setq tab-width 4)

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
(setq column-number-mode t)
(setq line-number-mode t)

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


(setq magit-auto-revert-mode nil)
(setq magit-last-seen-setup-instructions "1.4.0")
(require 'magit)


(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(add-hook 'after-init-hook 'global-company-mode)

(setq hackernews-top-story-limit 40)


;; web
(require 'web-mode)


(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme 'ascii)
(custom-set-faces
 '(neo-banner-face ((t . (:inherit shadow))) t)
 '(neo-header-face ((t . (:inherit shadow))) t)
 '(neo-root-dir-face ((t . (:inherit link-visited :underline nil))) t)
 '(neo-dir-link-face ((t . (:inherit dired-directory))) t)
 '(neo-file-link-face ((t . (:inherit default))) t)
 '(neo-button-face ((t . (:inherit dired-directory))) t)
 '(neo-expand-btn-face ((t . (:inherit button))) t))

;;;
;;; xml
(require 'nxml-mode)
(setq nxml-bind-meta-tab-to-complete-flag t)
(setq nxml-slash-auto-complete-flag t)

(load-theme 'zenburn t)

(require 'eclim)
(global-eclim-mode)
(require 'eclimd)

(custom-set-variables
  '(eclim-eclipse-dirs '("~/dev/sw/eclipse_eclim"))
  '(eclim-executable "~/dev/sw/eclipse_eclim/eclim"))

(setq help-at-pt-display-when-idle t)
(setq help-at-pt-timer-delay 0.1)
(help-at-pt-set-timer)

(require 'auto-complete-config)
(ac-config-default)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)
