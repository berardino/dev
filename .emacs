(setq package-list '(
		     projectile
		     irony
		     flycheck
		     company-irony
		     solarized-theme
		     pbcopy
		     smart-mode-line
		     cmake-mode
		     cmake-project
		     helm-projectile
		     ))

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("marmalade" . "https://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'flycheck
  '(add-to-list 'flycheck-checkers 'irony))

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(setq company-backends (delete 'company-semantic company-backends))

(setq x-select-enable-clipboard t)

(if window-system
    (load-theme 'solarized-light t)
    (load-theme 'wombat t))

(setq frame-title-format '(buffer-file-name "%f" ("%b")))
(set-face-attribute 'default nil
		    :family "Menlo"
		    :height 120
		    :weight 'normal
		    :width 'normal)


(global-linum-mode 1)
(set-face-attribute 'linum nil :height 100)
(setq linum-format "%d ")
(setq find-file-visit-truename t)

(require 'pbcopy)
(turn-on-pbcopy)

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq tab-width 4
      indent-tabs-mode nil)

(setq make-backup-files nil)

(defalias 'yes-or-no-p 'y-or-n-p)


(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)


(require 'smart-mode-line)
(setq sml/theme 'respectful)
(setq sml/no-confirm-load-theme t)
(add-hook 'after-init-hook 'sml/setup)

(require 'cmake-mode)
(setq auto-mode-alist
	  (append
	   '(("CMakeLists\\.txt\\'" . cmake-mode))
	   '(("\\.cmake\\'" . cmake-mode))
	   auto-mode-alist))

(require 'cmake-project)

(defun maybe-cmake-project-hook ()
  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))
(add-hook 'c-mode-hook 'maybe-cmake-project-hook)
(add-hook 'c++-mode-hook 'maybe-cmake-project-hook)

(projectile-global-mode)

(require 'helm-projectile)
(helm-projectile-on)

(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)

(helm-mode 1)
