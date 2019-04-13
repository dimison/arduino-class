;;this is for my emacs


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

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
nn2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

;(require 'god-mode)

;;toggle god mode is left arrow
;(global-set-key (kbd "<left>") 'god-mode-all)

;;this keeps emacs from saving temporary #files when editing a folder. It saves them in
;; a special folder. I don't know where. I don't know if reboot will preserve them.
;(setq backup-directory-alist
 ;     `((".*" . ,temporary-file-directory)))
;(setq auto-save-file-name-transforms
					;      `((".*" ,temporary-file-directory t)))
(setq make-backup-files nil)

;;compile arduino file in open window and load if there are no errors
(global-set-key (kbd "C-c C-c")
		(lambda () (interactive)
		  (progn
		    (save-buffer)
		  (shell-command (concat "if \"$HOME\"/.config/emacs-arduino/arduino-cli "
					 "compile --fqbn arduino:avr:uno "
					 default-directory
					 "; then "
					 "\"$HOME\"/.config/emacs-arduino/arduino-cli "
					 "upload -p /dev/ttyACM0 --fqbn arduino:avr:uno "
					 default-directory
					 "; else echo fail; fi"
					 )))))

;$ arduino-cli compile --fqbn arduino:samd:mkr1000 Arduino/MyFirstSketch
;arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:samd:mkr1000 Arduino/MyFirstSketch



;;run last recorded macro
(global-set-key (kbd "C-c C-e") 'kmacro-end-and-call-macro)


;;create new arduino file
(global-set-key (kbd "C-c C-n")
		(lambda () (interactive)
		  (let ((x (read-from-minibuffer "new arduino filename: ")))
		    		  (shell-command (concat "\"$HOME\"/.config/emacs-arduino/arduino-cli sketch new '" x "'"))
					   (find-file
					    (concat "~/Arduino/" x "/" x ".ino")))))


;;list arduino files
(global-set-key (kbd "C-c C-l")
		(lambda () (interactive)
		  (find-file "~/Arduino")
			   ))

;;open arduino file
(global-set-key (kbd "C-c C-o")
		(lambda () (interactive)
		  (find-file (let ((x (read-from-minibuffer "arduino file: ")))
				  (concat "~/Arduino/" x "/" x ".ino")))))




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (god-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
