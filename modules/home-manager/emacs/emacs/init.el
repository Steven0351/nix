(setq treesit-font-lock-level 3)
(setq compilation-scroll-output t)

;; don't fuck with my cwd _emacs_
(setq create-lockfiles nil)
(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.local/share/emacs/autosaves" t)))

;; favorite themes
;; base16-kanagawa-dragon
;; base16-mountain
;; base16-grayscale-dark
;; base16-black-metal-bathory
;; doom-spacegrey
;; doom-badger
(load-theme 'base16-grayscale-dark)


(savehist-mode t)

;; packages
(use-package vterm)

(use-package nix-ts-mode
  :mode "\\.nix\\'")

(use-package vertico
  :init
  (vertico-mode))

(use-package company
  :config
  (setq company-idle-delay nil)
  :bind ("C-." . company-complete))

(context-menu-mode t)

(use-package consult
  :bind (
	 ("C-x b" . consult-buffer))
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(use-package magit)

(use-package jj-mode
  :vc (:url "https://github.com/bolivier/jj-mode.el"))

;; global keybinds
(global-set-key (kbd "<C-return>") (lambda ()
				  (interactive)
				  (end-of-line)
				  (newline-and-indent)))

(global-set-key (kbd "<M-z>") 'zap-up-to-char)

(global-set-key (kbd "C-c b") 'windmove-left)
(global-set-key (kbd "C-c f") 'windmove-right)
(global-set-key (kbd "C-c n") 'windmove-down)
(global-set-key (kbd "C-c p") 'windmove-up)
(global-set-key (kbd "C-c d") 'delete-window)

;; misc
(add-hook 'after-init-hook 'global-company-mode)

(set-face-attribute 'font-lock-keyword-face nil :weight 'bold)
(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :weight 'bold)
