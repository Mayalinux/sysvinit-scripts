SHELL = /bin/sh
INSTALL = install
DESTDIR =
INIT_D_FILES = rcS local_fs hostname init-script.example

.PHONY: install

all:
	$(warning Nothing to make. Run "make install" to install sysvinit-scripts.)

install:
	# Create directories
	$(INSTALL) -m 775 -d $(DESTDIR)/{etc/init.d,lib/lsb}

	# Install files
	$(INSTALL) -m 775 $(INIT_D_FILES) $(DESTDIR)/etc/init.d/
	$(INSTALL) -m 755 init-functions $(DESTDIR)/lib/lsb/
