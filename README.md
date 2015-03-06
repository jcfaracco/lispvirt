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
  * cl-asdf
  * cl-launch

For libvirt
  * libvirt (>= 1.2)


Install
-----------------------------

To install Lispvirt into the correct place, use the commands provided by Makefile.

    $ sudo make install

If you decided to clean Lispvirt from the system, there is a clean option to do it.

    $ sudo make clean

The install process will add the libraries into the directory used by Common Lisp to load its modules using [cl-asdf](https://common-lisp.net/project/asdf/).

