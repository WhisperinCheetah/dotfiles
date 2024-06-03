
;; Make Elisp files in that directory available to the user.
;; (add-to-list 'load-path "~/.emacs.d/manual-packages/standard-themes")
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(setq package-enable-at-startup nil) (package-initialize)
(load-theme 'gruber-darker t)

;;(require 'hlinum)
;;(hlinum-activate)


;; Set relative line numbers
(setq-default display-line-numbers-type 'relative)
(setq-default display-line-numbers 'relative)

;; Don't show the splash screen
(setq inhibit-startup-message t)  ; Comment at end of line!
(setq visible-bell t)            ; Flash when the bell rings

;; Turn off some unneeded UI elements
(menu-bar-mode -1)  ; Leave this one on if you're a beginner!
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Modeline
(size-indication-mode 1)
(display-time)
(display-battery-mode)
;; set basic tab with
(setq-default tab-width 4)

 ;; set compile command for c
(setq-default c-basic-offset 4)
(add-hook 'c-mode-hook
          (lambda () (local-set-key (kbd "C-c C-g")
				    (lambda () (interactive) (compile "make -k")))))
(add-hook 'c-mode-hook
	  (lambda () (local-set-key (kbd "C-c C-r")
				    (lambda () (interactive) (compile "./main")))))

 ;; Set the shell to bash shell
(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name "bash")

;; Change shell command so it opens in current buffer
(defun new-shell (original-shell &optional buffer name)
  (let ((currentbuf (get-buffer-window (current-buffer)))
    (newbuf     (generate-new-buffer-name "*shell*")))
    (generate-new-buffer newbuf)
    (set-window-dedicated-p currentbuf nil)
    (set-window-buffer currentbuf newbuf)
    (funcall original-shell newbuf)))

;; Remap shell to new-shell
(advice-add 'shell :around #'new-shell)
(global-set-key (kbd "C-c h") 'shell)

;; Multiple cursors
;; Uses this package: https://github.com/magnars/multiple-cursors.el
(require 'multiple-cursors)
(global-set-key (kbd "C-c s") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c C-n") 'mc/insert-numbers)

;; Move lines
;; Uses this package: https://github.com/emacsfodder/move-text
(require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; Company mode (typing suggestions)
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Put autosaves in ~/.emacs.d/var/backup/
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))

;; File extension - mode associations
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(no-littering cmake-mode vue-mode typescript-mode multiple-cursors move-text lsp-ui lsp-dart hover gruber-darker-theme flycheck company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
