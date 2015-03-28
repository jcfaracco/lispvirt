;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-domain.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-domain
  (:use :cl :cffi :lispvirt-host :lispvirt-ffi)
  (:export :virDomainPtr
	   :virDomainInfoPtr
	   :virDomainControlInfoPtr
	   :virDomainBlockStatsPtr
	   :virDomainInterfaceStatsPtr
	   :virDomainMemoryStatPtr
	   :virDomainBlockInfoPtr
	   :virVcpuInfoPtr
	   :virDomainStatsRecordPtr
	   :virDomainBlockJobInfoPtr
	   :virDomainDiskErrorPtr
	   :virDomainJobInfoPtr
	   :virDomainFSInfoPtr
	   :virDomainState
	   :virDomainNostateReason
	   :virDomainRunningReason
	   :virDomainBlockedReason
	   :virDomainPausedReason
	   :virDomainShutdownReason
	   :virDomainShutoffReason
	   :virDomainCrashedReason
	   :virDomainPMSuspendedReason
	   :virDomainPMSuspendedDiskReason
	   :virDomainXMLFlags
	   :virDomainCreateFlags
	   :virDomainShutdownFlagValues
	   :virDomainRebootFlagValues
	   :virDomainGetName
	   :virDomainGetID
	   :virDomainGetUUID
	   :virDomainGetUUIDString
	   :virDomainGetOSType
	   :virDomainGetMaxMemory
	   :virDomainSetMaxMemory
	   :virDomainSetMemory
	   :virDomainSetMemoryFlags
	   :virDomainSetMemoryStatsPeriod
	   :virDomainGetMaxVcpus
	   :virDomainGetSecurityLabel
	   :virDomainGetHostname
	   :virDomainGetSecurityLabelList
	   :virDomainSetMetadata
	   :virDomainGetMetadata
	   :virDomainGetXMLDesc
	   :virConnectDomainXMLFromNative
	   :virConnectDomainXMLToNative
	   :virDomainBlockStats
	   :virDomainBlockStatsFlags
	   :virDomainInterfaceStats
	   :virDomainSetInterfaceParameters
	   :virDomainGetInterfaceParameters
	   :virDomainBlockPeek
	   :virDomainBlockResize
	   :virDomainGetBlockInfo
	   :virDomainGetSchedulerParameters
	   :virDomainGetSchedulerParametersFlags
	   :virDomainSetSchedulerParameters
	   :virDomainSetSchedulerParametersFlags
	   :virDomainMigrate
	   :virDomainMigrate2
	   :virDomainMigrate3
	   :virDomainMigrateToURI
	   :virDomainMigrateToURI2
	   :virDomainMigrateToURI3
	   :virDomainMigrateSetMaxDowntime
	   :virDomainMigrateGetCompressionCache
	   :virDomainMigrateSetCompressionCache
	   :virDomainMigrateSetMaxSpeed
	   :virDomainMigrateGetMaxSpeed
	   :virConnectGetDomainCapabilities
	   :virConnectListDomains
	   :virConnectListAllDomains
	   :virConnectNumOfDomains
	   :virDomainGetConnect
	   :virDomainCreateXML
	   :virDomainCreateXMLWithFiles
	   :virDomainLookupByName
	   :virDomainLookupByID
	   :virDomainLookupByUUID
	   :virDomainLookupByUUIDString
	   :virDomainShutdown
	   :virDomainShutdownFlags
	   :virDomainReboot
	   :virDomainReset
	   :virDomainDestroy
	   :virDomainDestroyFlags
	   :virDomainRef
	   :virDomainFree
	   :virDomainSuspend
	   :virDomainResume
	   :virDomainPMSuspendForDuration
	   :virDomainPMWakeup
	   :virDomainSave
	   :virDomainSaveFlags
	   :virDomainRestore
	   :virDomainRestoreFlags
	   :virDomainSaveImageGetXMLDesc
	   :virDomainSaveImageDefineXML
	   :virDomainManagedSave
	   :virDomainHasManagedSaveImage
	   :virDomainManagedSaveRemove
	   :virDomainCoreDump
	   :virDomainCoreDumpWithFormat
	   :virDomainScreenshot
	   :virDomainGetInfo
	   :virDomainGetState
	   :virDomainGetCPUStats
	   :virDomainGetControlInfo
	   :virDomainGetSchedulerType
	   :virDomainSetBlkioParameters
	   :virDomainGetBlkioParameters
	   :virDomainSetMemoryParameters
	   :virDomainGetMemoryParameters
	   :virDomainSetNumaParameters
	   :virDomainGetNumaParameters
	   :virDomainMemoryStats
           :virDomainMemoryPeek
           :virDomainDefineXML
           :virDomainDefineXMLFlags
           :virDomainUndefine
           :virDomainUndefineFlags
           :virConnectNumOfDefinedDomains
           :virDomainCreate
           :virDomainCreateWithFlags
           :virDomainCreateWithFiles
           :virDomainGetAutostart
           :virDomainSetAutostart
           :virDomainSetVcpus
           :virDomainSetVcpusFlags
           :virDomainGetVcpusFlags
           :virDomainPinVcpu
           :virDomainPinVcpuFlags
           :virDomainGetVcpuPinInfo
           :virDomainPinEmulator
           :virDomainGetEmulatorPinInfo
           :virDomainGetVcpus
           :virDomainAttachDevice
           :virDomainDetachDevice
           :virDomainAttachDeviceFlags
           :virDomainDetachDeviceFlags
           :virDomainUpdateDeviceFlags
           :virConnectGetAllDomainStats
           :virDomainListGetStats
           :virDomainStatsRecordListFree
           :virDomainBlockJobAbort
           :virDomainGetBlockJobInfo
           :virDomainBlockJobSetSpeed
           :virDomainBlockPull
           :virDomainBlockRebase
           :virDomainBlockCopy
           :virDomainBlockCommit
           :virDomainSetBlockIoTune
           :virDomainGetBlockIoTunet
           :virDomainGetDiskErrors
           :virDomainSendKey
           :virDomainSendProcessSignal
           :virDomainGetJobInfo
           :virDomainGetJobStats
           :virDomainAbortJob
           :virConnectDomainEventDeregisterAny
           :virDomainOpenConsole
           :virDomainOpenChannel
           :virDomainOpenGraphics
           :virDomainOpenGraphicsFD
           :virDomainInjectNMI
           :virDomainFSTrim
           :virDomainFSFreeze
           :virDomainFSThaw
           :virDomainFSInfoFree
           :virDomainGetFSInfo
           :virDomainGetTime
           :virDomainSetTime))

