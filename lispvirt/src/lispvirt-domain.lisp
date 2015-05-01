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
	   :virDomainControlState
	   :virDomainControlErrorReason
	   :virDomainModificationImpact
	   :virDomainMemoryStatTags
	   :virDomainCoreDumpFlags
	   :virDomainCoreDumpFormat
	   :virDomainMigrateFlags
	   :virDomainCreateFlags
	   :virDomainShutdownFlagValues
	   :virDomainRebootFlagValues
	   :virDomainDestroyFlagsValues
	   :virDomainSaveRestoreFlags
	   :virDomainMemoryModFlags
	   :virDomainNumatuneMemMode
	   :virDomainMetadataType
	   :virDomainXMLFlags
	   :virDomainBlockResizeFlags
	   :virDomainMemoryFlags
	   :virDomainDefineFlags
	   :virDomainUndefineFlagsValues
	   :virConnectListAllDomainsFlags
	   :virVcpuState
	   :virDomainVcpuFlags
	   :virDomainDeviceModifyFlags
	   :virDomainStatsTypes
	   :virConnectGetAllDomainStatsFlags
	   :virDomainBlockJobType
	   :virDomainBlockJobAbortFlags
	   :virDomainBlockJobInfoFlags
	   :virDomainBlockJobSetSpeedFlags
	   :virDomainBlockPullFlags
	   :virDomainBlockRebaseFlags
	   :virDomainBlockCopyFlags
	   :virDomainBlockCommitFlags
	   :virDomainDiskErrorCode
	   :virKeycodeSet
	   :virDomainProcessSignal
	   :virDomainEventType
	   :virDomainEventDefinedDetailType
	   :virDomainEventUndefinedDetailType
	   :virDomainEventStartedDetailType
	   :virDomainEventSuspendedDetailType
	   :virDomainEventResumedDetailType
	   :virDomainEventStoppedDetailType
	   :virDomainEventShutdownDetailType
	   :virDomainEventPMSuspendedDetailType
	   :virDomainEventCrashedDetailType
	   :virDomainJobType
	   :virDomainGetJobStatsFlags
	   :virDomainEventWatchdogAction
	   :virDomainEventIOErrorAction
	   :virDomainEventGraphicsPhase
	   :virDomainEventGraphicsAddressType
	   :virDomainEventTrayChangeReason
	   :virConnectDomainEventAgentLifecycleState
	   :virConnectDomainEventAgentLifecycleReason
	   :virDomainEventID
	   :virDomainConsoleFlags
	   :virDomainChannelFlags
	   :virDomainOpenGraphicsFlags
	   :virDomainSetTimeFlags
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
	(:VIR_DOMAIN_BLOCKED_UNKNOWN 0)		;; the reason is unknown.
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

(defcenum virDomainControlState
	(:VIR_DOMAIN_CONTROL_OK 0)		;; operational, ready to accept commands.
	(:VIR_DOMAIN_CONTROL_JOB 1)		;; background job is running (can be monitored by virDomainGetJobInfo); only limited set of commands may be allowed.
	(:VIR_DOMAIN_CONTROL_OCCUPIED 2)	;; occupied by a running command.
	(:VIR_DOMAIN_CONTROL_ERROR 3)		;; unusable, domain cannot be fully operated, possible reason is provided in the details field.
	(:VIR_DOMAIN_CONTROL_LAST 4))

(defcenum virDomainControlErrorReason
	(:VIR_DOMAIN_CONTROL_ERROR_REASON_NONE 0)	;; server didn't provide a reason.
	(:VIR_DOMAIN_CONTROL_ERROR_REASON_UNKNOWN 1)	;; unknown reason for the error.
	(:VIR_DOMAIN_CONTROL_ERROR_REASON_MONITOR 2)	;; monitor connection is broken.
	(:VIR_DOMAIN_CONTROL_ERROR_REASON_INTERNAL 3)	;; error caused due to internal failure in libvirt.
	(:VIR_DOMAIN_CONTROL_ERROR_REASON_LAST 4))

(defcenum virDomainModificationImpact
	(:VIR_DOMAIN_AFFECT_CURRENT 0)	;; Affect current domain state.
	(:VIR_DOMAIN_AFFECT_LIVE 1)	;; Affect running domain state.
	(:VIR_DOMAIN_AFFECT_CONFIG 2))	;; Affect persistent domain state.
	;; 1 << 2 is reserved for virTypedParameterFlags.

(defcenum virDomainMemoryStatTags
	(:VIR_DOMAIN_MEMORY_STAT_SWAP_IN 0)
	(:VIR_DOMAIN_MEMORY_STAT_SWAP_OUT 1) 		;; The total amount of memory written out to swap space (in kB).
	(:VIR_DOMAIN_MEMORY_STAT_MAJOR_FAULT 2)
	(:VIR_DOMAIN_MEMORY_STAT_MINOR_FAULT 3)
	(:VIR_DOMAIN_MEMORY_STAT_UNUSED 4)
	(:VIR_DOMAIN_MEMORY_STAT_AVAILABLE 5)
	(:VIR_DOMAIN_MEMORY_STAT_ACTUAL_BALLOON 6)	;; Current balloon value (in KB).
	(:VIR_DOMAIN_MEMORY_STAT_RSS 7)		;; Resident Set Size of the process running the domain. This value is in kB.
	(:VIR_DOMAIN_MEMORY_STAT_NR 8)
	(:VIR_DOMAIN_MEMORY_STAT_LAST 8))

