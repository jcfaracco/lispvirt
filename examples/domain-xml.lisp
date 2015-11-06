;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; domain-xml.lisp is part of Lispvirt.
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

(asdf:oos 'asdf:load-op :xmls)


(require 'xmls)

(use-package 'xmls)


(in-package lispvirt-domain)

;; Example methods for domain.

;; This method receive the hypervisor string and find
;; the first active domain. If it finds, the method will
;; return its XML Description.
(defun first-domain-to-xml (hypervisor)
  (let ((conn (virConnectOpen hypervisor)))
    (setq max (virConnectNumOfDomains conn))
    (setq first (car (virConnectListDomains conn max)))
    (setq domain (virDomainLookupByID conn first))
    (virDomainGetXMLDesc domain
                         (foreign-enum-value 'virDomainXMLFlags             ;; How to use enums.
                                             :VIR_DOMAIN_XML_INACTIVE))))

;; This method convert the XML Description from a Domain
;; into a list with some informations.
(defun xml-to-info (XMLDesc)
  (let ((tree (parse XMLDesc)))
    (list (car (last (car (xmlrep-attribs tree))))
          (car (last (xmlrep-find-child-tag "name" tree)))
          (car (last (xmlrep-find-child-tag "uuid" tree)))
          (car (last (xmlrep-find-child-tag "memory" tree)))
          (car (last (xmlrep-find-child-tag "vcpu" tree))))))


;; Running methods.
(xml-to-info (first-domain-to-xml "qemu:///system"))
