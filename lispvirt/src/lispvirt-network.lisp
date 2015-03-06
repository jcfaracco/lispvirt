;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-network.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-network
  (:use :cl :cffi))

(in-package :lispvirt-ffi)

;; Definitions of strucutres for Network.
(defcstruct virNetwork)

(defcstruct virNetworkDHCPLease)


;; Pointers mapping to structures.
(defctype virNetworkPtr (:pointer virNetwork))

(defctype virNetworkDHCPLeasePtr (:pointer virNetworkDHCPLease))


;; Methods
;; Get connection from network.
(defcfun "virNetworkGetConnect" virConnectPtr
	(network virNetworkPtr))


;; List active networks.
(defcfun "virConnectNumOfNetworks" :int
	(conn virConnectPtr))

(defcfun "virConnectListNetworks" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))


;; List inactive networks.
(defcfun "virConnectNumOfDefinedNetworks" :int
	(conn virConnectPtr))

(defcfun "virConnectListDefinedNetworks" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun "virConnectListAllNetworks" :int
	(conn virConnectPtr)
	(nets (:pointer (:pointer virNetworkPtr)))
	(flags :uint))


;; Lookup network by name or uuid.
(defcfun "virNetworkLookupByName" virNetworkPtr
	(conn virConnectPtr)
	(name :string))

(defcfun "virNetworkLookupByUUID" virNetworkPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virNetworkLookupByUUIDString" virNetworkPtr
	(conn virConnectPtr)
	(uuid :string))


;; Create active transient network
(defcfun "virNetworkCreateXML" virNetworkPtr
	(conn virConnectPtr)
	(xmlDesc :string))


;; Define inactive persistent network
(defcfun "virNetworkDefineXML" virNetworkPtr
	(conn virConnectPtr)
	(xmlDesc :string))


;; Delete persistent network
(defcfun "virNetworkUndefine" :int
	(network virNetworkPtr))

;; Update an existing network definition
(defcfun "virNetworkUpdate" :int
	(network virNetworkPtr)
	(command :uint)
	(section :uint)
	(parentIndex :int)
	(xml :string)
	(flags :uint))


;; Activate persistent network
(defcfun "virNetworkCreate" :int
	(network virNetworkPtr))


;; Network destroy/free
(defcfun "virNetworkDestroy" :int
	(network virNetworkPtr network))

(defcfun "virNetworkRef" :int
	(network virNetworkPtr network))

(defcfun "virNetworkFree" :int
	(network virNetworkPtr network))


;; Network information
(defcfun "virNetworkGetName" :string
	(network virNetworkPtr))

(defcfun "virNetworkGetUUID" :int
	(network virNetworkPtr)
	(uuid :string))

(defcfun "virNetworkGetUUIDString" :int
	(network virNetworkPtr)
	(buf :string))

(defcfun "virNetworkGetXMLDesc" :string
	(network virNetworkPtr)
	(flags :uint))

(defcfun "virNetworkGetBridgeName" :string
	(network virNetworkPtr))

(defcfun ("virNetworkGetAutostart" %virNetworkGetAutostart) :int
	(network virNetworkPtr)
	(autostart (:pointer :int)))

(defcfun "virNetworkSetAutostart" :int
	(network virNetworkPtr)
	(autostart :int))

(defcfun "virNetworkIsActive" :int
	(network virNetworkPtr))

(defcfun "virNetworkIsPersistent" :int
	(network virNetworkPtr))

(defcfun "virNetworkDHCPLeaseFree" :void
	(lease virNetworkDHCPLeasePtr))

(defcfun ("virNetworkGetDHCPLeases" %) :int
	(network virNetworkPtr)
	(mac :string)
	(leases (:pointer (:pointer virNetworkDHCPLeasePtr)))
	(flags :uint))

;;(defcfun "virConnectNetworkEventRegisterAny" :int
;;	(conn virConnectPtr)
;;	(network virNetworkPtr)
;;	(eventID :int)
;;	(cb virConnectNetworkEventGenericCallback)
;;	(opaque (:pointer :void))
;;	(freecb virFreeCallback))

(defcfun "virConnectNetworkEventDeregisterAny" :int
	(conn virConnectPtr)
	(callbackID :int))