(defcenum virDomainCoreDumpFlags
	(:VIR_DUMP_CRASH 1)		;; crash after dump.
	(:VIR_DUMP_LIVE 2)		;; live dump.
	(:VIR_DUMP_BYPASS_CACHE 4)	;; avoid file system cache pollution.
	(:VIR_DUMP_RESET 8)		;; reset domain after dump finishes.
	(:VIR_DUMP_MEMORY_ONLY 16))	;; use dump-guest-memory.

(defcenum virDomainCoreDumpFormat
	(:VIR_DOMAIN_CORE_DUMP_FORMAT_RAW 1)		;; dump guest memory in raw format.
	(:VIR_DOMAIN_CORE_DUMP_FORMAT_KDUMP_ZLIB 2)	;; kdump-compressed format, with zlib compression.
	(:VIR_DOMAIN_CORE_DUMP_FORMAT_KDUMP_LZO 3)	;; kdump-compressed format, with lzo compression.
	(:VIR_DOMAIN_CORE_DUMP_FORMAT_KDUMP_SNAPPY 4)	;; kdump-compressed format, with snappy compression.
	(:VIR_DOMAIN_CORE_DUMP_FORMAT_LAST 5))

(defcenum virDomainMigrateFlags
	(:VIR_MIGRATE_LIVE 1)			;; live migration.
	(:VIR_MIGRATE_PEER2PEER 2)		;; direct source -> dest host control channel.
	(:VIR_MIGRATE_TUNNELLED 4)		;; tunnel migration data over libvirtd connection.
	(:VIR_MIGRATE_PERSIST_DEST 8)		;; persist the VM on the destination.
	(:VIR_MIGRATE_UNDEFINE_SOURCE 16)	;; undefine the VM on the source.
	(:VIR_MIGRATE_PAUSED 32)		;; pause on remote side.
	(:VIR_MIGRATE_NON_SHARED_DISK 64)	;; migration with non-shared storage with full disk copy.
	(:VIR_MIGRATE_NON_SHARED_INC 128)	;; migration with non-shared storage with incremental copy (same base image shared between source and destination).
	(:VIR_MIGRATE_CHANGE_PROTECTION 256)	;; protect for changing domain configuration through the whole migration process; this will be used automatically when supported.
	(:VIR_MIGRATE_UNSAFE 512)		;; force migration even if it is considered unsafe.
	(:VIR_MIGRATE_OFFLINE 1024)		;; offline migrate.
	(:VIR_MIGRATE_COMPRESSED 2048)		;; compress data during migration.
	(:VIR_MIGRATE_ABORT_ON_ERROR 4096)	;; abort migration on I/O errors happened during migration.
	(:VIR_MIGRATE_AUTO_CONVERGE 8192)	;; force convergence.
	(:VIR_MIGRATE_RDMA_PIN_ALL 16384))	;; RDMA memory pinning.

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

(defcenum virDomainDestroyFlagsValues
	(:VIR_DOMAIN_DESTROY_DEFAULT 0)		;; Default behavior - could lead to data loss!!
	(:VIR_DOMAIN_DESTROY_GRACEFUL 1))	;; only SIGTERM, no SIGKILL.

(defcenum virDomainSaveRestoreFlags
	(:VIR_DOMAIN_SAVE_BYPASS_CACHE 1)	;; Avoid file system cache pollution.
	(:VIR_DOMAIN_SAVE_RUNNING 2)		;; Favor running over paused.
	(:VIR_DOMAIN_SAVE_PAUSED 4))		;; Favor paused over running.

(defcenum virDomainMemoryModFlags
	(:VIR_DOMAIN_MEM_CURRENT 0)
	(:VIR_DOMAIN_MEM_LIVE 1)
	(:VIR_DOMAIN_MEM_CONFIG 2)
	(:VIR_DOMAIN_MEM_MAXIMUM 4))	;; affect Max rather than current.

(defcenum virDomainNumatuneMemMode
	(:VIR_DOMAIN_NUMATUNE_MEM_STRICT 0)
	(:VIR_DOMAIN_NUMATUNE_MEM_PREFERRED 1)
	(:VIR_DOMAIN_NUMATUNE_MEM_INTERLEAVE 2)
	(:VIR_DOMAIN_NUMATUNE_MEM_LAST 3))	;; This constant is subject to change.

