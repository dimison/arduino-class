;
;    Copyright (C) 2019 by John M. Beck <john.morris.beck@gmail.com>
;    Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted.
;    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS
;    SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
;    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
;    NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
;    THIS SOFTWARE.
;
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


(progn
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

					;
					;
					;
					;
					;
					;      begin of my code
					;
					;
					;
					;

					;

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


  (setq last-mode major-mode)
  (c++-mode)
  (funcall last-mode)

  (erc :server "irc.freenode.net" :port 6667 :nick "lisbeths")
  (ansi-term "/bin/bash")




  ;;compile arduino file in open window and load if there are no errors
  (defun multi-mode-set-key (key binding &rest args)
    (progn
      (global-set-key (kbd key) (lambda () (interactive) binding))
      (while args
	(define-key (pop args) (kbd key) (lambda () (interactive) binding)))))




  ;;text-mode is default major mode
  (multi-mode-set-key "C-c C-c"
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
						 ))))
		      c++-mode-map erc-mode-map text-mode-map lisp-interaction-mode-map
		      )

					;$ arduino-cli compile --fqbn arduino:samd:mkr1000 Arduino/MyFirstSketch
					;arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:samd:mkr1000 Arduino/MyFirstSketch
					;arduino-cli board list



  ;;run last recorded macro
  (multi-mode-set-key (kbd "C-c C-e") 'kmacro-end-and-call-macro c++-mode-map erc-mode-map text-mode-map lisp-interaction-mode-map)


  ;;create new arduino file
  (multi-mode-set-key (kbd "C-c C-n")
		  (lambda () (interactive)
		    (let ((x (read-from-minibuffer "new arduino filename: ")))
		      (shell-command (concat "\"$HOME\"/.config/emacs-arduino/arduino-cli sketch new '" x "'"))
		      (find-file
		       (concat "~/Arduino/" x "/" x ".ino")))) c++-mode-map erc-mode-map text-mode-map lisp-interaction-mode-map)



  ;;list arduino files
  (multi-mode-set-key (kbd "C-c C-l")
		  (lambda () (interactive)
		    (find-file "~/Arduino")
		    ) c++-mode-map erc-mode-map text-mode-map lisp-interaction-mode-map)





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
  )
