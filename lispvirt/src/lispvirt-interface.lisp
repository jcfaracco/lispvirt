;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-interface.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-interface
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Definitions of strucutres for Storage.
(defcstruct virInterface)


;; Pointers mapping to structures.
(defctype virInterfacePtr (:pointer virInterface))


;; Methods.
(defcfun "virInterfaceGetConnect" virConnectPtr
	(iface virInterfacePtr))

(defcfun "virConnectNumOfInterfaces" :int
	(conn virConnectPtr))

(defcfun "virConnectListInterfaces" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun "virConnectNumOfDefinedInterfaces" :int
	(conn virConnectPtr))

(defcfun "virConnectListDefinedInterfaces" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun "virConnectListAllInterfaces" :int
	(conn virConnectPtr)
	(ifaces (:pointer (:pointer virInterfacePtr)))
	(flags :uint))

(defcfun "virInterfaceLookupByName" virInterfacePtr
	(conn virConnectPtr)
	(name :string))

(defcfun "virInterfaceLookupByMACString" virInterfacePtr
	(conn virConnectPtr)
	(mac :string))

(defcfun "virInterfaceGetName" :string
	(iface virInterfacePtr))

(defcfun "virInterfaceGetMACString" :string
	(iface virInterfacePtr))

(defcfun "virInterfaceGetXMLDesc" :string
	(iface virInterfacePtr)
	(flags :uint))

(defcfun "virInterfaceDefineXML" virInterfacePtr
	(conn virConnectPtr)
	(xmlDesc :string)
	(flags :uint))

(defcfun "virInterfaceUndefine" :int
	(iface virInterfacePtr))

(defcfun "virInterfaceCreate" :int
	(iface virInterfacePtr)
	(flags :uint))

(defcfun "virInterfaceDestroy" :int
	(iface virInterfacePtr)
	(flags :uint))

(defcfun "virInterfaceRef" :int
	(iface virInterfacePtr))

(defcfun "virInterfaceFree" :int
	(iface virInterfacePtr))

(defcfun "virInterfaceChangeBegin" :int
	(conn virConnectPtr)
	(flags :uint))

(defcfun "virInterfaceChangeCommit" :int
	(conn virConnectPtr)
	(flags :uint))

(defcfun "virInterfaceChangeRollback" :int
	(conn virConnectPtr)
	(flags :uint))

(defcfun "virInterfaceIsActive" :int
	(iface virInterfacePtr))
