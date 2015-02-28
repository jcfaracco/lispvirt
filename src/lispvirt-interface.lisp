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
