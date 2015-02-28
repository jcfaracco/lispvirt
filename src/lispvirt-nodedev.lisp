(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-nodedev
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Definitions of strucutres for Storage.
(defcstruct virNodeDevice)

(defcenum virConnectListAllNodeDeviceFlags
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_SYSTEM 1)		;; System capability.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_PCI_DEV 2)		;; PCI device.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_USB_DEV 4)		;; USB device.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_USB_INTERFACE 8)	;; USB interface.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_NET 16)		;; Network device.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_SCSI_HOST 32)	;; SCSI Host Bus Adapter.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_SCSI_TARGET 64)	;; SCSI Target.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_SCSI 128)		;; SCSI device.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_STORAGE 256)	;; Storage device.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_FC_HOST 512)	;; FC Host Bus Adapter.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_VPORTS 1024)	;; Capable of vport.
	(:VIR_CONNECT_LIST_NODE_DEVICES_CAP_SCSI_GENERIC 2048))	;; Capable of scsi_generic.

;; Pointers mapping to structures.
(defctype virNodeDevicePtr (:pointer virNodeDevice))


;; Methods
(defcfun "virNodeNumOfDevices" :int
	(conn virConnectPtr)
	(cap :string)
	(flags :uint))

(defcfun ("virNodeListDevices" %virNodeListDevices) :int
	(conn virConnectPtr)
	(cap :string)
	(names (:pointer (:pointer :string)))
	(maxnames :int)
	(flags :uint))

(defcfun "virNodeDeviceLookupSCSIHostByWWN" virNodeDevicePtr
	(conn virConnectPtr)
	(wwnn :string)
	(wwpn :string)
	(flags :uint))

(defcfun "virNodeDeviceGetName" :string
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceGetParent" :string
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceNumOfCaps" :int
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceListCaps" :int
	(dev virNodeDevicePtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun "virNodeDeviceGetXMLDesc" :string
	(dev virNodeDevicePtr)
	(flags :uint))

(defcfun "virNodeDeviceRef" :int
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceFree" :int
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceDettach" :int
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceDetachFlags" :int
	(dev virNodeDevicePtr)
	(driverName :string)
	(flags :uint))

(defcfun "virNodeDeviceReAttach" :int
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceReset" :int
	(dev virNodeDevicePtr))

(defcfun "virNodeDeviceCreateXML" virNodeDevicePtr
	(conn virConnectPtr)
	(xmlDesc :string)
	(flags :uint))

(defcfun "virNodeDeviceDestroy" :int
	(dev virNodeDevicePtr))