(in-package :lispvirt-domain)

;; Definitions of strucutres for Domain.
(defcstruct virDomain)

(defcstruct virDomainInfo)

(defcstruct virDomainControlInfo)

(defcstruct virDomainBlockStatsStruct)

(defcstruct virDomainInterfaceStatsStruct)

(defcstruct virDomainMemoryStatStruct)

(defcstruct virDomainBlockInfo)

(defcstruct virVcpuInfo)

(defcstruct virDomainStatsRecord)

(defcstruct virDomainBlockJobInfo)

(defcstruct virDomainDiskError)

(defcstruct virDomainJobInfo)

;;(defcstruct virDomainEventGraphicsAddress)

(defcstruct virDomainFSInfo)

(defcenum virDomainState
	(:VIR_DOMAIN_NOSTATE 0)		;; no state.
	(:VIR_DOMAIN_RUNNING 1)		;; the domain is running.
	(:VIR_DOMAIN_BLOCKED 2)		;; the domain is blocked on resource.
	(:VIR_DOMAIN_PAUSED 3)		;; the domain is paused by user.
	(:VIR_DOMAIN_SHUTDOWN 4)	;; the domain is being shut down.
	(:VIR_DOMAIN_SHUTOFF 5)		;; the domain is shut off.
	(:VIR_DOMAIN_CRASHED 6)		;; the domain is crashed.
	(:VIR_DOMAIN_PMSUSPENDED 7)	;; the domain is suspended by guest.
	(:VIR_DOMAIN_LAST 8))

(defcenum virDomainNostateReason
	(:VIR_DOMAIN_NOSTATE_UNKNOWN 0)
	(:VIR_DOMAIN_NOSTATE_LAST 1))

(defcenum virDomainRunningReason
	(:VIR_DOMAIN_RUNNING_UNKNOWN 0)
	(:VIR_DOMAIN_RUNNING_BOOTED 1)			;; normal startup from boot.
	(:VIR_DOMAIN_RUNNING_MIGRATED 2)		;; migrated from another host.
	(:VIR_DOMAIN_RUNNING_RESTORED 3)		;; restored from a state file.
	(:VIR_DOMAIN_RUNNING_FROM_SNAPSHOT 4)		;; restored from snapshot.
	(:VIR_DOMAIN_RUNNING_UNPAUSED 5)		;; returned from paused state.
	(:VIR_DOMAIN_RUNNING_MIGRATION_CANCELED 6)	;; returned from migration.
	(:VIR_DOMAIN_RUNNING_SAVE_CANCELED 7)		;; returned from failed save process.
	(:VIR_DOMAIN_RUNNING_WAKEUP 8)			;; returned from pmsuspended due to wakeup event.
	(:VIR_DOMAIN_RUNNING_CRASHED 9)			;; resumed from crashed.
	(:VIR_DOMAIN_RUNNING_LAST 10))

(defcenum virDomainBlockedReason
	(:VIR_DOMAIN_BLOCKED_UNKNOWN 0)		;; the reason is unknown */
	(:VIR_DOMAIN_BLOCKED_LAST))

