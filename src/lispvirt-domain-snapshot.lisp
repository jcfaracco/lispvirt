(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-secret
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


;; Definitions of strucutres for Storage.
(defcstruct virDomainSnapshot)

(defcenum virDomainSnapshotCreateFlags
        (:VIR_DOMAIN_SNAPSHOT_CREATE_REDEFINE 1)	;; Restore or alter metadata.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_CURRENT 2)		;; With redefine, make snapshot current.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_NO_METADATA 4)	;; Make snapshot without remembering it.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_HALT 8)		;; Stop running guest after snapshot.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_DISK_ONLY 16)	;; disk snapshot, not system checkpoint.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_REUSE_EXT 32)	;; reuse any existing external files.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_QUIESCE 64)	;; use guest agent to quiesce all mounted file systems within the domain.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_ATOMIC 128)	;; atomically avoid partial changes.
	(:VIR_DOMAIN_SNAPSHOT_CREATE_LIVE 256))		;; create the snapshot while the guest is running.

(defcenum virDomainSnapshotListFlags
	(:VIR_DOMAIN_SNAPSHOT_LIST_ROOTS 1)		;; Filter by snapshots with no parents, when listing a domain.
	(:VIR_DOMAIN_SNAPSHOT_LIST_DESCENDANTS 1)	;; List all descendants, not just children, when listing a snapshot.

	;; For historical reasons, groups do not use contiguous bits.

	(:VIR_DOMAIN_SNAPSHOT_LIST_LEAVES 4)		;; Filter by snapshots with no children.
	(:VIR_DOMAIN_SNAPSHOT_LIST_NO_LEAVES 8)		;; Filter by snapshots that have children.
	(:VIR_DOMAIN_SNAPSHOT_LIST_METADATA 2)		;; Filter by snapshots which have metadata.
	(:VIR_DOMAIN_SNAPSHOT_LIST_NO_METADATA 16)	;; Filter by snapshots with no metadata.	
	(:VIR_DOMAIN_SNAPSHOT_LIST_INACTIVE 32)		;; Filter by snapshots taken while guest was shut off.
	(:VIR_DOMAIN_SNAPSHOT_LIST_ACTIVE 64)		;; Filter by snapshots taken while guest was active, and with memory state.
	(:VIR_DOMAIN_SNAPSHOT_LIST_DISK_ONLY 128)	;; Filter by snapshots taken while guest was active, but without memory state.	
	(:VIR_DOMAIN_SNAPSHOT_LIST_INTERNAL 256)	;; Filter by snapshots stored internal to disk images.
	(:VIR_DOMAIN_SNAPSHOT_LIST_EXTERNAL 512))	;; Filter by snapshots that use files external to disk images.

(defcenum virDomainSnapshotRevertFlags
	(:VIR_DOMAIN_SNAPSHOT_REVERT_RUNNING 1)		;; Run after revert.
	(:VIR_DOMAIN_SNAPSHOT_REVERT_PAUSED 2) 		;; Pause after revert.
	(:VIR_DOMAIN_SNAPSHOT_REVERT_FORCE 4)) 		;; Allow risky reverts.

(defcenum virDomainSnapshotDeleteFlags
	(:VIR_DOMAIN_SNAPSHOT_DELETE_CHILDREN 1)	;; Also delete children.
	(:VIR_DOMAIN_SNAPSHOT_DELETE_METADATA_ONLY 2)	;; Delete just metadata.
	(:VIR_DOMAIN_SNAPSHOT_DELETE_CHILDREN_ONLY 4))	;; Delete just children.


;; Pointers mapping to structures.
(defctype virDomainSnapshotPtr (:pointer virDomainSnapshot))


;; Methods
(defcfun "virDomainSnapshotGetName" :string
	(snapshot virDomainSnapshotPtr))

(defcfun "virDomainSnapshotGetDomain" virDomainPtr
	(snapshot virDomainSnapshotPtr))

(defcfun "virDomainSnapshotGetConnect" virConnectPtr
	(snapshot virDomainSnapshotPtr))

;; Take a snapshot of the current VM state.
(defcfun "virDomainSnapshotCreateXML" virDomainSnapshotPtr
	(domain virDomainPtr)
	(xmlDesc :string)
	(flags :uint))

;; Dump the XML of a snapshot.
(defcfun "virDomainSnapshotGetXMLDesc" :string
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

;; Return the number of snapshots for this domain.
(defcfun "virDomainSnapshotNum" :int
	(domain virDomainPtr)
	(flags :uint))

;; Get the names of all snapshots for this domain.
(defcfun "virDomainSnapshotListNames" :int
	(domain virDomainPtr)
	(names (:pointer :string))
	(nameslen :int)
	(flags :uint))

;; Get all snapshot objects for this domain.
(defcfun "virDomainListAllSnapshots" :int
	(domain virDomainPtr)
	(snaps (:pointer (:pointer virDomainSnapshotPtr)))
	(flags :uint))

;; Return the number of child snapshots for this snapshot.
(defcfun "virDomainSnapshotNumChildren" :int
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

;; Get the names of all child snapshots for this snapshot.
(defcfun "virDomainSnapshotListChildrenNames" :int
	(snapshot virDomainSnapshotPtr)
	(names (:pointer :string))
	(nameslen :int)
	(flags :uint))

;; Get all snapshot object children for this snapshot.
(defcfun "virDomainSnapshotListAllChildren" :int
	(snapshot virDomainSnapshotPtr)
	(snaps (:pointer (:pointer virDomainSnapshotPtr)))
	(flags :uint))

;; Get a handle to a named snapshot.
(defcfun "virDomainSnapshotLookupByName" virDomainSnapshotPtr
	(domain virDomainPtr)
	(name :string)
	(flags :uint))

;; Check whether a domain has a snapshot which is currently used.
(defcfun "virDomainHasCurrentSnapshot" :int
	(domain virDomainPtr)
	(flags :uint))

;; Get a handle to the current snapshot.
(defcfun "virDomainSnapshotCurrent" virDomainSnapshotPtr
	(domain virDomainPtr)
	(flags :uint))

;; Get a handle to the parent snapshot, if one exists.
(defcfun "virDomainSnapshotGetParent" virDomainSnapshotPtr
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

;; Determine if a snapshot is the current snapshot of its domain.
(defcfun "virDomainSnapshotIsCurrent" :int
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

;; Determine if a snapshot has associated libvirt metadata that would prevent the deletion of its domain.
(defcfun "virDomainSnapshotHasMetadata" :int
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

(defcfun "virDomainRevertToSnapshot" :int
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

(defcfun "virDomainSnapshotDelete" :int
	(snapshot virDomainSnapshotPtr)
	(flags :uint))

(defcfun "virDomainSnapshotRef" :int
	(snapshot virDomainSnapshotPtr))

(defcfun "virDomainSnapshotFree" :int
	(snapshot virDomainSnapshotPtr))

