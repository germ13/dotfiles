(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(require 'use-package)
(load-library "find-lisp")

(add-to-list 'load-path 
	     "~/.emacs.d/lisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Look and Feel
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'custom-theme-load-path 
	     "~/.emacs.d/themes/")

(load-theme 'monokai t)

(set-face-attribute 'default nil
                    :family "monospace"
                    :height 140
                    :weight 'normal
                    :width 'normal)

(setq monokai-height-minus-1 0.8
      monokai-height-plus-1 1.1
      monokai-height-plus-2 1.15
      monokai-height-plus-3 1.2
      monokai-height-plus-4 1.3)

(tool-bar-mode -1)
(setq visible-bell 1)
(linum-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'org-mode-hook 'my/org-mode-hook)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-switchb)

(setq org-startup-indented t
      org-src-tab-acts-natively t
      org-hide-leading-stars t
      org-log-done t
      org-hide-emphasis-markers t
      org-fontify-done-headline t
      org-pretty-entities t
      org-odd-levels-only t)

(setq org-directory "~/Desktop/org/")
;;(setq org-agenda-files
;;      (list org-directory))
(setq org-agenda-files
      (append
       (find-lisp-find-files "~/Desktop/org/" "\.org$")
       (find-lisp-find-files "~/Desktop/workorg/" "\.org$")))

(setq org-default-notes-file
      (concat org-directory "notes.org"))

(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (agenda "")
          (alltodo "")))))

(defun my/org-mode-hook ()
  "Stop the org-level headers from increasing in height relative to the other text."
  (dolist (face '(org-level-1
                  org-level-2
                  org-level-3
                  org-level-4
                  org-level-5))
    (set-face-attribute face nil :weight 'semi-bold :height 1.0)))

;; org -- todo settings
(setq org-todo-keyword-faces
      '(("TODO" .
         (:foreground "black" :background "yellow" :weight bold))
        ("DONE" .
         (:foreground "white" :background "green" :weight bold))
        ("STARTED" . "green")
        ("CANCELED" . (:foreground "blue" :weight bold))))


;; org-mode org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; org-mode fancy-priorities
(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("*" "!" "-")))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Programming
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(yas-global-mode 1)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(define-key lisp-interaction-mode-map
  (kbd "<C-return>") 'eval-last-sexp)

;; clojure
(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)
(add-hook 'clojure-mode-hook          'enable-paredit-mode)

(load "command-log-mode")

;; Language modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'csharp-mode "csharp-mode"
;;   "Major mode for editing C# code." t)


;; (setq auto-mode-alist 
;;       (cons '( "\\.cs\\'" . csharp-mode )
;; 	    auto-mode-alist ))

;; (org-babel-do-load-languages 
;;  'org-babel-load-languages '((csharp . t)))


;; PDF TOOLS
;; (pdf-tools-install)
;; ;; open pdfs scaled to fit page
;; (setq-default pdf-view-display-size 'fit-page)
;; ;; automatically annotate highlights
;; (setq pdf-annot-activate-created-annotations t)
;; ;; use normal isearch
;; (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
;; ;; turn off cua so copy works
;; (add-hook 'pdf-view-mode-hook (lambda () (cua-mode 0)))
;; ; more fine-grained zooming
;; (setq pdf-view-resize-factor 1.1)
;; ;; keyboard shortcuts
;; ;; (define-key pdf-view-mode-map (kbd "h") 'pdf-annot-add-highlight-markup-annotation)
;; ;; (define-key pdf-view-mode-map (kbd "t") 'pdf-annot-add-text-annotation)
;; ;; (define-key pdf-view-mode-map (kbd "D") 'pdf-annot-delete)

(custom-set-variables
 '(package-selected-packages
   (quote
    (use-package org-fancy-priorities org-bullets paredit rainbow-delimiters yasnippet yasnippet-snippets org-noter pdf-tools zop-to-char zenburn-theme which-key volatile-highlights undo-tree super-save smartrep smartparens projectile operate-on-number move-text magit imenu-anywhere hl-todo guru-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region editorconfig easy-kill discover-my-major diminish diff-hl crux cider browse-kill-ring better-defaults beacon anzu ace-window))))
(custom-set-faces )