(defcenum virDomainPausedReason
	(:VIR_DOMAIN_PAUSED_UNKNOWN 0)		;; the reason is unknown.
	(:VIR_DOMAIN_PAUSED_USER 1)		;; paused on user request.
	(:VIR_DOMAIN_PAUSED_MIGRATION 2)	;; paused for offline migration.
	(:VIR_DOMAIN_PAUSED_SAVE 3)		;; paused for save.
	(:VIR_DOMAIN_PAUSED_DUMP 4)		;; paused for offline core dump.
	(:VIR_DOMAIN_PAUSED_IOERROR 5)		;; paused due to a disk I/O error.
	(:VIR_DOMAIN_PAUSED_WATCHDOG 6)		;; paused due to a watchdog event.
	(:VIR_DOMAIN_PAUSED_FROM_SNAPSHOT 7)	;; paused after restoring from snapshot.
	(:VIR_DOMAIN_PAUSED_SHUTTING_DOWN 8)	;; paused during shutdown process.
	(:VIR_DOMAIN_PAUSED_SNAPSHOT 9)		;; paused while creating a snapshot.
	(:VIR_DOMAIN_PAUSED_CRASHED 10)		;; paused due to a guest crash.
	(:VIR_DOMAIN_PAUSED_LAST 11))

(defcenum virDomainShutdownReason
	(:VIR_DOMAIN_SHUTDOWN_UNKNOWN 0)	;; the reason is unknown.
	(:VIR_DOMAIN_SHUTDOWN_USER 1)		;; shutting down on user request.
	(:VIR_DOMAIN_SHUTDOWN_LAST 2))


(defcenum virDomainShutoffReason
	(:VIR_DOMAIN_SHUTOFF_UNKNOWN 0)		;; the reason is unknown.
	(:VIR_DOMAIN_SHUTOFF_SHUTDOWN 1)	;; normal shutdown.
	(:VIR_DOMAIN_SHUTOFF_DESTROYED 2)	;; forced poweroff.
	(:VIR_DOMAIN_SHUTOFF_CRASHED 3)		;; domain crashed.
	(:VIR_DOMAIN_SHUTOFF_MIGRATED 4)	;; migrated to another host.
	(:VIR_DOMAIN_SHUTOFF_SAVED 5)		;; saved to a file.
	(:VIR_DOMAIN_SHUTOFF_FAILED 6)		;; domain failed to start.
	(:VIR_DOMAIN_SHUTOFF_FROM_SNAPSHOT 7)	;; restored from a snapshot which was taken while domain was shutoff.
	(:VIR_DOMAIN_SHUTOFF_LAST 8))

(defcenum virDomainCrashedReason
	(:VIR_DOMAIN_CRASHED_UNKNOWN 0)		;; crashed for unknown reason.
	(:VIR_DOMAIN_CRASHED_PANICKED 1)	;; domain panicked.
	(:VIR_DOMAIN_CRASHED_LAST 2))


(defcenum virDomainPMSuspendedReason
	(:VIR_DOMAIN_PMSUSPENDED_UNKNOWN 0)
	(:VIR_DOMAIN_PMSUSPENDED_LAST 1))

(defcenum virDomainPMSuspendedDiskReason
	(:VIR_DOMAIN_PMSUSPENDED_DISK_UNKNOWN 0)
	(:VIR_DOMAIN_PMSUSPENDED_DISK_LAST 1))

(defcenum virDomainXMLFlags
	(:VIR_DOMAIN_XML_SECURE 1)	;; dump security sensitive information too.
	(:VIR_DOMAIN_XML_INACTIVE 2)	;; dump inactive domain information.
	(:VIR_DOMAIN_XML_UPDATE_CPU 4)	;; update guest CPU requirements according to host CPU.
	(:VIR_DOMAIN_XML_MIGRATABLE 8))	;; dump XML suitable for migration.

(defcenum virDomainCreateFlags
	(:VIR_DOMAIN_NONE 0)			;; Default behavior.
	(:VIR_DOMAIN_START_PAUSED 1)		;; Launch guest in paused state.
	(:VIR_DOMAIN_START_AUTODESTROY 2)	;; Automatically kill guest when virConnectPtr is closed.
	(:VIR_DOMAIN_START_BYPASS_CACHE 4)	;; Avoid file system cache pollution.
	(:VIR_DOMAIN_START_FORCE_BOOT 8)	;; Boot, discarding any managed save.
	(:VIR_DOMAIN_START_VALIDATE 16))	;; Validate the XML document against schema.

(defcenum virDomainShutdownFlagValues
	(:VIR_DOMAIN_SHUTDOWN_DEFAULT 1)        ;; hypervisor choice.
	(:VIR_DOMAIN_SHUTDOWN_ACPI_POWER_BTN 2)	;; Send ACPI event.
	(:VIR_DOMAIN_SHUTDOWN_GUEST_AGENT 4)	;; Use guest agent.
	(:VIR_DOMAIN_SHUTDOWN_INITCTL 8)	;; Use initctl.
	(:VIR_DOMAIN_SHUTDOWN_SIGNAL 16)	;; Send a signal.
	(:VIR_DOMAIN_SHUTDOWN_PARAVIRT 32))	;; Use paravirt guest control.

(defcenum virDomainRebootFlagValues
	(:VIR_DOMAIN_REBOOT_DEFAULT 0)		;; hypervisor choice.
	(:VIR_DOMAIN_REBOOT_ACPI_POWER_BTN 1)	;; Send ACPI event.
	(:VIR_DOMAIN_REBOOT_GUEST_AGENT 2)	;; Use guest agent.
	(:VIR_DOMAIN_REBOOT_INITCTL 4)		;; Use initctl.
	(:VIR_DOMAIN_REBOOT_SIGNAL 8)		;; Send a signal.
	(:VIR_DOMAIN_REBOOT_PARAVIRT 16))	;; Use paravirt guest control.