(defcenum virDomainMetadataType
	(:VIR_DOMAIN_METADATA_DESCRIPTION 0)	;; Operate on <description>.
	(:VIR_DOMAIN_METADATA_TITLE 1)		;; Operate on <title>.
	(:VIR_DOMAIN_METADATA_ELEMENT 2)	;; Operate on <metadata>.
	(:VIR_DOMAIN_METADATA_LAST 3))

(defcenum virDomainXMLFlags
	(:VIR_DOMAIN_XML_SECURE 1)	;; dump security sensitive information too.
	(:VIR_DOMAIN_XML_INACTIVE 2)	;; dump inactive domain information.
	(:VIR_DOMAIN_XML_UPDATE_CPU 4)	;; update guest CPU requirements according to host CPU.
	(:VIR_DOMAIN_XML_MIGRATABLE 8))	;; dump XML suitable for migration.

(defcenum virDomainBlockResizeFlags
	(:VIR_DOMAIN_BLOCK_RESIZE_BYTES 1))	;; size in bytes instead of KiB.

(defcenum virDomainMemoryFlags
	(:VIR_MEMORY_VIRTUAL 1)		;; addresses are virtual addresses.
	(:VIR_MEMORY_PHYSICAL 2))	;; addresses are physical addresses.

(defcenum virDomainDefineFlags
	(:VIR_DOMAIN_DEFINE_VALIDATE 1))	;; Validate the XML document against schema.

(defcenum virDomainUndefineFlagsValues
	(:VIR_DOMAIN_UNDEFINE_MANAGED_SAVE 1)		;; Also remove any managed save.
	(:VIR_DOMAIN_UNDEFINE_SNAPSHOTS_METADATA 2)	;; If last use of domain, then also remove any snapshot metadata.
	(:VIR_DOMAIN_UNDEFINE_NVRAM 4))			;; Also remove any nvram file.
	;; Future undefine control flags should come here.

(defcenum virConnectListAllDomainsFlags
	(:VIR_CONNECT_LIST_DOMAINS_ACTIVE 1)
	(:VIR_CONNECT_LIST_DOMAINS_INACTIVE 2)
	(:VIR_CONNECT_LIST_DOMAINS_PERSISTENT 4)
	(:VIR_CONNECT_LIST_DOMAINS_TRANSIENT 8)
	(:VIR_CONNECT_LIST_DOMAINS_RUNNING 16)
	(:VIR_CONNECT_LIST_DOMAINS_PAUSED 32)
	(:VIR_CONNECT_LIST_DOMAINS_SHUTOFF 64)
	(:VIR_CONNECT_LIST_DOMAINS_OTHER 128)
	(:VIR_CONNECT_LIST_DOMAINS_MANAGEDSAVE 256)
	(:VIR_CONNECT_LIST_DOMAINS_NO_MANAGEDSAVE 512)
	(:VIR_CONNECT_LIST_DOMAINS_AUTOSTART 1024)
	(:VIR_CONNECT_LIST_DOMAINS_NO_AUTOSTART 2048)
	(:VIR_CONNECT_LIST_DOMAINS_HAS_SNAPSHOT 4096)
	(:VIR_CONNECT_LIST_DOMAINS_NO_SNAPSHOT 8192))

(defcenum virVcpuState
	(:VIR_VCPU_OFFLINE 0)	;; the virtual CPU is offline.
	(:VIR_VCPU_RUNNING 1)	;; the virtual CPU is running.
	(:VIR_VCPU_BLOCKED 2)	;; the virtual CPU is blocked on resource.
	(:VIR_VCPU_LAST 3))

(defcenum virDomainVcpuFlags
	(:VIR_DOMAIN_VCPU_CURRENT 0)
	(:VIR_DOMAIN_VCPU_LIVE 1)
	(:VIR_DOMAIN_VCPU_CONFIG 2)
	(:VIR_DOMAIN_VCPU_MAXIMUM 4)	;; Max rather than current count.
	(:VIR_DOMAIN_VCPU_GUEST 8))	;; Modify state of the cpu in the guest.

(defcenum virDomainDeviceModifyFlags
	(:VIR_DOMAIN_DEVICE_MODIFY_CURRENT 0)
	(:VIR_DOMAIN_DEVICE_MODIFY_LIVE 1)
	(:VIR_DOMAIN_DEVICE_MODIFY_CONFIG 2)
	(:VIR_DOMAIN_DEVICE_MODIFY_FORCE 4))	;; Forcibly modify device (ex. force eject a cdrom).

(defcenum virDomainStatsTypes
	(:VIR_DOMAIN_STATS_STATE 1)		;; return domain state.
	(:VIR_DOMAIN_STATS_CPU_TOTAL 2)		;;  return domain CPU info.
	(:VIR_DOMAIN_STATS_BALLOON 4)		;; return domain balloon info.
	(:VIR_DOMAIN_STATS_VCPU 8)		;; return domain virtual CPU info.
	(:VIR_DOMAIN_STATS_INTERFACE 16)	;; return domain interfaces info.
	(:VIR_DOMAIN_STATS_BLOCK 32))		;; return domain block info.

