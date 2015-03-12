;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-lxc.lisp is part of Lispvirt.
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

(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-lxc
  (:use :cl :cffi :lispvirt-host :lispvirt-domain)
  (:export :virDomainLxcOpenNamespace
	   :virDomainLxcEnterNamespace
	   :virDomainLxcEnterSecurityLabel))

(in-package :lispvirt-lxc)


;; Methods
(defcfun ("virDomainLxcOpenNamespace" %virDomainLxcOpenNamespace) :int
	(domain virDomainPtr)
	(fdlist (:pointer (:pointer :int)))
	(flags :uint))

(defcfun ("virDomainLxcEnterNamespace" %virDomainLxcEnterNamespace) :int
	(domain virDomainPtr)
	(nfdlist :uint)
	(fdlist (:pointer :int))
	(noldfdlist (:pointer :uint))
	(oldfdlist (:pointer (:pointer :int)))
	(flags :uint))

(defcfun "virDomainLxcEnterSecurityLabel" :int
	(model virSecurityModelPtr)
	(label virSecurityLabelPtr)
	(oldLabel virSecurityLabelPtr)
	(flags :uint))
