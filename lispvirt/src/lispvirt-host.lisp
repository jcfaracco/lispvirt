;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-host.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-host
  (:use :cl :cffi)
  (:export :virConnectPtr
	   :virStreamPtr
	   :virSecurityLabelPtr
	   :virTypedParameterPtr
	   :virSecurityModelPtr
	   :virConnectAuthPtr
	   :virNodeInfoPtr
	   :virNodeCPUStatsPtr
	   :virNodeMemoryStatsPtr
	   :virTypedParamsGet
	   :virTypedParamsGetInt
	   :virTypedParamsGetUInt
	   :virTypedParamsGetLLong
	   :virTypedParamsGetULLong
	   :virTypedParamsGetDouble
	   :virTypedParamsGetBoolean
	   :virTypedParamsGetString
	   :virTypedParamsAddInt
	   :virTypedParamsAddUInt
	   :virTypedParamsAddLLong
	   :virTypedParamsAddULLong
	   :virTypedParamsAddDouble
	   :virTypedParamsAddBoolean
	   :virTypedParamsAddString
	   :virTypedParamsAddFromString
	   :virTypedParamsClear
	   :virTypedParamsFree
	   :virNodeGetMemoryParameters
	   :virNodeSetMemoryParameters
	   :virNodeGetCPUMap
	   :virGetVersion
	   :virInitialize
	   :virConnectOpen
	   :virConnectOpenReadOnly
	   :virConnectOpenAuth
	   :virConnectRef
	   :virConnectClose
	   :virConnectGetType
	   :virConnectGetVersion
	   :virConnectGetLibVersion
	   :virConnectGetHostname
	   :virConnectGetURI
	   :virConnectGetSysinfo
	   :virConnectSetKeepAlive
	   :virConnectGetMaxVcpus
	   :virNodeGetInfo
	   :virConnectGetCapabilities
	   :virNodeGetCPUStats
	   :virNodeGetMemoryStats
	   :virNodeGetFreeMemory
	   :virNodeGetSecurityModel
	   :virNodeSuspendForDuration
	   :virNodeGetCellsFreeMemory
	   :virConnectIsEncrypted
	   :virConnectIsSecure
	   :virConnectIsAlive
	   :virConnectCompareCPU
	   :virConnectGetCPUModelNames
	   :virConnectBaselineCPU
	   :virNodeGetFreePages
	   :virNodeAllocPages
	   :virNodeSuspendTarget
	   :virTypedParameterType
	   :virTypedParameterFlags
	   :virNodeGetCPUStatsAllCPUs
	   :virNodeGetMemoryStatsAllCells
	   :virConnectFlags
	   :virConnectCredentialType
	   :virConnectCloseReason
	   :virCPUCompareResult
	   :virConnectCompareCPUFlags
	   :virConnectBaselineCPUFlags
	   :virNodeAllocPagesFlags))

(in-package :lispvirt-host)


;; Definitions of strucutres for Host.
(defcstruct virConnect)

(defcstruct virStream)

(defcstruct virSecurityLabel)

(defcstruct virTypedParameter)

(defcstruct virSecurityModel)

(defcstruct virConnectAuth)

(defcstruct virNodeInfo)

(defcstruct virNodeCPUStats)

(defcstruct virNodeMemoryStats)

(defcenum virNodeSuspendTarget
	(:VIR_NODE_SUSPEND_TARGET_MEM 0)
	(:VIR_NODE_SUSPEND_TARGET_DISK 1)
	(:VIR_NODE_SUSPEND_TARGET_HYBRID 2)
	(:VIR_NODE_SUSPEND_TARGET_LAST 3))