(defcenum virConnectGetAllDomainStatsFlags
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_ACTIVE 1)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_INACTIVE 2)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_PERSISTENT 4)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_TRANSIENT 8)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_RUNNING 16)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_PAUSED 32)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_SHUTOFF 64)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_OTHER 128)
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_BACKING 1073741824)		;; include backing chain for block stats.
	(:VIR_CONNECT_GET_ALL_DOMAINS_STATS_ENFORCE_STATS 2147483648)) 	;; enforce requested stats.

(defcenum virDomainBlockJobType
	(:VIR_DOMAIN_BLOCK_JOB_TYPE_UNKNOWN 0)		;; Placeholder.
	(:VIR_DOMAIN_BLOCK_JOB_TYPE_PULL 1)		;; Block Pull (virDomainBlockPull, or virDomainBlockRebase without flags), job ends on completion.
	(:VIR_DOMAIN_BLOCK_JOB_TYPE_COPY 2)		;; Block Copy (virDomainBlockCopy, or virDomainBlockRebase with flags), job exists as long as mirroring is active.
	(:VIR_DOMAIN_BLOCK_JOB_TYPE_COMMIT 3)		;; Block Commit (virDomainBlockCommit without flags), job ends on completion.
	(:VIR_DOMAIN_BLOCK_JOB_TYPE_ACTIVE_COMMIT 4)	;; Active Block Commit (virDomainBlockCommit with flags), job exists as long as sync is active.
	(:VIR_DOMAIN_BLOCK_JOB_TYPE_LAST 5))

(defcenum virDomainBlockJobAbortFlags
	(:VIR_DOMAIN_BLOCK_JOB_ABORT_ASYNC 1)
	(:VIR_DOMAIN_BLOCK_JOB_ABORT_PIVOT 2))

(defcenum virDomainBlockJobInfoFlags
	(:VIR_DOMAIN_BLOCK_JOB_INFO_BANDWIDTH_BYTES 1))	;; bandwidth in bytes/s instead of MiB/s.

(defcenum virDomainBlockJobSetSpeedFlags
	(:VIR_DOMAIN_BLOCK_JOB_SPEED_BANDWIDTH_BYTES 1))	;; bandwidth in bytes/s instead of MiB/s.

(defcenum virDomainBlockPullFlags
	(:VIR_DOMAIN_BLOCK_PULL_BANDWIDTH_BYTES 64))	;; bandwidth in bytes/s instead of MiB/s.

(defcenum virDomainBlockRebaseFlags
	(:VIR_DOMAIN_BLOCK_REBASE_SHALLOW 1)		;; Limit copy to top of source backing chain.
	(:VIR_DOMAIN_BLOCK_REBASE_REUSE_EXT 2)		;; Reuse existing external file for a copy.
	(:VIR_DOMAIN_BLOCK_REBASE_COPY_RAW 4)		;; Make destination file raw.
	(:VIR_DOMAIN_BLOCK_REBASE_COPY 8)		;; Start a copy job.
	(:VIR_DOMAIN_BLOCK_REBASE_RELATIVE 16)		;; Keep backing chain referenced using relative names.
	(:VIR_DOMAIN_BLOCK_REBASE_COPY_DEV 32)		;; Treat destination as block device instead of file.
	(:VIR_DOMAIN_BLOCK_REBASE_BANDWIDTH_BYTES 64))	;; bandwidth in bytes/s instead of MiB/s.

(defcenum virDomainBlockCopyFlags
	(:VIR_DOMAIN_BLOCK_COPY_SHALLOW 1)	;; Limit copy to top of source backing chain.
	(:VIR_DOMAIN_BLOCK_COPY_REUSE_EXT 2))	;; Reuse existing external file for a copy.

(defcenum virDomainBlockCommitFlags
	(:VIR_DOMAIN_BLOCK_COMMIT_SHALLOW 1)		;; NULL base means next backing file, not whole chain.
	(:VIR_DOMAIN_BLOCK_COMMIT_DELETE 2)		;; Delete any files that are now invalid after their contents have been committed.
	(:VIR_DOMAIN_BLOCK_COMMIT_ACTIVE 4)		;; Allow a two-phase commit when top is the active layer.
	(:VIR_DOMAIN_BLOCK_COMMIT_RELATIVE 8)		;; keep the backing chain referenced using relative names.
	(:VIR_DOMAIN_BLOCK_COMMIT_BANDWIDTH_BYTES 16))	;; bandwidth in bytes/s instead of MiB/s.

(defcenum virDomainDiskErrorCode
	(:VIR_DOMAIN_DISK_ERROR_NONE 0)	;; no error.
	(:VIR_DOMAIN_DISK_ERROR_UNSPEC 1)	;; unspecified I/O error.
	(:VIR_DOMAIN_DISK_ERROR_NO_SPACE 2)	;; no space left on the device.
	(:VIR_DOMAIN_DISK_ERROR_LAST 3))

