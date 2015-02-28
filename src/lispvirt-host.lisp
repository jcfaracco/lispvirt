(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-host
  (:use :cl :cffi))

(in-package :lispvirt-ffi)


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

(defcfun ("virTypedParamsGetUInt" %virTypedParamsGetUInt) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :uint)))

(defcfun ("virTypedParamsGetLLong" %virTypedParamsGetLLong) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :llong)))

(defcfun ("virTypedParamsGetULLong" %virTypedParamsGetULLong) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :ullong)))

(defcfun ("virTypedParamsGetDouble" %virTypedParamsGetDouble) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :double)))

(defcfun ("virTypedParamsGetBoolean" %virTypedParamsGetBoolean) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(values (:pointer :int)))

(defcfun ("virTypedParamsGetString" %virTypedParamsGetString) :int
	(params virTypedParameterPtr)
	(nparams :int)
	(name :string)
	(value (:pointer :string)))

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

(defcfun ("virGetVersion" %virGetVersion) :int
	(libVer (:pointer :ulong))
	(type :string)
	(typeVer (:pointer :ulong)))

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

(defcfun ("virConnectGetLibVersion" %virConnectGetLibVersion) :int
	(conn virConnectPtr)
	(libVer (:pointer :ulong)))

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

(defcfun ("virNodeGetMemoryStats" %virNodeGetMemoryStats) :int
	(conn virConnectPtr)
	(cellNum :int)
	(params virNodeMemoryStatsPtr)
	(nparams (:pointer :int))
	(flags :uint))

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

(defcfun ("virNodeAllocPages" %virNodeAllocPages) :int
	(conn virConnectPtr)
	(npages :uint)
	(pageSizes (:pointer :uint))
	(*pageCounts (:pointer :ullong))
	(startCell :int)
	(cellCount :uint)
	(flags :uint))


