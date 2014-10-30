SHELL=/bin/sh
INSTALL=install
LN=ln
DESTDIR=
LIBDIR=/lib
SYSCONFDIR=/etc
INIT_D_FILES=rcS local_fs hostname init-script.example

.PHONY: install test

all:
	$(warning Nothing to make. Run "make install" to install sysvinit-scripts.)

install:
	# Create directories
	$(INSTALL) -m 755 -d $(DESTDIR)/{$(SYSCONFDIR)/init.d,$(LIBDIR)/lsb}
	$(INSTALL) -m 755 -d $(DESTDIR)/$(SYSCONFDIR)/rc{0,1,2,3,4,5,6,S}.d

	# Install files
	$(INSTALL) -m 755 $(INIT_D_FILES) $(DESTDIR)$(SYSCONFDIR)/init.d/
	$(INSTALL) -m 755 init-functions $(DESTDIR)$(LIBDIR)/lsb/

	# Create symlinks
	for rlvl in 0 6; do \
		pushd $(DESTDIR)$(SYSCONFDIR)/rc$${rlvl}.d; \
		$(LN) -fs $(SYSCONFDIR)/init.d/local_fs K99local_fs; \
		popd; \
	done

	pushd $(DESTDIR)$(SYSCONFDIR)/rcS.d; \
	$(LN) -fs $(SYSCONFDIR)/init.d/local_fs S0local_fs; \
	$(LN) -fs $(SYSCONFDIR)/init.d/hostname S10hostname; \
	popd

test:
	test/testcase.sh