(defcenum virKeycodeSet
	(:VIR_KEYCODE_SET_LINUX 0)
	(:VIR_KEYCODE_SET_XT 1)
	(:VIR_KEYCODE_SET_ATSET1 2)
	(:VIR_KEYCODE_SET_ATSET2 3)
	(:VIR_KEYCODE_SET_ATSET3 4)
	(:VIR_KEYCODE_SET_OSX 5)
	(:VIR_KEYCODE_SET_XT_KBD 6)
	(:VIR_KEYCODE_SET_USB 7)
	(:VIR_KEYCODE_SET_WIN32 8)
	(:VIR_KEYCODE_SET_RFB 9)
	(:VIR_KEYCODE_SET_LAST 10))

(defcenum virDomainProcessSignal
	(:VIR_DOMAIN_PROCESS_SIGNAL_NOP 0)	;; No constant in POSIX/Linux.
	(:VIR_DOMAIN_PROCESS_SIGNAL_HUP 1)	;; SIGHUP.
	(:VIR_DOMAIN_PROCESS_SIGNAL_INT 2)	;; SIGINT.
	(:VIR_DOMAIN_PROCESS_SIGNAL_QUIT 3)	;; SIGQUIT.
	(:VIR_DOMAIN_PROCESS_SIGNAL_ILL 4)	;; SIGILL.
	(:VIR_DOMAIN_PROCESS_SIGNAL_TRAP 5)	;; SIGTRAP.
	(:VIR_DOMAIN_PROCESS_SIGNAL_ABRT 6)	;; SIGABRT.
	(:VIR_DOMAIN_PROCESS_SIGNAL_BUS 7)	;; SIGBUS.
	(:VIR_DOMAIN_PROCESS_SIGNAL_FPE 8)	;; SIGFPE.
	(:VIR_DOMAIN_PROCESS_SIGNAL_KILL 9)	;; SIGKILL.
	(:VIR_DOMAIN_PROCESS_SIGNAL_USR1 10)	;; SIGUSR1.
	(:VIR_DOMAIN_PROCESS_SIGNAL_SEGV 11)	;; SIGSEGV.
	(:VIR_DOMAIN_PROCESS_SIGNAL_USR2 12)	;; SIGUSR2.
	(:VIR_DOMAIN_PROCESS_SIGNAL_PIPE 13)	;; SIGPIPE.
	(:VIR_DOMAIN_PROCESS_SIGNAL_ALRM 14)	;; SIGALRM.
	(:VIR_DOMAIN_PROCESS_SIGNAL_TERM 15)	;; SIGTERM.
	(:VIR_DOMAIN_PROCESS_SIGNAL_STKFLT 16)	;; Not in POSIX (SIGSTKFLT on Linux ).
	(:VIR_DOMAIN_PROCESS_SIGNAL_CHLD 17)	;; SIGCHLD.
	(:VIR_DOMAIN_PROCESS_SIGNAL_CONT 18)	;; SIGCONT.
	(:VIR_DOMAIN_PROCESS_SIGNAL_STOP 19)	;; SIGSTOP.
	(:VIR_DOMAIN_PROCESS_SIGNAL_TSTP 20)	;; SIGTSTP.
	(:VIR_DOMAIN_PROCESS_SIGNAL_TTIN 21)	;; SIGTTIN.
	(:VIR_DOMAIN_PROCESS_SIGNAL_TTOU 22)	;; SIGTTOU.
	(:VIR_DOMAIN_PROCESS_SIGNAL_URG 23)	;; SIGURG.
	(:VIR_DOMAIN_PROCESS_SIGNAL_XCPU 24)	;; SIGXCPU.
	(:VIR_DOMAIN_PROCESS_SIGNAL_XFSZ 25)	;; SIGXFSZ.
	(:VIR_DOMAIN_PROCESS_SIGNAL_VTALRM 26)	;; SIGVTALRM.
	(:VIR_DOMAIN_PROCESS_SIGNAL_PROF 27)	;; SIGPROF.
	(:VIR_DOMAIN_PROCESS_SIGNAL_WINCH 28)	;; Not in POSIX (SIGWINCH on Linux).
	(:VIR_DOMAIN_PROCESS_SIGNAL_POLL 29)	;; SIGPOLL (also known as SIGIO on Linux).
	(:VIR_DOMAIN_PROCESS_SIGNAL_PWR 30)	;; Not in POSIX (SIGPWR on Linux).
	(:VIR_DOMAIN_PROCESS_SIGNAL_SYS 31)	;; SIGSYS (also known as SIGUNUSED on Linux).
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT0 32)	;; SIGRTMIN.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT1 33)	;; SIGRTMIN + 1.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT2 34)	;; SIGRTMIN + 2.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT3 35)	;; SIGRTMIN + 3.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT4 36)	;; SIGRTMIN + 4.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT5 37)	;; SIGRTMIN + 5.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT6 38)	;; SIGRTMIN + 6.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT7 39)	;; SIGRTMIN + 7.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT8 40)	;; SIGRTMIN + 8.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT9 41)	;; SIGRTMIN + 9.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT10 42)	;; SIGRTMIN + 10.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT11 43)	;; SIGRTMIN + 11.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT12 44)	;; SIGRTMIN + 12.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT13 45)	;; SIGRTMIN + 13.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT14 46)	;; SIGRTMIN + 14.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT15 47)	;; SIGRTMIN + 15.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT16 48)	;; SIGRTMIN + 16.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT17 49)	;; SIGRTMIN + 17.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT18 50)	;; SIGRTMIN + 18.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT19 51)	;; SIGRTMIN + 19.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT20 52)	;; SIGRTMIN + 20.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT21 53)	;; SIGRTMIN + 21.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT22 54)	;; SIGRTMIN + 22.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT23 55)	;; SIGRTMIN + 23.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT24 56)	;; SIGRTMIN + 24.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT25 57)	;; SIGRTMIN + 25.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT26 58)	;; SIGRTMIN + 26.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT27 59)	;; SIGRTMIN + 27.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT28 60)	;; SIGRTMIN + 28.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT29 61)	;; SIGRTMIN + 29.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT30 62)	;; SIGRTMIN + 30.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT31 63)	;; SIGRTMIN + 31.
	(:VIR_DOMAIN_PROCESS_SIGNAL_RT32 64)	;; SIGRTMIN + 32 / SIGRTMAX.
	(:VIR_DOMAIN_PROCESS_SIGNAL_LAST 65))