(defcenum virTypedParameterType
	(:VIR_TYPED_PARAM_INT 1)	;; integer case.
	(:VIR_TYPED_PARAM_UINT 2)	;; unsigned integer case.
	(:VIR_TYPED_PARAM_LLONG 3)	;; long long case.
	(:VIR_TYPED_PARAM_ULLONG 4)	;; unsigned long long case.
	(:VIR_TYPED_PARAM_DOUBLE 5)	;; double case.
	(:VIR_TYPED_PARAM_BOOLEAN 6)	;; boolean(character) case.
	(:VIR_TYPED_PARAM_STRING 7)	;; string case.
	(:VIR_TYPED_PARAM_LAST 8))

(defcenum virTypedParameterFlags
	(:VIR_TYPED_PARAM_STRING_OKAY 4))

(defcenum virNodeGetCPUStatsAllCPUs
	(:VIR_NODE_CPU_STATS_ALL_CPUS -1))

(defcenum virNodeGetMemoryStatsAllCells
	(:VIR_NODE_MEMORY_STATS_ALL_CELLS -1))

(defcenum virConnectFlags
	(:VIR_CONNECT_RO 1)		;; A readonly connection.
	(:VIR_CONNECT_NO_ALIASES 2))	;; Don't try to resolve URI aliases.

(defcenum virConnectCredentialType
	(:VIR_CRED_USERNAME 1)		;; Identity to act as.
	(:VIR_CRED_AUTHNAME 2)		;; Identify to authorize as.
	(:VIR_CRED_LANGUAGE 3)		;; RFC 1766 languages, comma separated.
	(:VIR_CRED_CNONCE 4)		;; client supplies a nonce.
	(:VIR_CRED_PASSPHRASE 5)	;; Passphrase secret.
	(:VIR_CRED_ECHOPROMPT 6)	;; Challenge response.
	(:VIR_CRED_NOECHOPROMPT 7)	;; Challenge response.
	(:VIR_CRED_REALM 8)		;; Authentication realm.
	(:VIR_CRED_EXTERNAL 9)		;; Externally managed credential.
	(:VIR_CRED_LAST 10))

(defcenum virConnectCloseReason
	(:VIR_CONNECT_CLOSE_REASON_ERROR 0)	;; Misc I/O error.
	(:VIR_CONNECT_CLOSE_REASON_EOF 1)	;; End-of-file from server.
	(:VIR_CONNECT_CLOSE_REASON_KEEPALIVE 2)	;; Keepalive timer triggered.
	(:VIR_CONNECT_CLOSE_REASON_CLIENT 3)	;; Client requested it.
	(:VIR_CONNECT_CLOSE_REASON_LAST 4))

(defcenum virCPUCompareResult
	(:VIR_CPU_COMPARE_ERROR -1)
	(:VIR_CPU_COMPARE_INCOMPATIBLE 0)
	(:VIR_CPU_COMPARE_IDENTICAL 1)
	(:VIR_CPU_COMPARE_SUPERSET 2)
	(:VIR_CPU_COMPARE_LAST 3))

(defcenum virConnectCompareCPUFlags
	(:VIR_CONNECT_COMPARE_CPU_FAIL_INCOMPATIBLE 1))	;; treat incompatible CPUs as failure.

(defcenum virConnectBaselineCPUFlags
	(:VIR_CONNECT_BASELINE_CPU_EXPAND_FEATURES 1)	;; show all features.
	(:VIR_CONNECT_BASELINE_CPU_MIGRATABLE 2))	;; filter out non-migratable features.

(defcenum virNodeAllocPagesFlags
	(:VIR_NODE_ALLOC_PAGES_ADD 0)	;; Add @pageCounts to the pages pool. This can be used only to size up the pool.
	(:VIR_NODE_ALLOC_PAGES_SET 1))	;; Don't add @pageCounts, instead set passed number of pages. This can be used to free allocated pages.


;; Pointers mapping to structures.
(defctype virConnectPtr (:pointer virConnect))

(defctype virStreamPtr (:pointer virStream))

(defctype virSecurityLabelPtr (:pointer virSecurityLabel))

(defctype virTypedParameterPtr (:pointer virTypedParameter))

(defctype virSecurityModelPtr (:pointer virSecurityModel))

(defctype virConnectAuthPtr (:pointer virConnectAuth))

(defctype virNodeInfoPtr (:pointer virNodeInfo))

(defctype virNodeCPUStatsPtr (:pointer virNodeCPUStats))

(defctype virNodeMemoryStatsPtr (:pointer virNodeMemoryStats))


;; Methods.
(defcfun "virTypedParamsGet" virTypedParameterPtr
	(params virTypedParameterPtr params)
	(nparams :int)
	(name :string))

(defcfun ("virTypedParamsGetInt" %virTypedParamsGetInt) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :int)))

(defun virTypedParamsGetInt (params nparams name)
        (with-foreign-objects ((value :int))
                (%virTypedParamsGetInt params nparams name value)
                (values (mem-ref value :int))))

(defcfun ("virTypedParamsGetUInt" %virTypedParamsGetUInt) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :uint)))

(defun virTypedParamsGetUInt (params nparams name)
        (with-foreign-objects ((value :uint))
                (%virTypedParamsGetUInt params nparams name value)
                (values (mem-ref value :uint))))

(defcfun ("virTypedParamsGetLLong" %virTypedParamsGetLLong) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :llong)))

(defun virTypedParamsGetLLong (params nparams name)
        (with-foreign-objects ((value :llong))
                (%virTypedParamsGetLLong params nparams name value)
                (values (mem-ref value :llong))))

(defcfun ("virTypedParamsGetULLong" %virTypedParamsGetULLong) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :ullong)))

(defun virTypedParamsGetULLong (params nparams name)
        (with-foreign-objects ((value :ullong))
                (%virTypedParamsGetULLong params nparams name value)
                (values (mem-ref value :ullong))))

(defcfun ("virTypedParamsGetDouble" %virTypedParamsGetDouble) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :double)))

(defun virTypedParamsGetDouble (params nparams name)
        (with-foreign-objects ((value :double))
                (%virTypedParamsGetDouble params nparams name value)
                (values (mem-ref value :double))))

(defcfun ("virTypedParamsGetBoolean" %virTypedParamsGetBoolean) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(values (:pointer :int)))

(defun virTypedParamsGetBoolean (params nparams name)
        (with-foreign-objects ((value :int))
                (%virTypedParamsGetBoolean params nparams name value)
                (values (mem-ref value :int))))

(defcfun ("virTypedParamsGetString" %virTypedParamsGetString) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :string)))

(defun virTypedParamsGetString (params nparams name)
        (with-foreign-objects ((value :string))
                (%virTypedParamsGetInt params nparams name value)
                (values (mem-ref value :string))))

(defcfun "virTypedParamsAddInt" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :int))

(defcfun "virTypedParamsAddUInt" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :uint))

(defcfun "virTypedParamsAddLLong" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :llong))

(defcfun "virTypedParamsAddULLong" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :ullong))

(defcfun "virTypedParamsAddDouble" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :double))

(defcfun "virTypedParamsAddBoolean" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :int))

(defcfun "virTypedParamsAddString" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(value :string))

(defcfun "virTypedParamsAddFromString" :int
	(params (:pointer virTypedParameterPtr))
	(nparams (:pointer :int))
	(maxparams (:pointer :int))
	(name :string)
	(type :int)
	(value :string))

(defcfun "virTypedParamsClear" :void
	(params virTypedParameterPtr)
	(nparams :int))

(defcfun "virTypedParamsFree" :void
	(params virTypedParameterPtr)
	(nparams :int))

