;; Turn off mouse interface early in startup to avoid momentary display

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Set path to dependencies
;; (setq site-lisp-dir
;;       (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)
;; (add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Set up appearance early
;; (require 'appearance)

;; Settings for currently logged in user
;; (setq user-settings-dir
      ;; (concat user-emacs-directory "users/" user-login-name))
;; (add-to-list 'load-path user-settings-dir)

;; Add external projects to load path
;; (dolist (project (directory-files site-lisp-dir t "\\w+"))
  ;; (when (file-directory-p project)
    ;; (add-to-list 'load-path project)))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
     (concat user-emacs-directory "backups")))))

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

;; Save point position between sessions
;; (require 'saveplace)
;; (setq-default save-place t)
;; (setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Are we on a mac?
;; (setq is-mac (equal system-type 'darwin))

;; Setup packages
(require 'setup-package)

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(magit
     paredit
     move-text
     gist
     ;; htmlize
     ;; visual-regexp
     ;; markdown-mode
     ;; fill-column-indicator
     flycheck
     flycheck-pos-tip
     flycheck-clojure
     flx
     flx-ido
     ;; dired-details
     ;; css-eldoc
     yasnippet
     smartparens
     ido-vertical-mode
     ido-at-point
     ido-ubiquitous
     ;; simple-httpd
     ;; guide-key
     ;; nodejs-repl
     ;; restclient
     ;; highlight-escape-sequences
     whitespace-cleanup-mode
     ;; elisp-slime-nav
     git-commit-mode
     gitconfig-mode
     ;; dockerfile-mode
     gitignore-mode
     clojure-mode
     ;; groovy-mode
     ;; prodigy
     cider
     js2-mode
     js2-refactor
     multiple-cursors
     smex
     undo-tree
     company
     web-mode
     editorconfig
     helm
     helm-swoop
     helm-projectile
     helm-ag
     projectile
     )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Lets start with a smattering of sanity
;; (require 'sane-defaults)

;; Setup environment variables from the user's shell.
;; (when is-mac
  ;; (require-package 'exec-path-from-shell)
  ;; (exec-path-from-shell-initialize))

;; guide-key
;; (require 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x v" "C-x 8" "C-x +"))
;; (guide-key-mode 1)
;; (setq guide-key/recursive-key-sequence-flag t)
;; (setq guide-key/popup-window-position 'bottom)

;; Setup extensions
(eval-after-load 'ido '(require 'setup-ido))
;; (eval-after-load 'org '(require 'setup-org))
;; (eval-after-load 'dired '(require 'setup-dired))
(eval-after-load 'magit '(require 'setup-magit))
(eval-after-load 'grep '(require 'setup-rgrep))
;; (eval-after-load 'shell '(require 'setup-shell))
;; (require 'setup-hippie)
(require 'setup-yasnippet)
;; (require 'setup-perspective)
;; (require 'setup-ffip)
;; (require 'setup-html-mode)
;; (require 'setup-paredit)

;; (require 'prodigy)
;; (global-set-key (kbd "C-x M-m") 'prodigy)

;; Font lock dash.el
;; (eval-after-load "dash" '(dash-enable-font-lock))

;; Default setup of smartparens
;; (require 'smartparens-config)
;; (setq sp-autoescape-string-quote nil)
;; (--each '(css-mode-hook
    ;; restclient-mode-hook
    ;; js-mode-hook
    ;; java-mode
  ;;         ruby-mode
  ;;         markdown-mode
  ;;         groovy-mode)
  ;; (add-hook it 'turn-on-smartparens-mode))

;; Language specific setup files
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
;; (eval-after-load 'ruby-mode '(require 'setup-ruby-mode))
;; (eval-after-load 'clojure-mode '(require 'setup-clojure-mode))
;; (eval-after-load 'markdown-mode '(require 'setup-markdown-mode))

;; ;; Load stuff on demand
;; (autoload 'skewer-start "setup-skewer" nil t)
;; (autoload 'skewer-demo "setup-skewer" nil t)
;; (autoload 'auto-complete-mode "auto-complete" nil t)
;; (eval-after-load 'flycheck '(require 'setup-flycheck))

;; ;; Map files to modes
;; (require 'mode-mappings)

;; ;; Highlight escape sequences
;; (require 'highlight-escape-sequences)
;; (hes-mode)
;; (put 'font-lock-regexp-grouping-backslash 'face-alias 'font-lock-builtin-face)

;; ;; Visual regexp
;; (require 'visual-regexp)
;; (define-key global-map (kbd "M-&") 'vr/query-replace)
;; (define-key global-map (kbd "M-/") 'vr/replace)

;; Functions (load all files in defuns-dir)
(setq defuns-dir (expand-file-name "defuns" user-emacs-directory))
(dolist (file (directory-files defuns-dir t "\\w+"))
  (when (file-regular-p file)
    (load file)))

;; (require 'expand-region)
(require 'multiple-cursors)
;; (require 'delsel)
;; (require 'jump-char)
;; (require 'eproject)
;; (require 'wgrep)
;; (require 'smart-forward)
;; (require 'change-inner)
;; (require 'multifiles)

;; ;; Don't use expand-region fast keys
;; (setq expand-region-fast-keys-enabled nil)

;; ;; Show expand-region command used
;; (setq er--show-expansion-message t)

;; ;; Fill column indicator
;; (require 'fill-column-indicator)
;; (setq fci-rule-color "#111122")

;; ;; Browse kill ring
;; (require 'browse-kill-ring)
;; (setq browse-kill-ring-quit-action 'save-and-restore)

;; Smart M-x is smart
(require 'smex)
(smex-initialize)

;; Setup key bindings
;; (require 'key-bindings)

;; Misc
;; (require 'project-archetypes)
;; (require 'my-misc)
;; (when is-mac (require 'mac))

;; Elisp go-to-definition with M-. and back again with M-,
;; (autoload 'elisp-slime-nav-mode "elisp-slime-nav")
;; (add-hook 'emacs-lisp-mode-hook (lambda () (elisp-slime-nav-mode t) (eldoc-mode 1)))

;; Emacs server
;; (require 'server)
;; (unless (server-running-p)
  ;; (server-start))

;; Run at full power please
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; Conclude init by setting up specifics for the current user
;; (when (file-exists-p user-settings-dir)
  ;; (mapc 'load (directory-files user-settings-dir nil "^[^#].*el$")))






;; MY -- change this some day
;;

;; smex
(setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; Line movement
(global-set-key (kbd "<C-S-down>") 'move-text-down)
(global-set-key (kbd "<C-S-up>") 'move-text-up)

;; undo
(global-undo-tree-mode)

;; Edit file with sudo
(global-set-key (kbd "M-s e") 'sudo-edit)

;; Easy-mode fullscreen rgrep
(global-set-key (kbd "M-s s") 'git-grep-fullscreen)
(global-set-key (kbd "M-s S") 'rgrep-fullscreen)


;; Default js indentation levels
(setq-default js2-basic-offset 2
              c-basic-offset 2
              tab-width 2
              indent-tabs-mode nil)
(setq js-indent-level 2)

;; everything is indented 2 spaces
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . javascript-mode))

;; rename
(defmacro rename-modeline (package-name mode new-name)
  `(eval-after-load ,package-name
     '(defadvice ,mode (after rename-modeline activate)
  (setq mode-name ,new-name))))

(rename-modeline "js2-mode" js2-mode "JS2")
(rename-modeline "clojure-mode" clojure-mode "Clj")
(rename-modeline "undo-tree-mode" undo-tree-mode "UT")

(add-hook 'after-init-hook 'global-company-mode)

;; delete seleted text when typing
(delete-selection-mode 1)

;; answer by y and n instead of yes and no
(defalias 'yes-or-no-p 'y-or-n-p)

;;(require 'multiple-cursors)
;; When you have an active region that spans multiple lines, the following will add a cursor to each line:
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; When you want to add multiple cursors not based on continuous lines, but based on keywords in the buffer
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; magit
(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)
(global-set-key (kbd "C-c C-m p") 'magit-push)
(global-set-key (kbd "C-c m p") 'magit-pull)
(global-set-key (kbd "C-c m b") 'magit-branch-manager)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; remove white spaced
(add-hook 'before-save-hook 'whitespace-cleanup)

;; disable line wrap
(setq default-truncate-lines t)

;; Add F12 to toggle line wrap
(global-set-key (kbd "<f12>") 'toggle-truncate-lines)

;; helm
(require 'helm)
;; helm-ag
(setq helm-ag-command-option "--all-text")
(setq helm-ag-insert-at-point 'symbol)
(require 'helm-swoop)
;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; When doing evil-search, hand the word over to helm-swoop
;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)
;; If this value is t, split window inside the current window
(setq helm-swoop-split-with-multiple-windows nil)
;; Split direcion. 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
;; If nil, you can slightly boost invoke speed in exchange for text color
(setq helm-swoop-speed-or-color nil)

;; helm-projectile
(global-set-key (kbd "C-c h") 'helm-projectile)
(global-set-key (kbd "C-c d") 'projectile-find-file)

;; ag helm
(global-set-key (kbd "C-c f") 'helm-projectile-ag)
(global-set-key (kbd "C-c g") 'helm-projectile-grep)
(global-set-key (kbd "C-c r") 'projectile-run-async-shell-command-in-root)


;; helm-swoop
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; theme
(load-theme 'tangotango t)

;; font
(set-default-font "Anka/Coder-12")

(setq magit-last-seen-setup-instructions "1.4.0")

;; pair mode
(setq show-paren-delay 0)
(show-paren-mode 1)
(electric-pair-mode 1)
;; (setq show-paren-style 'expression) ; highlight entire bracket expression

;; Disallow scrolling with mouse wheel
(when window-system
  (mouse-wheel-mode -1))

;; No graphics please o.O
(setq speedbar-use-images nil)

;; remove warning
(setq ad-redefinition-action 'accept)

;; ispell
(setq ispell-dictionary "en")

;; uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;; how disable mouse ?
(global-unset-key (kbd "<down-mouse-1>"))
(global-unset-key (kbd "<mouse-1>"))
(global-unset-key (kbd "<down-mouse-2>"))
(global-unset-key (kbd "<mouse-2>"))
(global-unset-key (kbd "<down-mouse-3>"))
(global-unset-key (kbd "<mouse-3>"))

;; Auto refresh buffers
(global-auto-revert-mode 1)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