(defcenum virDomainEventType
	(:VIR_DOMAIN_EVENT_DEFINED 0)
	(:VIR_DOMAIN_EVENT_UNDEFINED 1)
	(:VIR_DOMAIN_EVENT_STARTED 2)
	(:VIR_DOMAIN_EVENT_SUSPENDED 3)
	(:VIR_DOMAIN_EVENT_RESUMED 4)
	(:VIR_DOMAIN_EVENT_STOPPED 5)
	(:VIR_DOMAIN_EVENT_SHUTDOWN 6)
	(:VIR_DOMAIN_EVENT_PMSUSPENDED 7)
	(:VIR_DOMAIN_EVENT_CRASHED 8)
	(:VIR_DOMAIN_EVENT_LAST 9))

(defcenum virDomainEventDefinedDetailType
	(:VIR_DOMAIN_EVENT_DEFINED_ADDED 0)	;; Newly created config file.
	(:VIR_DOMAIN_EVENT_DEFINED_UPDATED 1)   ;; Changed config file.
	(:VIR_DOMAIN_EVENT_DEFINED_LAST 2))

(defcenum virDomainEventUndefinedDetailType
	(:VIR_DOMAIN_EVENT_UNDEFINED_REMOVED 0)	;; Deleted the config file.
	(:VIR_DOMAIN_EVENT_UNDEFINED_LAST 1))

(defcenum virDomainEventStartedDetailType
	(:VIR_DOMAIN_EVENT_STARTED_BOOTED 0)		;; Normal startup from boot.
	(:VIR_DOMAIN_EVENT_STARTED_MIGRATED 1)		;; Incoming migration from another host.
	(:VIR_DOMAIN_EVENT_STARTED_RESTORED 2)		;; Restored from a state file.
	(:VIR_DOMAIN_EVENT_STARTED_FROM_SNAPSHOT 3)	;; Restored from snapshot.
	(:VIR_DOMAIN_EVENT_STARTED_WAKEUP 4)		;; Started due to wakeup event.
	(:VIR_DOMAIN_EVENT_STARTED_LAST 5))

(defcenum virDomainEventSuspendedDetailType
	(:VIR_DOMAIN_EVENT_SUSPENDED_PAUSED 0)		;; Normal suspend due to admin pause.
	(:VIR_DOMAIN_EVENT_SUSPENDED_MIGRATED 1)	;; Suspended for offline migration.
	(:VIR_DOMAIN_EVENT_SUSPENDED_IOERROR 2)		;; Suspended due to a disk I/O error.
	(:VIR_DOMAIN_EVENT_SUSPENDED_WATCHDOG 3)	;; Suspended due to a watchdog firing.
	(:VIR_DOMAIN_EVENT_SUSPENDED_RESTORED 4)	;; Restored from paused state file.
	(:VIR_DOMAIN_EVENT_SUSPENDED_FROM_SNAPSHOT 5)	;; Restored from paused snapshot.
	(:VIR_DOMAIN_EVENT_SUSPENDED_API_ERROR 6)	;; suspended after failure during libvirt API call.
	(:VIR_DOMAIN_EVENT_SUSPENDED_LAST 7))

(defcenum virDomainEventResumedDetailType
	(:VIR_DOMAIN_EVENT_RESUMED_UNPAUSED 0)		;; Normal resume due to admin unpause.
	(:VIR_DOMAIN_EVENT_RESUMED_MIGRATED 1)		;; Resumed for completion of migration.
	(:VIR_DOMAIN_EVENT_RESUMED_FROM_SNAPSHOT 2)	;; Resumed from snapshot.
	(:VIR_DOMAIN_EVENT_RESUMED_LAST 3))