;; Pointers mapping to structures.
(defctype virDomainPtr (:pointer virDomain))

(defctype virDomainInfoPtr (:pointer virDomainInfo))

(defctype virDomainControlInfoPtr (:pointer virDomainControlInfo))

(defctype virDomainBlockStatsPtr (:pointer virDomainBlockStatsStruct))

(defctype virDomainInterfaceStatsPtr (:pointer virDomainInterfaceStatsStruct))

(defctype virDomainMemoryStatPtr (:pointer virDomainMemoryStatStruct))

(defctype virDomainBlockInfoPtr (:pointer virDomainBlockInfo))

(defctype virVcpuInfoPtr (:pointer virVcpuInfo))

(defctype virDomainStatsRecordPtr (:pointer virDomainStatsRecord))

(defctype virDomainBlockJobInfoPtr (:pointer virDomainBlockJobInfo))

(defctype virDomainDiskErrorPtr (:pointer virDomainDiskError))

(defctype virDomainJobInfoPtr (:pointer virDomainJobInfo))

;;(defctype virDomainEventGraphicsAddressPtr (:poitner virDomainEventGraphicsAddress))

(defctype virDomainFSInfoPtr (:pointer virDomainFSInfo))


;; Methods.
;; Dinamic control of domains
(defcfun "virDomainGetName" :string
	(domain virDomainPtr))

(defcfun "virDomainGetID" :int
	(domain virDomainPtr))

(defcfun "virDomainGetUUID" :int
	(domain virDomainPtr))

(defcfun "virDomainGetUUIDString" :int
	(domain virDomainPtr)
	(buf :string))

(defcfun "virDomainGetOSType" :string
	(domain virDomainPtr))

(defcfun "virDomainGetMaxMemory" :ulong
	(domain virDomainPtr))

(defcfun "virDomainSetMaxMemory" :int
	(domain virDomainPtr)
	(memory :ulong))

(defcfun "virDomainSetMemory" :int
	(domain virDomainPtr)
	(memory :ulong))

(defcfun "virDomainSetMemoryFlags" :int
	(domain virDomainPtr)
        (memory :ulong)
	(flags :uint))

(defcfun "virDomainSetMemoryStatsPeriod" :int
	(domain virDomainPtr)
	(period :int)
        (flags :uint))

(defcfun "virDomainGetMaxVcpus" :int
	(domain virDomainPtr))

(defcfun "virDomainGetSecurityLabel" :int
	(domain virDomainPtr)
	(seclabel virSecurityLabelPtr))

(defcfun "virDomainGetHostname" :string
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainGetSecurityLabelList" :int
	(domain virDomainPtr)
	(seclabels (:pointer virSecurityLabelPtr)))

(defcfun "virDomainSetMetadata" :int
	(domain virDomainPtr)
	(type :int)
        (metadata :string)
        (key :string)
        (uri :string)
        (flags :string))

(defcfun "virDomainGetMetadata" :string
	(domain virDomainPtr)
        (type :int)
        (uri :string)
        (flags :uint))

(defcfun "virDomainGetXMLDesc" :string
	(domain virDomainPtr)
	(flags :uint))


(defcfun "virConnectDomainXMLFromNative" :string
	(conn virConnectPtr)
	(nativeFormat :string)
	(nativeConfig :string)
	(flags :uint))

(defcfun "virConnectDomainXMLToNative" :string
	(conn virConnectPtr)
	(nativeFormat :string)
	(domainXml :string)
	(flags :uint))

(defcfun "virDomainBlockStats" :int
	(domain virDomainPtr)
	(disk :string)
	(stats virDomainBlockStatsPtr)
	(size size_t))

(defcfun ("virDomainBlockStatsFlags" %virDomainBlockStatsFlags) :int
	(domain virDomainPtr)
	(disk :string)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainBlockStatsFlags (domain disk flags)
        (with-foreign-objects ((params virTypedParameterPtr)
			       (nparams :int))
                (%virDomainBlockStatsFlags domain disk params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
			(mem-ref nparams :int))))

(defcfun "virDomainInterfaceStats" :int
	(domain virDomainPtr)
	(path :string)
	(stats virDomainInterfaceStatsPtr stats)
	(size size_t))

(defcfun "virDomainSetInterfaceParameters" :int
	(domain virDomainPtr)
	(device :string)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))

(defcfun ("virDomainGetInterfaceParameters" %virDomainGetInterfaceParameters) :int
	(dom virDomainPtr)
	(device :string)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainGetInterfaceParameters (dom device flags)
	(with-foreign-objects ((params virTypedParameterPtr)
                               (nparams :int))
                (%virDomainGetInterfaceParameters dom device params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
                        (mem-ref nparams :int))))

(defcfun "virDomainBlockPeek" :int
	(domain virDomainPtr)
	(disk :string)
	(offset :ullong)
	(size size_t)
	(buffer (:pointer :void))
	(flags :uint))

(defcfun "virDomainBlockResize" :int
	(domain virDomainPtr)
	(disk :string)
	(size :ullong)
	(flags :uint))

(defcfun "virDomainGetBlockInfo" :int
	(domain virDomainPtr)
	(disk :string)
	(info virDomainBlockInfoPtr)
	(flags :uint))


(defcfun ("virDomainGetSchedulerParameters" %virDomainGetSchedulerParameters) :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams (:pointer :int)))

(defun virDomainGetSchedulerParameters (domain)
	(with-foreign-objects ((params virTypedParameterPtr)
                               (nparams :int))
                (%virDomainGetSchedulerParameters domain params nparams)
                (values (mem-ref params virTypedParameterPtr)
                        (mem-ref nparams :int))))

(defcfun ("virDomainGetSchedulerParametersFlags" %virDomainGetSchedulerParametersFlags) :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainGetSchedulerParametersFlags (domain flags)
	(with-foreign-objects ((params virTypedParameterPtr)
                               (nparams :int))
                (%virDomainGetSchedulerParametersFlags domain params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
                        (mem-ref nparams :int))))

(defcfun "virDomainSetSchedulerParameters" :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams :int))

(defcfun "virDomainSetSchedulerParametersFlags" :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))


;; Domain Migration
(defcfun "virDomainMigrate" virDomainPtr
	(domain virDomainPtr)
	(dconn virConnectPtr)
	(flags :ulong)
	(dname :string)
	(uri :string)
	(bandwidth :ulong))

(defcfun "virDomainMigrate2" virDomainPtr
	(domain virDomainPtr)
	(dconn virConnectPtr)
	(dxml :string)
	(flags :ulong)
	(dname :string)
	(uri :string)
	(bandwidth :ulong))

(defcfun "virDomainMigrate3" virDomainPtr
	(domain virDomainPtr)
	(dconn virConnectPtr)
	(params virTypedParameterPtr)
	(nparams :uint)
	(flags :uint))

(defcfun "virDomainMigrateToURI" :int
	(domain virDomainPtr)
	(duri :string)
	(flags :ulong)
	(dname :string)
	(bandwidth :ulong))

(defcfun "virDomainMigrateToURI2" :int
	(domain virDomainPtr)
	(dconnuri :string)
	(miguri :string)
	(dxml :string)
	(flags :ulong)
	(dname :string)
	(bandwidth :ulong))

(defcfun "virDomainMigrateToURI3" :int
	(domain virDomainPtr)
	(dconnuri :string)
	(params virTypedParameterPtr)
	(nparams :uint)
	(flags :uint))

(defcfun "virDomainMigrateSetMaxDowntime" :int
	(domain virDomainPtr)
	(downtime :ullong)
	(flags :uint))

(defcfun ("virDomainMigrateGetCompressionCache" %virDomainMigrateGetCompressionCache) :int
	(domain virDomainPtr)
        (cacheSize (:pointer :ulong))
        (flags :uint))

(defun virDomainMigrateGetCompressionCache (domain flags)
        (with-foreign-objects ((cacheSize :ullong))
                (%virDomainMigrateGetCompressionCache domain cacheSize flags)
                (values (mem-ref cacheSize :ullong))))

(defcfun "virDomainMigrateSetCompressionCache" :int
	(domain virDomainPtr)
	(cachesize :ullong)
        (flags :uint))

(defcfun "virDomainMigrateSetMaxSpeed" :int
	(domain virDomainPtr)
	(bandwidth :ulong)
	(flags :uint))

(defcfun ("virDomainMigrateGetMaxSpeed" %virDomainMigrateGetMaxSpeed) :int
	(domain virDomainPtr)
	(bandwidth (:pointer :ulong))
	(flags :uint))

(defcfun ("virConnectGetDomainCapabilities" %virConnectGetDomainCapabilities) :string
	(conn virConnectPtr)
	(emulatorbin :string)
	(arch :string)
	(machine :string)
	(virttype :string)
	(flags :uint))

;; test function
(defun listalldomains (string)
	(let ((conn (virconnectopen string)))
		(virconnectlistdomains conn (virconnectnumofdomains conn))))

(defcfun ("virConnectListDomains" %virConnectListDomains) :int
        (conn virConnectPtr)
        (ids (:pointer :int))
        (maxids :int))

(defun virConnectListDomains (conn maxids)
        (with-foreign-objects ((ids :int))
                (%virConnectListDomains conn ids maxids)
                (values
                        (loop for i from 0 to (- maxids 1) collect (mem-aref ids :int i)))))

(defcfun ("virConnectListAllDomains" %virConnectListAllDomains) :int
	(conn virConnectPtr)
	(domains :pointer :pointer)
	(flags :uint))

(defun virConnectListAllDomains (conn flags)
	(with-foreign-objects ((domains :pointer))
		(%virConnectListAllDomains conn domains flags)
		(values
                        (loop for i from 0 to (- (virConnectNumOfDefinedDomains conn) 1)
				collect (mem-aref (mem-aref domains :pointer 0) :pointer i)))))

(defcfun "virConnectNumOfDomains" :int
	(conn virConnectPtr))

(defcfun "virDomainGetConnect" virConnectPtr
	(domain virDomainPtr))


;; Domain creation and destruction

