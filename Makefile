CLISP_DIR	:= /usr/share/common-lisp

install:
	@echo Installing Lispvirt.
	@cp -rf lispvirt/ ${CLISP_DIR}/source/
	@echo Linking libraries.
	@ln -sf ${CLISP_DIR}/source/lispvirt/lispvirt.asd ${CLISP_DIR}/systems/
	@echo Done!

clean:
	@echo Removing files from system.
	@rm -rf ${CLISP_DIR}/source/lispvirt/ ${CLISP_DIR}/systems/lispvirt.asd
	@echo Done!

install_tests:
	@echo Installing Lispvirt test module.
	@cp -rf tests ${CLISP_DIR}/source/lispvirt/
	@echo Linking test libraries.
	@ln -sf ${CLISP_DIR}/source/lispvirt/tests/lispvirt-tests.asd ${CLISP_DIR}/systems/
	@echo Done!



