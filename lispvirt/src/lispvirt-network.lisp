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
  (:use :cl :cffi :lispvirt-host)
  (:export :virNetworkPtr
	   :virNetworkDHCPLeasePtr
	   :virNetworkGetConnect
	   :virConnectNumOfNetworks
	   :virConnectListNetworks
	   :virConnectNumOfDefinedNetworks
	   :virConnectListDefinedNetworks
	   :virConnectListAllNetworks
	   :virNetworkLookupByName
	   :virNetworkLookupByUUID
	   :virNetworkLookupByUUIDString
	   :virNetworkCreateXML
	   :virNetworkDefineXML
	   :virNetworkUndefine
	   :virNetworkUpdate
	   :virNetworkCreate
	   :virNetworkDestroy
	   :virNetworkRef
	   :virNetworkFree
	   :virNetworkGetName
	   :virNetworkGetXMLDesc
	   :virNetworkGetBridgeName
	   :virNetworkGetAutostart
	   :virNetworkSetAutostart
	   :virNetworkIsActive
	   :virNetworkIsPersistent
	   :virNetworkDHCPLeaseFree
	   :virNetworkGetDHCPLeases
	   :virConnectNetworkEventDeregisterAny))

(in-package :lispvirt-network)

;; Definitions of strucutres for Network.
(defcstruct virNetwork)

(defcstruct virNetworkDHCPLease)

(defcenum virNetworkXMLFlags
	(:VIR_NETWORK_XML_INACTIVE 1))	;; dump inactive network information.

(defcenum virConnectListAllNetworksFlags
	(:VIR_CONNECT_LIST_NETWORKS_INACTIVE 1)
	(:VIR_CONNECT_LIST_NETWORKS_ACTIVE 2)
	(:VIR_CONNECT_LIST_NETWORKS_PERSISTENT 4)
	(:VIR_CONNECT_LIST_NETWORKS_TRANSIENT 8)
	(:VIR_CONNECT_LIST_NETWORKS_AUTOSTART 16)
	(:VIR_CONNECT_LIST_NETWORKS_NO_AUTOSTART 32))

(defcenum virNetworkUpdateCommand
	(:VIR_NETWORK_UPDATE_COMMAND_NONE 0)		;; (invalid).
	(:VIR_NETWORK_UPDATE_COMMAND_MODIFY 1)		;; modify an existing element.
	(:VIR_NETWORK_UPDATE_COMMAND_DELETE 2)		;; delete an existing element.
	(:VIR_NETWORK_UPDATE_COMMAND_ADD_LAST 3)	;; add an element at end of list.
	(:VIR_NETWORK_UPDATE_COMMAND_ADD_FIRST 4)	;; add an element at start of list.
	(:VIR_NETWORK_UPDATE_COMMAND_LAST 5))

(defcenum virNetworkUpdateSection
	(:VIR_NETWORK_SECTION_NONE 0)			;; (invalid).
	(:VIR_NETWORK_SECTION_BRIDGE 1)			;; <bridge>.
	(:VIR_NETWORK_SECTION_DOMAIN 2)			;; <domain>.
	(:VIR_NETWORK_SECTION_IP 3)			;; <ip>.
	(:VIR_NETWORK_SECTION_IP_DHCP_HOST 4)		;; <ip>/<dhcp>/<host>.
	(:VIR_NETWORK_SECTION_IP_DHCP_RANGE 5)		;; <ip>/<dhcp>/<range>.
	(:VIR_NETWORK_SECTION_FORWARD 6)		;; <forward>.
	(:VIR_NETWORK_SECTION_FORWARD_INTERFACE 7)	;; <forward>/<interface>.
	(:VIR_NETWORK_SECTION_FORWARD_PF 8)		;; <forward>/<pf>.
	(:VIR_NETWORK_SECTION_PORTGROUP 9)		;; <portgroup>.
	(:VIR_NETWORK_SECTION_DNS_HOST 10)		;; <dns>/<host>.
	(:VIR_NETWORK_SECTION_DNS_TXT 11)		;; <dns>/<txt>.
	(:VIR_NETWORK_SECTION_DNS_SRV 12)		;; <dns>/<srv>.
	(:VIR_NETWORK_SECTION_LAST 13))

(defcenum virNetworkUpdateFlags
	(:VIR_NETWORK_UPDATE_AFFECT_CURRENT 0)	;; affect live if network is active, config if it's not active.
	(:VIR_NETWORK_UPDATE_AFFECT_LIVE 1)	;; affect live state of network only.
	(:VIR_NETWORK_UPDATE_AFFECT_CONFIG 2))	;; affect persistent config only.

(defcenum virNetworkEventLifecycleType
	(:VIR_NETWORK_EVENT_DEFINED 0)
	(:VIR_NETWORK_EVENT_UNDEFINED 1)
	(:VIR_NETWORK_EVENT_STARTED 2)
	(:VIR_NETWORK_EVENT_STOPPED 3)
	(:VIR_NETWORK_EVENT_LAST 4))

(defcenum virNetworkEventID
	(:VIR_NETWORK_EVENT_ID_LIFECYCLE 0)	;; virConnectNetworkEventLifecycleCallback.
	(:VIR_NETWORK_EVENT_ID_LAST 1))

(defcenum virIPAddrType
	(:VIR_IP_ADDR_TYPE_IPV4 1)
	(:VIR_IP_ADDR_TYPE_IPV6 2)
	(:VIR_IP_ADDR_TYPE_LAST 3))


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

(defcfun ("virConnectListNetworks" %virConnectListNetworks) :int
	(conn virConnectPtr)
	(names :pointer :string)
	(maxnames :int))

(defun virConnectListNetworks (conn maxnames)
	(with-foreign-objects ((names :string))
		(%virConnectListNetworks conn names maxnames)
		(values
			(loop for i from 0 to (- maxnames 1)
				collect (mem-aref names :string i)))))

;; List inactive networks.
(defcfun "virConnectNumOfDefinedNetworks" :int
	(conn virConnectPtr))

(defcfun "virConnectListDefinedNetworks" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun ("virConnectListAllNetworks" %virConnectListAllNetworks) :int
	(conn virConnectPtr)
	(nets :pointer :pointer)
	(flags :uint))

(defun virConnectListAllNetworks (conn flags)
        (with-foreign-objects ((nets :pointer))
                (%virConnectListAllNetworks conn nets flags)
                (values
                        (loop for i from 0 to (- (virConnectNumOfDefinedNetworks conn) 1)
                                collect (mem-aref (mem-aref nets :pointer 0) :pointer i)))))


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

(defun virNetworkGetAutostart (network)
        (with-foreign-objects ((autostart :int))
                (%virNetworkGetAutostart network autostart)
                (values (mem-ref autostart :int))))

(defcfun "virNetworkSetAutostart" :int
	(network virNetworkPtr)
	(autostart :int))

(defcfun "virNetworkIsActive" :int
	(network virNetworkPtr))

(defcfun "virNetworkIsPersistent" :int
	(network virNetworkPtr))

(defcfun "virNetworkDHCPLeaseFree" :void
	(lease virNetworkDHCPLeasePtr))

(defcfun ("virNetworkGetDHCPLeases" %virNetworkGetDHCPLeases) :int
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
