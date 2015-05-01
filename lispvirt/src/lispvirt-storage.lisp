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
	   :virStoragePoolIsPersistent
	   :virStoragePoolState
	   :virStoragePoolBuildFlags
	   :virStoragePoolDeleteFlags
	   :virStorageVolType
	   :virStorageVolDeleteFlags
	   :virStorageVolWipeAlgorithm
	   :virStorageXMLFlags
	   :virConnectListAllStoragePoolsFlags
	   :virStorageVolCreateFlags
	   :virStorageVolResizeFlags))

(in-package :lispvirt-storage)


;; Definitions of strucutres for Storage.
(defcstruct virStoragePool)

(defcstruct virStoragePoolInfo)

(defcstruct virStorageVol)

(defcstruct virStorageVolInfo)

(defcenum virStoragePoolState
	(:VIR_STORAGE_POOL_INACTIVE 0)		;; Not running.
	(:VIR_STORAGE_POOL_BUILDING 1)		;; Initializing pool, not available.
	(:VIR_STORAGE_POOL_RUNNING 2)		;; Running normally.
	(:VIR_STORAGE_POOL_DEGRADED 3)		;; Running degraded.
	(:VIR_STORAGE_POOL_INACCESSIBLE 4)	;; Running, but not accessible.
	(:VIR_STORAGE_POOL_STATE_LAST 5))

(defcenum virStoragePoolBuildFlags
	(:VIR_STORAGE_POOL_BUILD_NEW 0)			;; Regular build from scratch.
	(:VIR_STORAGE_POOL_BUILD_REPAIR 1)		;; Repair / reinitialize.
	(:VIR_STORAGE_POOL_BUILD_RESIZE 2)		;; Extend existing pool.
	(:VIR_STORAGE_POOL_BUILD_NO_OVERWRITE 4)	;; Do not overwrite existing pool.
	(:VIR_STORAGE_POOL_BUILD_OVERWRITE 8))		;; Overwrite data.

(defcenum virStoragePoolDeleteFlags
	(:VIR_STORAGE_POOL_DELETE_NORMAL 0)	;; Delete metadata only (fast).
	(:VIR_STORAGE_POOL_DELETE_ZEROED 1))	;; Clear all data to zeros (slow).

(defcenum virStorageVolType
	(:VIR_STORAGE_VOL_FILE 0)	;; Regular file based volumes.
	(:VIR_STORAGE_VOL_BLOCK 1)	;; Block based volumes.
	(:VIR_STORAGE_VOL_DIR 2)	;; Directory-passthrough based volume.
	(:VIR_STORAGE_VOL_NETWORK 3)	;; Network volumes like RBD (RADOS Block Device).
	(:VIR_STORAGE_VOL_NETDIR 4)	;; Network accessible directory that can
	(:VIR_STORAGE_VOL_LAST 5))

(defcenum virStorageVolDeleteFlags
	(:VIR_STORAGE_VOL_DELETE_NORMAL 0)	;; Delete metadata only (fast).
	(:VIR_STORAGE_VOL_DELETE_ZEROED 1))	;; Clear all data to zeros (slow).

(defcenum virStorageVolWipeAlgorithm
	(:VIR_STORAGE_VOL_WIPE_ALG_ZERO 0)		;; 1-pass, all zeroes.
	(:VIR_STORAGE_VOL_WIPE_ALG_NNSA 1)		;; 4-pass  NNSA Policy Letter NAP-14.1-C (XVI-8).
	(:VIR_STORAGE_VOL_WIPE_ALG_DOD 2)		;; 4-pass DoD 5220.22-M section 8-306 procedure.
	(:VIR_STORAGE_VOL_WIPE_ALG_BSI 3)		;; 9-pass method recommended by the German Center of Security in Information Technologies.
	(:VIR_STORAGE_VOL_WIPE_ALG_GUTMANN 4)		;; The canonical 35-pass sequence.
	(:VIR_STORAGE_VOL_WIPE_ALG_SCHNEIER 5)		;; 7-pass method described by Bruce Schneier in "Applied Cryptography" (1996).
	(:VIR_STORAGE_VOL_WIPE_ALG_PFITZNER7 6)		;; 7-pass random.
	(:VIR_STORAGE_VOL_WIPE_ALG_PFITZNER33 7)	;; 33-pass random.
	(:VIR_STORAGE_VOL_WIPE_ALG_RANDOM 8)		;; 1-pass random.
	(:VIR_STORAGE_VOL_WIPE_ALG_LAST 9))

(defcenum virStorageXMLFlags
	(:VIR_STORAGE_XML_INACTIVE 1))	;; dump inactive pool/volume information.

(defcenum virConnectListAllStoragePoolsFlags
	(:VIR_CONNECT_LIST_STORAGE_POOLS_INACTIVE 1)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_ACTIVE 2)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_PERSISTENT 4)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_TRANSIENT 8)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_AUTOSTART 16)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_NO_AUTOSTART 32)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_DIR 64)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_FS 128)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_NETFS 256)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_LOGICAL 512)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_DISK 1024)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_ISCSI 2048)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_SCSI 4096)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_MPATH 8192)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_RBD 16384)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_SHEEPDOG 32768)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_GLUSTER 65536)
	(:VIR_CONNECT_LIST_STORAGE_POOLS_ZFS 131072))

(defcenum virStorageVolCreateFlags
	(:VIR_STORAGE_VOL_CREATE_PREALLOC_METADATA 1)
	(:VIR_STORAGE_VOL_CREATE_REFLINK 2))		 ;; perform a btrfs lightweight copy.

(defcenum virStorageVolResizeFlags
	(:VIR_STORAGE_VOL_RESIZE_ALLOCATE 1)	;; force allocation of new size.
	(:VIR_STORAGE_VOL_RESIZE_DELTA    2)	;; size is relative to current.
	(:VIR_STORAGE_VOL_RESIZE_SHRINK   4))	;; allow decrease in capacity.


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

(defun virStoragePoolGetAutostart (pool)
        (with-foreign-objects ((autostart :int))
                (%virStoragePoolGetAutostart pool autostart)
                (values (mem-ref autostart :int))))

(defcfun "virStoragePoolSetAutostart" :int
	(pool virStoragePoolPtr)
	(autostart :int))


;; List/lookup storage volumes within a pool

(defcfun "virStoragePoolNumOfVolumes" :int
	(pool virStoragePoolPtr))

(defcfun ("virStoragePoolListVolumes" %virStoragePoolListVolumes) :int
	(pool virStoragePoolPtr)
	(names (:pointer :string))
	(maxnames :int))

(defun virStoragePoolListVolumes (pool maxnames)
	(with-foreign-objects ((names-r :string))
                (%virStoragePoolListVolumes pool names-r maxnames)
			(iter (with names = (mem-ref names-r :pointer))
                              (for i from 0 below maxnames)
                                (collect (mem-aref names :string i)))))

(defcfun ("virStoragePoolListAllVolumes" %virStoragePoolListAllVolumes) :int
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

