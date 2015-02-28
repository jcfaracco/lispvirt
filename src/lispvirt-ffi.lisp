(asdf:operate 'asdf:load-op :cffi)

(defpackage #:lispvirt-ffi
  (:use :cl :cffi))

(in-package :lispvirt-ffi)

(define-foreign-library libvirt
    (:darwin "libvirt.dylib")
    (:unix "libvirt.so")
    (t (:default "libvirt")))

(use-foreign-library libvirt)

(defctype size_t :unsigned-int)