(defcfun "virDomainCreateXML" virDomainPtr
	(conn virConnectPtr)
	(xmlDesc :string)
	(flags :uint))

(defcfun "virDomainCreateXMLWithFiles" virDomainPtr
	(conn virConnectPtr)
	(xmlDesc :string)
	(nfiles :uint)
	(files (:pointer :int))
	(flags :uint))

(defcfun "virDomainLookupByName" virDomainPtr
	(conn virConnectPtr)
	(name :string))

(defcfun "virDomainLookupByID" virDomainPtr
	(conn virConnectPtr)
	(id :int))

(defcfun "virDomainLookupByUUID" virDomainPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virDomainLookupByUUIDString" virDomainPtr
	(conn virConnectPtr)
	(uuid :string))

(defcfun "virDomainShutdown" :int
	(domain virDomainPtr))

(defcfun "virDomainShutdownFlags" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainReboot" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainReset" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainDestroy" :int
	(domain virDomainPtr))

(defcfun "virDomainDestroyFlags" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainRef" :int
	(domain virDomainPtr))

(defcfun "virDomainFree" :int
	(domain virDomainPtr))


;; Domain suspend/resume

(defcfun "virDomainSuspend" :int
	(domain virDomainPtr))

(defcfun "virDomainResume" :int
	(domain virDomainPtr))

(defcfun "virDomainPMSuspendForDuration" :int
	(domain virDomainPtr)
	(target :uint)
	(duration :ullong)
	(flags :uint))

(defcfun "virDomainPMWakeup" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainSave" :int
	(domain virDomainPtr)
	(to :string))

(defcfun "virDomainSaveFlags" :int
	(domain virDomainPtr)
	(to :string)
	(dxml :string)
	(flags :uint))

(defcfun "virDomainRestore" :int
	(conn virConnectPtr)
	(from :string))

(defcfun "virDomainRestoreFlags" :int
	(conn virConnectPtr)
	(from :string)
	(dxml :string)
	(flags :uint))

(defcfun "virDomainSaveImageGetXMLDesc" :string
	(conn virConnectPtr)
	(file :string)
	(flags :uint))

(defcfun "virDomainSaveImageDefineXML" :int
	(conn virConnectPtr)
	(file :string)
	(dxml :string)
	(flags :uint))


;; Managed domain save

(defcfun "virDomainManagedSave" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainHasManagedSaveImage" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainManagedSaveRemove" :int
	(domain virDomainPtr)
	(flags :uint))


;; Domain core dump

(defcfun "virDomainCoreDump" :int
	(domain virDomainPtr)
	(to :string)
	(flags :uint))


;; Domain core dump with format specified
(defcfun "virDomainCoreDumpWithFormat" :int
	(domain virDomainPtr)
	(to :string)
	(dumpformat :uint)
	(flags :uint))


;; Screenshot of current domain console
(defcfun "virDomainScreenshot" :string
	(domain virDomainPtr)
	(strem virStreamPtr)
	(screen :uint)
	(flags :uint))


;; Domain runtime information, and collecting CPU statistics
(defcfun "virDomainGetInfo" :int
	(domain virDomainPtr)
	(info virDomainInfoPtr))

(defcfun ("virDomainGetState" %virDomainGetState) :int
	(domain virDomainPtr)
	(state (:pointer :int))
	(reason (:pointer :int))
	(flags :uint))

(defun virDomainGetState (domain flags)
        (with-foreign-objects ((state :int) (reason :int))
                (%virDomainGetState domain state reason flags)
                (values (mem-ref state :int)
			(mem-ref reason :int))))

(defcfun "virDomainGetCPUStats" :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams :uint)
	(start_cpu :int)
	(ncpus :uint)
	(flags :uint))

(defcfun "virDomainGetControlInfo" :int
	(domain virDomainPtr)
	(info virDomainControlInfoPtr)
	(flags :uint))


;; Return scheduler type in effect 'sedf', 'credit', 'linux'

(defcfun ("virDomainGetSchedulerType" %virDomainGetSchedulerType) :string
	(domain virDomainPtr)
	(nparams (:pointer :int)))

(defun virDomainGetSchedulerType (domain)
        (with-foreign-objects ((nparams :int))
                (%virDomainGetSchedulerType domain nparams)
                (values (mem-ref nparams :int))))


;; Set Blkio tunables for the domain

(defcfun "virDomainSetBlkioParameters" :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))

(defcfun ("virDomainGetBlkioParameters" %virDomainGetBlkioParameters) :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainGetBlkioParameters (domain flags)
        (with-foreign-objects ((params virTypedParameterPtr)
			       (nparams :int))
                (%virDomainGetBlkioParameters domain params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
			(mem-ref nparams :int))))


;; Set memory tunables for the domain
(defcfun "virDomainSetMemoryParameters" :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))

(defcfun ("virDomainGetMemoryParameters" %virDomainGetMemoryParameters) :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainGetMemoryParameters (domain flags)
        (with-foreign-objects ((params virTypedParameterPtr)
			       (nparams :int))
                (%virDomainGetMemoryParameters domain params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
			(mem-ref nparams :int))))

(defcfun "virDomainSetNumaParameters" :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))