(defcenum virDomainEventStoppedDetailType
	(:VIR_DOMAIN_EVENT_STOPPED_SHUTDOWN 0)		;; Normal shutdown.
	(:VIR_DOMAIN_EVENT_STOPPED_DESTROYED 1)		;; Forced poweroff from host.
	(:VIR_DOMAIN_EVENT_STOPPED_CRASHED 2)		;; Guest crashed.
	(:VIR_DOMAIN_EVENT_STOPPED_MIGRATED 3)		;; Migrated off to another host.
	(:VIR_DOMAIN_EVENT_STOPPED_SAVED 4)		;; Saved to a state file.
	(:VIR_DOMAIN_EVENT_STOPPED_FAILED 5)		;; Host emulator/mgmt failed.
	(:VIR_DOMAIN_EVENT_STOPPED_FROM_SNAPSHOT 6)	;; offline snapshot loaded.
	(:VIR_DOMAIN_EVENT_STOPPED_LAST 7))

(defcenum virDomainEventShutdownDetailType
	(:VIR_DOMAIN_EVENT_SHUTDOWN_FINISHED 0)	;; Guest finished shutdown sequence.
	(:VIR_DOMAIN_EVENT_SHUTDOWN_LAST 1))

(defcenum virDomainEventPMSuspendedDetailType
	(:VIR_DOMAIN_EVENT_PMSUSPENDED_MEMORY 0)	;; Guest was PM suspended to memory.
	(:VIR_DOMAIN_EVENT_PMSUSPENDED_DISK 1)		;; Guest was PM suspended to disk.
	(:VIR_DOMAIN_EVENT_PMSUSPENDED_LAST 2))

(defcenum virDomainEventCrashedDetailType
	(:VIR_DOMAIN_EVENT_CRASHED_PANICKED 0) ;; Guest was panicked.
	(:VIR_DOMAIN_EVENT_CRASHED_LAST 1))

(defcenum virDomainJobType
	(:VIR_DOMAIN_JOB_NONE 0)	;; No job is active.
	(:VIR_DOMAIN_JOB_BOUNDED 1)	;; Job with a finite completion time.
	(:VIR_DOMAIN_JOB_UNBOUNDED 2)	;; Job without a finite completion time.
	(:VIR_DOMAIN_JOB_COMPLETED 3)	;; Job has finished, but isn't cleaned up.
	(:VIR_DOMAIN_JOB_FAILED 4)	;; Job hit error, but isn't cleaned up.
	(:VIR_DOMAIN_JOB_CANCELLED 5)	;; Job was aborted, but isn't cleaned up.
	(:VIR_DOMAIN_JOB_LAST 6))

(defcenum virDomainGetJobStatsFlags
	(:VIR_DOMAIN_JOB_STATS_COMPLETED 1))	;; return stats of a recently completed job.

(defcenum virDomainEventWatchdogAction
	(:VIR_DOMAIN_EVENT_WATCHDOG_NONE 0)		;; No action, watchdog ignored.
	(:VIR_DOMAIN_EVENT_WATCHDOG_PAUSE 1)		;; Guest CPUs are paused.
	(:VIR_DOMAIN_EVENT_WATCHDOG_RESET 2)		;; Guest CPUs are reset.
	(:VIR_DOMAIN_EVENT_WATCHDOG_POWEROFF 3)		;; Guest is forcibly powered off.
	(:VIR_DOMAIN_EVENT_WATCHDOG_SHUTDOWN 4)		;; Guest is requested to gracefully shutdown.
	(:VIR_DOMAIN_EVENT_WATCHDOG_DEBUG 5)		;; No action, a debug message logged.
	(:VIR_DOMAIN_EVENT_WATCHDOG_LAST 6))

(defcenum virDomainEventIOErrorAction
	(:VIR_DOMAIN_EVENT_IO_ERROR_NONE 0)	;; No action, IO error ignored.
	(:VIR_DOMAIN_EVENT_IO_ERROR_PAUSE 1)	;; Guest CPUs are paused.
	(:VIR_DOMAIN_EVENT_IO_ERROR_REPORT 2)	;; IO error reported to guest OS.
	(:VIR_DOMAIN_EVENT_IO_ERROR_LAST 3))

(defcenum virDomainEventGraphicsPhase
	(:VIR_DOMAIN_EVENT_GRAPHICS_CONNECT 0)	;; Initial socket connection established.
	(:VIR_DOMAIN_EVENT_GRAPHICS_INITIALIZE 1)	;; Authentication & setup completed.
	(:VIR_DOMAIN_EVENT_GRAPHICS_DISCONNECT 2)	;; Final socket disconnection.
	(:VIR_DOMAIN_EVENT_GRAPHICS_LAST 3))

