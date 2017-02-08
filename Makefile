
PREFIX = "/"

dummy:
	echo "This is here to keep me from breaking something while I switch"
	echo "To using a makefile for this"

install:
	cp apt-now ${PREFIX}usr/bin
	cp README.md ${PREFIX}usr/share/doc/apt-now
	cp apt-now.conf.example ${PREFIX}usr/share/doc/apt-now
	cp index.html.1 ${PREFIX}usr/share/doc/apt-now
	cp usage.md ${PREFIX}usr/share/doc/apt-now
	cp USAGE.html ${PREFIX}usr/share/doc/apt-now
	cp LICENSE ${PREFIX}usr/share/doc/apt-now

deb-pkg:
