;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirsh.lisp is part of Lispvirt.
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
  "Start a domain specified by command line."
  (let ((flags (foreign-enum-value 'virDomainCreateFlags
                                   :VIR_DOMAIN_NONE))
        (domain (virDomainLookupByName conn (car (cdr command-line)))))
    (if (not (eq (virDomainGetID domain) -1))
        (format t "Domain is already active!~%")
        (if (not (eq domain nil))
            (if (boole boole-and flags
                       (foreign-enum-value 'virDomainCreateFlags
                                           :VIR_DOMAIN_START_FORCE_BOOT))
                (progn
		  (format t "Starting...~%")
                  (virDomainCreateWithFlags domain flags)
                  (virDomainFree domain)))))))

(defun cmd-shutdown (conn command-line)
  "Shutdown a domain specified by command line."
  (let ((domain (virDomainLookupByName conn (car (cdr command-line))))
        (flags (foreign-enum-value 'virDomainShutdownFlagValues
                                   :VIR_DOMAIN_SHUTDOWN_ACPI_POWER_BTN)))
    (if (not (eq domain nil))
        (if (not (eq flags 0))
            (progn
	      (format t "Shuting down...~%")
              (virDomainShutdownFlags domain 1)
              (virDomainFree domain))
            (progn
	      (format t "Shuting down...~%")
              (virDomainShutdown domain)
              (virDomainFree domain)))
        (format t "Domain does not exists!~%"))))


(defun cmd-dumpxml (conn command-line)
  "Print the XML description of a domain specified by command line."
  (let ((domain (virDomainLookupByName conn (car (cdr command-line)))))
    (if (not (eq domain nil))
        (format t "~S~%" (virDomainGetXMLDesc domain
                                    (foreign-enum-value 'virDomainXMLFlags
                                                        :VIR_DOMAIN_XML_INACTIVE)))
        (format t "Domain does not exists!~%"))))

(defun print-domain (conn domain_name)
  "Print a pretty output for domain settings."
  (let ((domain (virDomainLookupByName conn domain_name)))
    (format t "~S~50T~D~65T ~S~%"
            domain_name
            (virDomainGetMaxMemory domain)
            (virDOmainGetOSType domain))))

(defun cmd-list-domain-active (conn)
  "List all active domains."
  (let ((max_active (virConnectNumOfDomains conn)))
    (setq domains_ids (virConnectListDomains conn max_active))
    (loop for domain in domains_ids
         collect (virDomainGetName
                  (virDomainLookupByID conn domain)))))

(defun cmd-list-domain-defined (conn)
  "List only the defined (inactive) domains."
  (let ((max_defined (virConnectNumOfDefinedDomains conn)))
    (setq domains_defined (virConnectListAllDomains conn max_defined))
    (loop for domain in domains_defined
       collect (virDomainGetName domain))))

(defun cmd-list-domain (conn command-line)
  "List the domains considering the input passed by command line. It can list the active, inactive and all domains."
  (let ((type (car (cdr command-line))))
    (if (= (length command-line) 1)
        (progn
          (format t "Domains:~%")
          (format t "Name:~50TMemory:~65T OS Hypervisor:~%")
          (loop for domain_name_active in (cmd-list-domain-active conn) do
               (print-domain conn domain_name_active))))
    (if (string= type "--all")
        (progn
          (format t "All Domains:~%")
          (format t "Name:~50TMemory:~65T OS Hypervisor:~%")
          (loop for domain_name_active in (cmd-list-domain-active conn) do
               (print-domain conn domain_name_active))
          (loop for domain_name_defined in (cmd-list-domain-defined conn) do
               (print-domain conn domain_name_defined))))
    (if (string= type "--inactive")
        (progn
          (format t "Inactive Domains:~%")
          (format t "Name:~50TMemory:~65T OS Hypervisor:~%")
          (loop for domain_name_defined in (cmd-list-domain-defined conn) do
               (print-domain conn domain_name_defined))))))

;; TODO: we should use nicknames to avoid this long name when we call a function
;; defined in another package.
(defun print-network (conn net)
  "Print a pretty output for network settings."
  (let ((domain (lispvirt-network:virNetworkLookupByName conn net)))
    (format t "~S~20T~D~30T~D~40T~D~%"
            net
            (lispvirt-network:virNetworkIsActive domain)
            (lispvirt-network:virNetworkIsPersistent domain)
            (lispvirt-network:virNetworkGetAutostart domain))))

(defun cmd-list-network-actives (conn)
  "List all active networks."
  (let ((max_nets (lispvirt-network:virConnectNumOfNetworks conn)))
    (setq nets (lispvirt-network:virConnectListNetworks conn max_nets))
    (if (not (= (length nets) 0))
        (progn
          (format t "Name:~20TActive:~30TPersistent:~40TAutostart:~%")
          (loop for net in nets do
               (print-network conn net))))))
 
(defun cmd-usage (command-line)
  "Print which commands you can use on terminal. This function is used for help too."
  (format t "Usage:~%~%")
  (format t "~TCommands:~%")
  (format t "~5Thelp: ~40Tshow commands that can be used.~%")
  (format t "~5Tlist {--all|--inactive|None}: ~40Tlist the domains according the parameter used.~%")
  (format t "~5Tdumpxml domain_name: ~40Tshow the XML with the domain settings.~%")
  (format t "~5Tstart domain_name: ~40Tstart the domain according its domain_name.~%")
  (format t "~5Tshutdown domain_name: ~40Tshutdown the domain according its domain_name.~%"))

(defun lispvirsh-main ()
  "Function to set the correct option for lispvirsh terminal."
  (format t ">> ")
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
        (cmd-list-domain conn command-line))
    (if (string= (car command-line) "net-list")
        (cmd-list-network-actives conn))
    (if (string= (car command-line) "help")
        (cmd-usage command-line))
    (list option)))

(defun lispvirsh-main-loop ()
  "Function to call the main loop for lispvirsh terminal while the user does not insert the 'quit' command."
  (loop with val = "quit"
     do (setq cmd (lispvirsh-main))
       until (string= (car cmd) "quit")))

(lispvirsh-main-loop)
