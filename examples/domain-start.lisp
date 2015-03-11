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

(asdf:load-system :lispvirt)

(in-package lispvirt-domain)

;; Example methods for domain.
(defun list-all-active-domains (hypervisor)
  (let ((conn (virConnectOpen hypervisor)))
    (setq max (virConnectNumOfDomains conn))
    (virConnectListDomains conn max)))

(defun list-first-active-domain (hypervisor)
  (let ((conn (virConnectOpen hypervisor)))
    (setq max (virConnectNumOfDomains conn))
    (setq first (car (virConnectListDomains conn max)))
    (setq domain (virDomainLookupByID conn first))
    (list (virDomainGetName domain)
          (virDomainGetUUID domain)
          (virDomainGetOSType domain)
          (virDomainGetMaxMemory domain))))

;; Running methods.
(list-all-active-domains "qemu:///system")

(list-first-active-domain "qemu:///system")
