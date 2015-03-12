;;;-------------------------------------------------------------------------
;;; Lispvirt - Common LISP bindings for Libvirt.
;;;
;;; Copyright (C) 2015 Julio Cesar Faracco
;;;
;;; lispvirt-event.lisp is part of Lispvirt.
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

(defpackage #:lispvirt-event
  (:use :cl :cffi)
  (:export :virEventHandleType
	   :virEventRegisterDefaultImpl
	   :virEventRunDefaultImpl
	   :virEventUpdateHandle
	   :virEventRemoveHandle
	   :virEventUpdateTimeout
	   :virEventRemoveTimeout))

(in-package :lispvirt-event)


;; Definitions of strucutres for Storage.
(defcenum virEventHandleType
	(:VIR_EVENT_HANDLE_READABLE 1)
	(:VIR_EVENT_HANDLE_WRITABLE 2)
	(:VIR_EVENT_HANDLE_ERROR 4)
	(:VIR_EVENT_HANDLE_HANGUP 8))


;; Methods
;;(defcfun "virEventRegisterImpl" :void
;;	(addHandle virEventAddHandleFunc)
;;	(updateHandle virEventUpdateHandleFunc)
;;	(removeHandle virEventRemoveHandleFunc)
;;	(addTimeout virEventAddTimeoutFunc)
;;	(updateTimeout virEventUpdateTimeoutFunc)
;;	(removeTimeout virEventRemoveTimeoutFunc))

(defcfun "virEventRegisterDefaultImpl" :int)

(defcfun "virEventRunDefaultImpl" :int)

;;(defcfun "virEventAddHandle" :int
;;	(fd :int)
;;	(events :int)
;;	(cb virEventHandleCallback)
;;	(opaque (:pointer :void))
;;	(ff virFreeCallback))

(defcfun "virEventUpdateHandle" :void
	(watch :int)
	(events :int))

(defcfun "virEventRemoveHandle" :int
	(watch :int))

;;(defcfun "virEventAddTimeout" :int
;;	(frequency :int)
;;	(cb virEventTimeoutCallback)
;;	(opaque (:pointer :void))
;;	(ff virFreeCallback))

(defcfun "virEventUpdateTimeout" :void
	(timer :int)
	(frequency :int))

(defcfun "virEventRemoveTimeout" :int
	(timer :int))