(defcfun ("virDomainGetNumaParameters" %virDomainGetNumaParameters) :int
	(domain virDomainPtr)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainGetNumaParameters (domain flags)
        (with-foreign-objects ((params virTypedParameterPtr)
			       (nparams :int))
                (%virDomainGetNumaParameters domain params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
			(mem-ref nparams :int))))


;; Management of domain memory */
(defcfun "virDomainMemoryStats" :int
	(domain virDomainPtr)
	(stats virDomainMemoryStatPtr)
	(nr_stats :uint)
	(flags :uint))


;; Memory peeking flags.
(defcfun "virDomainMemoryPeek" :int
	(domain virDomainPtr)
	(start :ullong)
	(size size_t)
	(buffer (:pointer :void))
	(flags :uint))


;; defined but not running domains
(defcfun "virDomainDefineXML" virDomainPtr
	(conn virConnectPtr)
	(xml :string))

(defcfun "virDomainDefineXMLFlags" virDomainPtr
	(conn virConnectPtr)
	(xml :string)
	(flags :uint))

(defcfun "virDomainUndefine" :int
	(domain virDomainPtr))


(defcfun "virDomainUndefineFlags" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virConnectNumOfDefinedDomains" :int
	(conn virConnectPtr))

;; TODO: Need to be reimplemented.
;;(defcfun "virConnectListDefinedDomains" :int
;;	(conn virConnectPtr)
;;	(char **const names)
;;	(maxnames :int))

(defcfun "virDomainCreate" :int
	(domain virDomainPtr))

(defcfun "virDomainCreateWithFlags" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainCreateWithFiles" :int
	(domain virDomainPtr)
	(nfiles :uint)
	(files (:pointer :int))
	(flags :uint))

(defcfun ("virDomainGetAutostart" %virDomainGetAutostart) :int
	(domain virDomainPtr)
	(autostart (:pointer :int)))

(defun virDomainGetAutostart (domain)
	(with-foreign-objects ((autostart :int))
                (%virDomainGetAutostart domain autostart)
                (values (mem-ref autostart :int))))

(defcfun "virDomainSetAutostart" :int
	(domain virDomainPtr)
	(autostart :int))

;; virVcpuInfo: structure for information about a virtual CPU in a domain.

(defcfun "virDomainSetVcpus" :int
	(domain virDomainPtr)
	(nvcpus :uint))

(defcfun "virDomainSetVcpusFlags" :int
	(domain virDomainPtr)
	(nvcpus :uint)
	(flags :uint))

(defcfun "virDomainGetVcpusFlags" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainPinVcpu" :int
	(domain virDomainPtr)
	(vcpu :uint)
	(cpumap :string)
	(maplen :int))

(defcfun "virDomainPinVcpuFlags" :int
	(domain virDomainPtr)
	(vcpu :uint)
	(cpumap :string)
	(maplen :int)
	(flags :uint))

(defcfun "virDomainGetVcpuPinInfo" :int
	(domain virDomainPtr)
	(ncpumaps :int)
	(cpumaps :string)
	(maplen :int)
	(flags :uint))

(defcfun "virDomainPinEmulator" :int
	(domain virDomainPtr)
	(cpumap :string)
	(maplen :int)
	(flags :uint))

(defcfun "virDomainGetEmulatorPinInfo" :int
	(domain virDomainPtr)
	(cpumaps :string)
	(maplen :int)
	(flags :uint))

(defcfun "virDomainGetVcpus" :int
	(domain virDomainPtr)
	(info virVcpuInfoPtr)
	(maxinfo :int)
	(cpumaps :string)
	(maplen :int))

(defcfun "virDomainAttachDevice" :int
	(domain virDomainPtr)
	(xml :string))

(defcfun "virDomainDetachDevice" :int
	(domain virDomainPtr)
	(xml :string))

(defcfun "virDomainAttachDeviceFlags" :int
	(domain virDomainPtr)
	(xml :string)
	(flags :uint))

(defcfun "virDomainDetachDeviceFlags" :int
	(domain virDomainPtr)
	(xml :string)
	(flags :uint))

(defcfun "virDomainUpdateDeviceFlags" :int
	(domain virDomainPtr)
	(xml :string)
	(flags :uint))

(defcfun "virConnectGetAllDomainStats" :int 
	(conn virConnectPtr)
	(stats :uint)
	(refStats (:pointer (:pointer virDomainStatsRecordPtr)))
	(flags :uint))

(defcfun "virDomainListGetStats" :int
	(domains (:pointer virDomainPtr))
	(stats :uint)
	(refStats (:pointer (:pointer virDomainStatsRecordPtr)))
	(flags :uint))

(defcfun "virDomainStatsRecordListFree" :void
	(stats (:pointer virDomainStatsRecordPtr)))

(defcfun "virDomainBlockJobAbort" :int
	(domain virDomainPtr)
	(disk :string)
	(flags :uint))

(defcfun "virDomainGetBlockJobInfo" :int
	(domain virDomainPtr)
	(disk :string)
	(info virDomainBlockJobInfoPtr)
	(flags :uint))

