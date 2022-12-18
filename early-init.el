(setq gc-cons-threshold #x40000000)

(setq inhibit-startup-message t)
(set-default-coding-systems 'utf-8)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(context-menu-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(setq-default mode-line-format nil)
(setq visible-bell 1)

(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default line-spacing 6)
