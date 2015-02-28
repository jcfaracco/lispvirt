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
