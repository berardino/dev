;; Install dash

;; Turn off mouse interface
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(defalias 'yes-or-no-p 'y-or-n-p)


(set-frame-font "Menlo:pixelsize=16")

(add-to-list 'default-frame-alist
             (cons 'font "Menlo:pixelsize=16"))

;; Set path to dependencies
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path settings-dir)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)


;; Install extensions if they're missing
(require 'setup-package)
(defun init--install-packages ()
  (packages-install
   '(
     better-defaults
     visual-regexp
     highlight-escape-sequences
     expand-region
     multiple-cursors
     smart-forward
     smex
     powerline
     moe-theme
     smart-mode-line
     smart-mode-line-powerline-theme
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(require 'better-defaults)


;; No backup files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Visual regexp
(require 'visual-regexp)

;; Highlight escape sequences
(require 'highlight-escape-sequences)
(hes-mode)
(put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)
(put 'hes-escape-backslash-face 'face-alias 'font-lock-builtin-face)
(put 'hes-escape-sequence-face 'face-alias 'font-lock-builtin-face)


(require 'expand-region)
(require 'multiple-cursors)


;; Smart forward
(require 'smart-forward)

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Setup key bindings
(require 'key-bindings)

;; Powerline
(require 'powerline)

;; Theme
(require 'moe-theme)
(moe-dark)
(moe-theme-set-color 'orange)

;; smart-mode-line
(setq sml/no-confirm-load-theme t)
(require 'smart-mode-line)
(setq powerline-arrow-shape 'curve)
(setq powerline-default-separator-dir '(right . left))
(setq sml/theme 'powerline)
(sml/setup)
