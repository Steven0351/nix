;;; early-init.el -*- lexical-binding: t; -*-
(require 'no-littering)
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(global-display-line-numbers-mode)
(hl-line-mode)

(setq my-early-init-file "~/.config/emacs.user/early-init.el")
(when (file-exists-p my-early-init-file)
  (load my-early-init-file))
