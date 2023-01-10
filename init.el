(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package on Non-linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
(load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package exec-path-from-shell)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package all-the-icons
  :if (display-graphic-p))

(fset 'yes-or-no-p 'y-or-n-p)

(use-package no-littering)
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.05))

(use-package vertico
  :bind
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package savehist
  :init
  (setq history-length 20)
  (savehist-mode 1))

(use-package orderless
  :custom (completion-styles '(orderless)))

(use-package dashboard
  :init
  (add-hook 'after-init-hook 'dashboard-refresh-buffer)
  :config
  (setq dashboard-items '((recents . 8)))
  (setq
   dashboard-set-init-info nil
   dashboard-banner-logo-title "Nicemacs"
   dashboard-footer-messages '("")
   dashboard-startup-banner 'logo
   dashboard-page-separator "\n\n\n"
   dashboard-center-content t
   dashboard-set-heading-icons nil
   dashboard-set-file-icons t
   dashboard-center-content t
   dashboard-items-default-length 30)
  (dashboard-setup-startup-hook))

;; requires ispell on macos and hunspell on linux
(use-package flyspell
  :defer t)

;; Org mode
 (setq org-startup-indented t
          org-pretty-entities t
          org-hide-emphasis-markers t
          org-startup-with-inline-images t
	  org-startup-folded 'content
          org-image-actual-width '(300))
(add-hook 'org-mode-hook 'visual-line-mode)

(use-package org-superstar
  :after org
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-remove-leading-stars t))

(defun my/org-mode-visual-fill ()
  (setq visual-fill-column-width 120
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . my/org-mode-visual-fill))

(require 'org-indent)

(dolist (face '((org-level-1 . 1.75)
                (org-level-2 . 1.5)
                (org-level-3 . 1.25)
                (org-level-4 . 1.1)
                (org-level-5 . 1)
                (org-level-6 . 1)
                (org-level-7 . 1)
                (org-level-8 . 1)))
  (set-face-attribute (car face) nil :inherit 'default :weight 'medium :height (cdr face)))

(custom-theme-set-faces
 'user
 '(org-document-title ((t (:inherit 'default :weight bold :height 2.0))))
 '(org-block ((t (:inherit 'default))))
 '(org-code ((t (:inherit (shadow default)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow default)))))
 '(org-indent ((t (:inherit (org-hide default)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face default)))))
 '(org-property-value ((t (:inherit 'default))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face default)))))
 '(org-table ((t (:inherit 'default :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow default) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow default))))))

(use-package treemacs
  :defer t
  :config
  (progn
    (setq treemacs-display-in-side-window t
	  treemacs-file-follow-delay 0.2
	  treemacs-follow-after-init t
	  treemacs-expand-after-init t
	  treemacs-indentation 2
	  treemacs-indentation-string " "
	  treemacs-no-delete-other-windows t
	  treemacs-is-never-other-window t
	  treemacs-project-follow-cleanup nil
	  treemacs-position 'left
	  treemacs-recenter-distance 0.1
	  treemacs-recenter-after-project-jump 'always
	  treemacs-recenter-after-project-expand 'on-distance
	  treemacs-show-hidden-files t
	  treemacs-sorting 'alphabetic-asc
	  treemacs-select-when-already-in-treemacs 'move-back
	  treemacs-user-mode-line-format t
	  treemacs-width 32
	  treemacs-width-is-initially-locked nil)
  
    (treemacs-resize-icons 15)
    (treemacs-project-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#eeeeec" :foreground "#2e3436" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "SF Mono"))))
 '(org-block ((t (:inherit 'default))))
 '(org-code ((t (:inherit (shadow default)))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow default)))))
 '(org-document-title ((t (:inherit 'default :weight bold :height 2.0))))
 '(org-indent ((t (:inherit (org-hide default)))))
 '(org-link ((t (:foreground "royal blue" :underline t))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face default)))))
 '(org-property-value ((t (:inherit 'default))) t)
 '(org-special-keyword ((t (:inherit (font-lock-comment-face default)))))
 '(org-table ((t (:inherit 'default :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow default) :weight bold :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow default))))))