(defcenum virDomainEventGraphicsAddressType
	(:VIR_DOMAIN_EVENT_GRAPHICS_ADDRESS_IPV4 0)	;; IPv4 address.
	(:VIR_DOMAIN_EVENT_GRAPHICS_ADDRESS_IPV6 1)	;; IPv6 address.
	(:VIR_DOMAIN_EVENT_GRAPHICS_ADDRESS_UNIX 2)	;; UNIX socket path.
	(:VIR_DOMAIN_EVENT_GRAPHICS_ADDRESS_LAST 3))

(defcenum virDomainEventTrayChangeReason
	(:VIR_DOMAIN_EVENT_TRAY_CHANGE_OPEN 0)
	(:VIR_DOMAIN_EVENT_TRAY_CHANGE_CLOSE 1)
	(:VIR_DOMAIN_EVENT_TRAY_CHANGE_LAST 2))

(defcenum virConnectDomainEventAgentLifecycleState
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_CONNECTED 1)		;; agent connected.
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_DISCONNECTED 2)	;; agent disconnected.
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_STATE_LAST 3))

(defcenum virConnectDomainEventAgentLifecycleReason
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_UNKNOWN 0)		;; unknown state change reason.
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_DOMAIN_STARTED 1)	;; state changed due to domain start.
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_CHANNEL 2)		;; channel state changed.
	(:VIR_CONNECT_DOMAIN_EVENT_AGENT_LIFECYCLE_REASON_LAST 3))

(defcenum virDomainEventID
	(:VIR_DOMAIN_EVENT_ID_LIFECYCLE 0)		;; virConnectDomainEventCallback.
	(:VIR_DOMAIN_EVENT_ID_REBOOT 1)			;; virConnectDomainEventGenericCallback.
	(:VIR_DOMAIN_EVENT_ID_RTC_CHANGE 2)		;; virConnectDomainEventRTCChangeCallback.
	(:VIR_DOMAIN_EVENT_ID_WATCHDOG 3)		;; virConnectDomainEventWatchdogCallback.
	(:VIR_DOMAIN_EVENT_ID_IO_ERROR 4)		;; virConnectDomainEventIOErrorCallback.
	(:VIR_DOMAIN_EVENT_ID_GRAPHICS 5)		;; virConnectDomainEventGraphicsCallback.
	(:VIR_DOMAIN_EVENT_ID_IO_ERROR_REASON 6)	;; virConnectDomainEventIOErrorReasonCallback.
	(:VIR_DOMAIN_EVENT_ID_CONTROL_ERROR 7)		;; virConnectDomainEventGenericCallback.
	(:VIR_DOMAIN_EVENT_ID_BLOCK_JOB 8)		;; virConnectDomainEventBlockJobCallback.
	(:VIR_DOMAIN_EVENT_ID_DISK_CHANGE 9)		;; virConnectDomainEventDiskChangeCallback.
	(:VIR_DOMAIN_EVENT_ID_TRAY_CHANGE 10)		;; virConnectDomainEventTrayChangeCallback.
	(:VIR_DOMAIN_EVENT_ID_PMWAKEUP 11)		;; virConnectDomainEventPMWakeupCallback.
	(:VIR_DOMAIN_EVENT_ID_PMSUSPEND 12)		;; virConnectDomainEventPMSuspendCallback.
	(:VIR_DOMAIN_EVENT_ID_BALLOON_CHANGE 13)	;; virConnectDomainEventBalloonChangeCallback.
	(:VIR_DOMAIN_EVENT_ID_PMSUSPEND_DISK 14)	;; virConnectDomainEventPMSuspendDiskCallback.
	(:VIR_DOMAIN_EVENT_ID_DEVICE_REMOVED 15)	;; virConnectDomainEventDeviceRemovedCallback.
	(:VIR_DOMAIN_EVENT_ID_BLOCK_JOB_2 16)		;; virConnectDomainEventBlockJobCallback.
	(:VIR_DOMAIN_EVENT_ID_TUNABLE 17)		;; virConnectDomainEventTunableCallback.
	(:VIR_DOMAIN_EVENT_ID_AGENT_LIFECYCLE 18)	;; virConnectDomainEventAgentLifecycleCallback.
	(:VIR_DOMAIN_EVENT_ID_LAST 19))

(defcenum virDomainConsoleFlags
	(:VIR_DOMAIN_CONSOLE_FORCE 1)	;; abort a (possibly) active console connection to force a new connection.
	(:VIR_DOMAIN_CONSOLE_SAFE 2)) 	;; check if the console driver supports safe console operations.

(defcenum virDomainChannelFlags
	(:VIR_DOMAIN_CHANNEL_FORCE 1))	;; abort a (possibly) active channel connection to force a new connection.

(defcenum virDomainOpenGraphicsFlags
	(:VIR_DOMAIN_OPEN_GRAPHICS_SKIPAUTH 1))

(defcenum virDomainSetTimeFlags
	(:VIR_DOMAIN_TIME_SYNC 1)) ;; Re-sync domain time from domain's RTC.


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


;; Management of domain memory.
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


