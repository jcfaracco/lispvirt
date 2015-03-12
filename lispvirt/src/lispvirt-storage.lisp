;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-storage.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-storage
  (:use :cl :cffi :lispvirt-host)
  (:export :virStoragePoolPtr
	   :virStoragePoolInfoPtr
	   :virStorageVolPtr
	   :virStorageVolInfoPtr
	   :virStoragePoolGetConnect
	   :virConnectNumOfStoragePools
	   :virConnectListStoragePools
	   :virConnectNumOfDefinedStoragePools
	   :virConnectListDefinedStoragePools
	   :virConnectFindStoragePoolSources
	   :virStoragePoolLookupByName
	   :virStoragePoolLookupByUUID
	   :virStoragePoolLookupByUUIDString
	   :virStoragePoolLookupByVolume
	   :virStoragePoolCreateXML
	   :virStoragePoolDefineXML
	   :virStoragePoolBuild
	   :virStoragePoolUndefine
	   :virStoragePoolCreate
	   :virStoragePoolDestroy
	   :virStoragePoolDelete
	   :virStoragePoolRef
	   :virStoragePoolFree
	   :virStoragePoolRefresh
	   :virStoragePoolGetName
	   :virStoragePoolGetUUID
	   :virStoragePoolGetUUIDString
	   :virStoragePoolGetInfo
	   :virStoragePoolGetXMLDesc
	   :virStoragePoolGetAutostart
	   :virStoragePoolSetAutostart
	   :virStoragePoolNumOfVolumes
	   :virStoragePoolListVolumes
	   :virStoragePoolListAllVolumes
	   :virStorageVolGetConnect
	   :virStorageVolLookupByName
	   :virStorageVolLookupByKey
	   :virStorageVolLookupByPath
	   :virStorageVolGetName
	   :virStorageVolGetKey
	   :virStorageVolCreateXML
	   :virStorageVolCreateXMLFrom
	   :virStorageVolDownload
	   :virStorageVolUpload
	   :virStorageVolDelete
	   :virStorageVolWipe
	   :virStorageVolWipePattern
	   :virStorageVolRef
	   :virStorageVolFree
	   :virStorageVolGetInfo
	   :virStorageVolGetXMLDesc
	   :virStorageVolGetPath
	   :virStorageVolResize
	   :virStoragePoolIsActive
	   :virStoragePoolIsPersistent))

(in-package :lispvirt-storage)


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

