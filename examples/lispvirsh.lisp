;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; domain-start.lisp is part of Lispvirt.
;;;
;;; Lispvirt is free software: you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation, either version 3 of the License, or
;;; (at your option) any later version.
;;;
;;; Lispvirt is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with Lispvirt.  If not, see <http://www.gnu.org/licenses/>.
;;;-------------------------------------------------------------------------

(require 'asdf)

(asdf:load-system :lispvirt)

(in-package lispvirt-domain)

(defun get-command-line ()
  "Get the command line by the Standard Output."
  (setq answer (read-line)))

(defun split-by-one-space (string)
  "Returns a list of substrings of string divided by ONE space each. Note: Two consecutive spaces will be seen as if there were an empty string between them."
  (loop for i = 0 then (1+ j)
     as j = (position #\Space string :start i)
     collect (subseq string i j)
     while j))

(defun remove-empty-strings (string)
  "Remove empty strings from command line string."
  (loop for i in string
     if (> (length i) 0)
       collect i))

(defun cmd-start (conn command-line)
  (let ((flags (foreign-enum-value 'virDomainCreateFlags
                                   :VIR_DOMAIN_NONE))
        (domain (virDomainLookupByName conn (car (cdr command-line)))))
    (if (not (eq (virDomainGetID domain) -1))
        (print "Domain is already active!")
        (if (not (eq domain nil))
            (if (boole boole-and flags
                       (foreign-enum-value 'virDomainCreateFlags
                                           :VIR_DOMAIN_START_FORCE_BOOT))
                (progn
		  (print "Starting...")
                  (virDomainCreateWithFlags domain flags)
                  (virDomainFree domain)))))))

(defun cmd-shutdown (conn command-line)
  (let ((domain (virDomainLookupByName conn (car (cdr command-line))))
        (flags (foreign-enum-value 'virDomainShutdownFlagValues
                                   :VIR_DOMAIN_SHUTDOWN_ACPI_POWER_BTN)))
    (if (not (eq domain nil))
        (if (not (eq flags 0))
            (progn
	      (print "Shuting down...")
              (virDomainShutdownFlags domain 1)
              (virDomainFree domain))
            (progn
	      (print "Shuting down...")
              (virDomainShutdown domain)
              (virDomainFree domain)))
        (print "Domain does not exists!"))))


(defun cmd-dumpxml (conn command-line)
  (let ((domain (virDomainLookupByName conn (car (cdr command-line)))))
    (if (not (eq domain nil))
        (print (virDomainGetXMLDesc domain
                                    (foreign-enum-value 'virDomainXMLFlags
                                                        :VIR_DOMAIN_XML_INACTIVE)))
        (print "Domain does not exists!"))))


(defun lispvirsh-main ()
  (princ ">> ")
  (let ((command-line (split-by-one-space
                       (get-command-line)))
        (conn (virConnectOpen "qemu:///system")))
    (setq option (car command-line))
    (if (string= (car command-line) "start")
          (cmd-start conn command-line))
    (if (string= (car command-line) "shutdown")
          (cmd-shutdown conn command-line))
    (if (string= (car command-line) "dumpxml")
        (cmd-dumpxml conn command-line))
    (if (string= (car command-line) "list")
        (print "Listing"))
    (list option)))
    

(defun lispvirsh-main-loop ()
  (loop with val = "quit"
     do (setq cmd (lispvirsh-main))
       until (eq cmd "quit")))


(lispvirsh-main-loop)