(defcfun "virDomainBlockJobSetSpeed" :int
	(domain virDomainPtr)
	(disk :string)
	(bandwidth :ulong)
	(flags :uint))

(defcfun "virDomainBlockPull" :int
	(domain virDomainPtr)
	(disk :string)
	(bandwidth :ulong)
	(flags :uint))

(defcfun "virDomainBlockRebase" :int
	(domain virDomainPtr)
	(disk :string)
	(base :string)
	(bandwidth :ulong)
	(flags :uint))

(defcfun "virDomainBlockCopy" :int
	(domain virDomainPtr)
	(disk :string)
	(destxml :string)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))

(defcfun "virDomainBlockCommit" :int
	(domain virDomainPtr)
	(disk :string)
	(base :string)
	(top :string)
	(bandwidth :ulong)
	(flags :uint))

(defcfun "virDomainSetBlockIoTune" :int
	(domain virDomainPtr)
	(disk :string)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))

(defcfun ("virDomainGetBlockIoTune" %virDomainGetBlockIoTune) :int
	(domain virDomainPtr)
	(disk :string)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virDomainGetBlockIoTune (domain disk flags)
        (with-foreign-objects ((params virTypedParameterPtr)
			       (nparams :int))
                (%virDomainGetBlockIoTune domain disk params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
			(mem-ref nparams :int))))

(defcfun "virDomainGetDiskErrors" :int
	(domain virDomainPtr)
	(errors virDomainDiskErrorPtr)
	(maxerrors :uint)
	(flags :uint))

(defcfun "virDomainSendKey" :int
	(domain virDomainPtr)
	(codeset :uint)
	(holdtime :uint)
	(keycodes (:pointer :uint))
	(nkeycodes :int)
	(flags :uint))

(defcfun "virDomainSendProcessSignal" :int
	(domain virDomainPtr)
	(pid_value :llong)
	(signum :uint)
	(flags :uint))

;;(defcfun "virConnectDomainEventRegister" :int
;;	(conn virConnectPtr)
;;	(cb virConnectDomainEventCallback)
;;	(opaque (:pointer :void))
;;	(freecb virFreeCallback))

;;(defcfun "virConnectDomainEventDeregister" :int
;;	(conn virConnectPtr)
;;	(cb virConnectDomainEventCallback))

(defcfun "virDomainGetJobInfo" :int
	(domain virDomainPtr)
	(info virDomainJobInfoPtr))

(defcfun ("virDomainGetJobStats" %virDomainGetJobStats) :int
	(domain virDomainPtr)
	(job_type (:pointer :int))
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(flags :uint))

(defcfun "virDomainAbortJob" :int
	(domain virDomainPtr))

;;(defcfun "virConnectDomainEventRegisterAny" :int
;;	(conn virConnectPtr)
;;	(domain virDomainPtr)
;;	(eventID :int)
;;	(cb virConnectDomainEventGenericCallback)
;;	(opaque (:pointer :void)
;;	(freecb virFreeCallback))

(defcfun "virConnectDomainEventDeregisterAny" :int
	(conn virConnectPtr)
	(callbackID :int))

(defcfun "virDomainOpenConsole" :int
	(domain virDomainPtr)
	(dev_name :string)
	(stream virStreamPtr)
	(flags :uint))


(defcfun "virDomainOpenChannel" :int
	(domain virDomainPtr)
	(name :string)
	(stream virStreamPtr)
	(flags :uint))


(defcfun "virDomainOpenGraphics" :int
	(domain virDomainPtr)
	(idx :uint)
	(fd :int)
	(flags :uint))

(defcfun "virDomainOpenGraphicsFD" :int
	(domain virDomainPtr)
	(idx :uint)
	(flags :uint))

(defcfun "virDomainInjectNMI" :int
	(domain virDomainPtr)
	(flags :uint))

(defcfun "virDomainFSTrim" :int
	(domain virDomainPtr)
	(mountPoint :string)
	(minimum :ullong)
	(flags :uint))

(defcfun "virDomainFSFreeze" :int
	(domain virDomainPtr)
	(mountpoints (:pointer :string))
	(nmountpoints :uint)
	(flags :uint))

(defcfun "virDomainFSThaw" :int
	(domain virDomainPtr)
	(mountpoints (:pointer :string))
	(nmountpoints :uint)
	(flags :uint))

(defcfun "virDomainFSInfoFree" :void
	(info virDomainFSInfoPtr))

(defcfun "virDomainGetFSInfo" :int
	(domain virDomainPtr)
	(info (:pointer (:pointer virDomainFSInfoPtr)))
	(flags :uint))

(defcfun ("virDomainGetTime" %virDomainGetTime) :int
	(domain virDomainPtr)
	(seconds (:pointer :llong))
	(nseconds (:pointer :uint))
	(flags :uint))

(defun virDomainGetTime (domain flags)
        (with-foreign-objects ((seconds :llong)
			       (nseconds :uint))
                (%virDomainGetTime domain seconds nseconds flags)
                (values (mem-ref seconds :llong)
			(mem-ref nparams :uint))))

(defcfun "virDomainSetTime" :int
	(domain virDomainPtr)
	(seconds :llong)
	(nseconds :uint)
	(flags :uint))


