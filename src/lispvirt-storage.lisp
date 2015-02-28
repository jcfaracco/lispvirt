(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-storage
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Definitions of strucutres for Storage.
(defcstruct virStoragePool)

(defcstruct virStoragePoolInfo)

(defcstruct virStorageVol)

(defcstruct virStorageVolInfo)


;; Pointers mapping to structures.
(defctype virStoragePoolPtr (:pointer virStoragePool))

(defctype virStoragePoolInfoPtr (:pointer virStoragePoolInfo))

(defctype virStorageVolPtr (:pointer virStorageVol))

(defctype virStorageVolInfoPtr (:pointer virStorageVolInfo))


;; Methods.
(defcfun "virStoragePoolGetConnect" virConnectPtr
	(pool virStoragePoolPtr))

(defcfun "virConnectNumOfStoragePools" :int
	(conn virConnectPtr))

(defcfun "virConnectListStoragePools" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun "virConnectNumOfDefinedStoragePools" :int
	(conn virConnectPtr))

(defcfun "virConnectListDefinedStoragePools" :int
	(conn virConnectPtr)
	(names (:pointer :string))
	(maxnames :int))

;;(defcfun "virConnectListAllStoragePools" :int
;;	(conn virConnectPtr)
;;	(pools (:pointer (:pointer virStoragePoolPtr)))
;;	(flags :uint))

(defcfun "virConnectFindStoragePoolSources" :string
	(conn virConnectPtr)
	(type :string)
	(srcSpec :string)
	(flags :uint))

(defcfun "virStoragePoolLookupByName" virStoragePoolPtr
	(conn virConnectPtr)
	(name :string))

(defcfun "virStoragePoolLookupByUUID" virStoragePoolPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virStoragePoolLookupByUUIDString" virStoragePoolPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virStoragePoolLookupByVolume" virStoragePoolPtr
    (vol virStorageVolPtr))

(defcfun "virStoragePoolCreateXML" virStoragePoolPtr
	(conn virConnectPtr)
	(xmlDesc :string)
	(flags :uint))

(defcfun "virStoragePoolDefineXML" virStoragePoolPtr
	(conn virConnectPtr)
	(xmlDesc :string)
	(flags :uint))

(defcfun "virStoragePoolBuild" :int
	(pool virStoragePoolPtr)
	(flags :uint))

(defcfun "virStoragePoolUndefine" :int
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolCreate" :int
	(pool virStoragePoolPtr)
	(flags :uint))

(defcfun "virStoragePoolDestroy" :int
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolDelete" :int
	(pool virStoragePoolPtr)
	(flags :uint))

(defcfun "virStoragePoolRef" :int
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolFree" :int
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolRefresh" :int
	(pool virStoragePoolPtr)
	(flags :uint))


;; StoragePool information
(defcfun "virStoragePoolGetName" :string
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolGetUUID" :int
	(pool virStoragePoolPtr)
	(uuid :string))

(defcfun "virStoragePoolGetUUIDString" :int
	(pool virStoragePoolPtr)
	(buf :string))

(defcfun "virStoragePoolGetInfo" :int
	(vol virStoragePoolPtr)
	(info virStoragePoolInfoPtr))

(defcfun "virStoragePoolGetXMLDesc" :string
	(pool virStoragePoolPtr)
	(flags :uint))

(defcfun ("virStoragePoolGetAutostart" %virStoragePoolGetAutostart) :int
	(pool virStoragePoolPtr)
	(autostart (:pointer :int)))

(defcfun "virStoragePoolSetAutostart" :int
	(pool virStoragePoolPtr)
	(autostart :int))


;; List/lookup storage volumes within a pool

(defcfun "virStoragePoolNumOfVolumes" :int
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolListVolumes" :int
	(pool virStoragePoolPtr)
	(names (:pointer :string))
	(maxnames :int))

(defcfun "virStoragePoolListAllVolumes" :int
	(pool virStoragePoolPtr)
	(vols (:pointer (:pointer virStorageVolPtr)))
	(flags :uint))

(defcfun "virStorageVolGetConnect" virConnectPtr
	(vol virStorageVolPtr))


;; Lookup volumes based on various attributes

(defcfun "virStorageVolLookupByName" virStorageVolPtr
	(pool virStoragePoolPtr)
	(name :string))

(defcfun "virStorageVolLookupByKey" virStorageVolPtr
	(conn virConnectPtr)
	(key :string))

(defcfun "virStorageVolLookupByPath" virStorageVolPtr
	(conn virConnectPtr)
	(path :string))

(defcfun "virStorageVolGetName" :string
	(vol virStorageVolPtr))

(defcfun "virStorageVolGetKey" :string
	(vol virStorageVolPtr))

(defcfun "virStorageVolCreateXML" virStorageVolPtr
	(pool virStoragePoolPtr)
	(xmldesc :string)
	(flags :uint))

(defcfun "virStorageVolCreateXMLFrom" virStorageVolPtr
	(pool virStoragePoolPtr)
	(xmldesc :string)
	(clonevol virStorageVolPtr)
	(flags :uint))

(defcfun "virStorageVolDownload" :int
	(vol virStorageVolPtr)
	(stream virStreamPtr)
	(offset :ullong)
	(length :ullong)
	(flags :uint))

(defcfun "virStorageVolUpload" :int
	(vol virStorageVolPtr)
	(stream virStreamPtr)
	(offset :ullong)
	(length :ullong)
	(flags :uint flags))

(defcfun "virStorageVolDelete" :int
	(vol virStorageVolPtr)
	(flags :uint))

(defcfun "virStorageVolWipe" :int
	(vol virStorageVolPtr)
	(flags :uint))

(defcfun "virStorageVolWipePattern" :int
	(vol virStorageVolPtr)
	(algorithm :uint)
	(flags :uint))

(defcfun "virStorageVolRef" :int
	(vol virStorageVolPtr))

(defcfun "virStorageVolFree" :int
	(vol virStorageVolPtr))

(defcfun "virStorageVolGetInfo" :int
	(vol virStorageVolPtr)
	(info virStorageVolInfoPtr))

(defcfun "virStorageVolGetXMLDesc" :string
	(pool virStorageVolPtr)
	(flags :uint))

(defcfun "virStorageVolGetPath" :string
	(vol virStorageVolPtr))

(defcfun "virStorageVolResize" :int
	(pool virStorageVolPtr)
	(capacity :ullong)
	(flags :uint))

(defcfun "virStoragePoolIsActive" :int
	(pool virStoragePoolPtr))

(defcfun "virStoragePoolIsPersistent" :int
	(pool virStoragePoolPtr))

