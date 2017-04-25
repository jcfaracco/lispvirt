Lispvirt
=============================
#### Common LISP bindings for Libvirt.

Lispvirt is a Common Lisp bindings for Libvirt which is a C library designed to provide tools and facilites for virtualization, independently of hypervisors and platforms.

This Lisp library is using [cl-cffi](https://common-lisp.net/project/cffi/) to access some methods of libvirt library.

Requirements
-----------------------------

Lispvirt has many requirements.

For Common Lisp:
  * slime
  * cl-cffi
  * cl-alexandria
  * cl-babel
  * cl-asdf
  * cl-launch

For libvirt
  * libvirt (>= 1.2)

For testing:
  * cl-xlunit

For examples:
  * cl-xmls


Installation
-----------------------------

To install Lispvirt into the correct place, use the commands provided by Makefile.

    $ sudo make install

If you decided to clean Lispvirt from the system, there is a clean option to do it.

    $ sudo make clean

The installation process will add the libraries into the directory used by Common Lisp to load its modules using [cl-asdf](https://common-lisp.net/project/asdf/).


Testing
-----------------------------

If you enable testing, you just need to load the module `lispvirt-tests`.

To load this module you need to install the test module. There is an option into Makefile to install the module.

    $ sudo make install_tests

There is an option inside Makefile to execute all test running a script instance and loading testing libraries.

    $ make test


Contact
-----------------------------

If you want to contribute with Lispvirt, please contact me: jcfaracco@gmail.com.

Any contribution would be very helpful to our project.


Authors
-----------------------------

lispvirt was written and is maintained by Julio C. Faracco and José Roberto B. de A. Monteiro.

Copyright (C) 2017 Julio C. Faracco
