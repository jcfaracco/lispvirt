Lispvirt
=============================
#### Common LISP bindings for Libvirt.

Lispvirt is a Common Lisp bindings for Libvirt which is a C library designed to provide tools and facilites for virtualization, independently of hypervisors and platforms.

This Lisp library is using [cl-cffi](https://common-lisp.net/project/cffi/) to access some methods of libvirt library.

Requirements
-----------------------------

Lispvirt has many requirements.

For Lisp:
  * slime
  * cl-cffi
  * cl-alexandria
  * cl-babel

For libvirt
  * libvirt (>= 1.2)