(defcfun ("virNodeGetMemoryParameters" %virNodeGetMemoryParameters) :int
	(conn virConnectPtr)
	(params virTypedParameterPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virNodeGetMemoryParameters (conn flags)
        (with-foreign-objects ((params virTypedParameterPtr)
			       (nparams :int))
                (%virNodeGetMemoryParameters conn params nparams flags)
                (values (mem-ref params virTypedParameterPtr)
			(mem-ref nparams :int))))

(defcfun "virNodeSetMemoryParameters" :int
	(conn virConnectPtr)
	(params virTypedParameterPtr)
	(nparams :int)
	(flags :uint))


;;  Node CPU map.
(defcfun ("virNodeGetCPUMap" %virNodeGetCPUMap) :int
	(conn virConnectPtr)
	(cpumap (:pointer :string))
	(online (:pointer :uint))
	(flags :uint))

(defun virNodeGetCPUMap (conn flags)
        (with-foreign-objects ((cpumap :string)
			       (online :uint))
                (%virNodeGetCPUMap conn cpumap online flags)
                (values (mem-ref cpumap :string)
			(mem-ref online :uint))))

(defcfun ("virGetVersion" %virGetVersion) :int
	(libVer (:pointer :ulong))
	(type :string)
	(typeVer (:pointer :ulong)))

(defun virGetVersion (type)
        (with-foreign-objects ((libVer :ulong)
			       (typeVer :ulong))
                (%virGetVersion libVer type typeVer)
                (values (mem-ref libVer :ulong)
			(mem-ref typeVer :ulong))))


;; Connection and disconnections to the Hypervisor
(defcfun "virInitialize" :int)

(defcfun "virConnectOpen" virConnectPtr
        (name :string))

(defcfun "virConnectOpenReadOnly" virConnectPtr
	(name :string))

(defcfun "virConnectOpenAuth" virConnectPtr
	(name :string)
	(auth virConnectAuthPtr)
	(flags :uint))

(defcfun "virConnectRef" virConnectPtr
	(conn virConnectPtr))

(defcfun "virConnectClose" :int
	(conn virConnectPtr))

(defcfun "virConnectGetType" :string
	(conn virConnectPtr))

(defcfun ("virConnectGetVersion" %virConnectGetVersion) :int
	(conn virConnectPtr)
	(hvVer (:pointer :ulong)))

(defun virConnectGetVersion (conn)
        (with-foreign-objects ((hvVer :ulong))
                (%virConnectGetVersion conn hvVer)
                (values (mem-ref hvVer :ulong))))

(defcfun ("virConnectGetLibVersion" %virConnectGetLibVersion) :int
	(conn virConnectPtr)
	(libVer (:pointer :ulong)))

(defun virConnectGetLibVersion (conn)
        (with-foreign-objects ((libVer :ulong))
                (%virConnectGetLibVersion conn libVer)
                (values (mem-ref libVer :ulong))))

(defcfun "virConnectGetHostname" :string
	(conn virConnectPtr))

(defcfun "virConnectGetURI" :string
	(conn virConnectPtr))

(defcfun "virConnectGetSysinfo" :string
	(conn virConnectPtr)
	(flags :uint))

(defcfun "virConnectSetKeepAlive" :int
	(conn virConnectPtr)
	(interval :int)
	(count :uint))

;;(defcfun "virConnectRegisterCloseCallback" :int
;;	(conn virConnectPtr)
;;	(cb virConnectCloseFunc)
;;	(opaque (:pointer :void))
;;	(freecb virFreeCallback))

;;(defcfun "virConnectUnregisterCloseCallback" :int
;;	(conn virConnectPtr)
;;	(cb virConnectCloseFunc))


;; Capabilities of the connection/driver.
(defcfun "virConnectGetMaxVcpus" :int
	(conn virConnectPtr)
	(type :string))

(defcfun "virNodeGetInfo" :int
	(conn virConnectPtr)
	(info virNodeInfoPtr))

(defcfun "virConnectGetCapabilities" :string
	(conn virConnectPtr))

(defcfun ("virNodeGetCPUStats" %virNodeGetCPUStats) :int
	(conn virConnectPtr)
	(cpuNum :int)
	(params virNodeCPUStatsPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virNodeGetCPUStats (conn cpuNum flags)
        (with-foreign-objects ((params virNodeCPUStatsPtr)
			       (nparams :int))
                (%virNodeGetCPUStats conn cpuNum params nparams flags)
                (values (mem-ref params virNodeCPUStatsPtr)
			(mem-ref nparams :int))))

(defcfun ("virNodeGetMemoryStats" %virNodeGetMemoryStats) :int
	(conn virConnectPtr)
	(cellNum :int)
	(params virNodeMemoryStatsPtr)
	(nparams (:pointer :int))
	(flags :uint))

(defun virNodeGetMemoryStats (conn cellNum flags)
        (with-foreign-objects ((params virNodeMemoryStatsPtr)
			       (nparams :int))
                (%virNodeGetMemoryStats conn cellNum params nparams flags)
                (values (mem-ref params virNodeMemoryStatsPtr)
			(mem-ref nparams :int))))

(defcfun "virNodeGetFreeMemory" :ullong
	(conn virConnectPtr))

(defcfun "virNodeGetSecurityModel" :int
	(conn virConnectPtr)
	(secmodel virSecurityModelPtr))

(defcfun "virNodeSuspendForDuration" :int
	(conn virConnectPtr)
	(target :uint)
	(duration :ullong)
	(flags :uint))


;; NUMA support
(defcfun ("virNodeGetCellsFreeMemory" %virNodeGetCellsFreeMemory) :int
	(conn virConnectPtr)
	(freeMems (:pointer :ullong))
	(startCell :int)
	(maxCells :int))

(defun virNodeGetCellsFreeMemory (conn startCell maxCells)
        (with-foreign-objects ((freeMems :ullong))
                (%virNodeGetCellsFreeMemory conn freeMems startCells maxCells)
                (values (mem-ref freeMems :ullong))))

(defcfun "virConnectIsEncrypted" :int
	(conn virConnectPtr))

(defcfun "virConnectIsSecure" :int
	(conn virConnectPtr))

(defcfun "virConnectIsAlive" :int
	(conn virConnectPtr))

;; CPU specification API
(defcfun "virConnectCompareCPU" :int
	(conn virConnectPtr)
	(xmlDesc :string)
	(flags :uint))

(defcfun ("virConnectGetCPUModelNames" %virConnectGetCPUModelNames) :int
	(conn virConnectPtr)
	(arch :string)
	(models (:pointer (:pointer :string)))
	(flags :uint))

(defcfun "virConnectBaselineCPU" :string
	(conn virConnectPtr)
	(xmlCPUs (:pointer :string))
	(ncpus :uint)
	(flags :uint))

(defcfun ("virNodeGetFreePages" %virNodeGetFreePages) :int
	(conn virConnectPtr)
	(npages :uint)
	(pages (:pointer :uint))
	(startcell :int)
	(cellcount :uint)
	(counts (:pointer :ullong))
	(flags :uint))

(defun virNodeGetFreePages (conn npages startcell cellcount flags)
        (with-foreign-objects ((pages :uint)
                               (counts :ullong))
                (%virNodeGetFreePages conn npages pages startcell cellcount counts flags)
                (values (mem-ref pages :uint)
                        (mem-ref counts :ullong))))

(defcfun ("virNodeAllocPages" %virNodeAllocPages) :int
	(conn virConnectPtr)
	(npages :uint)
	(pageSizes (:pointer :uint))
	(pageCounts (:pointer :ullong))
	(startCell :int)
	(cellCount :uint)
	(flags :uint))

(defun virNodeAllocPages (conn npages startCell cellCount flags)
        (with-foreign-objects ((pageSizes :uint)
                               (pageCounts :ullong))
                (%virNodeAllocPages conn npages pageSizes pageCounts startCell cellCount flags)
                (values (mem-ref pageSizes :uint)
                        (mem-ref pageCounts :ullong))))
