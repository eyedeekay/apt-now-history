#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
SOURCEBIN=apt-git
SOURCEDOC=README.md
DEBFOLDER=apt-git
DEBVERSION=$(date +%Y%m%d)
CONTROL_FILE="Source: apt-git
Section: unknown
Priority: optional
Maintainer: idk <eyedeekay@i2pmail.org>
Build-Depends: debhelper (>= 9)
Standards-Version: 3.9.5
Homepage: https://cmotc.github.io/apt-git/
Vcs-Git: git@github.com:cmotc/apt-git.git
Vcs-Browser: https://github.com/cmotc/apt-git

Package: apt-git
Architecture: all
Depends: \${misc:Depends}, markdown, reprepro
Description: A tool for setting up and hosting an apt repository using arbitrary
 http/s hosts to make files accessible with extra features for git-enabled
 hosting sites.
 .
 This tool, currently called apt-git but soon to be changed to apt-now, then
 repo-git, then repo-now, is essentially a static site generator geared
 toward generating and formatting a specific type of content in a specific type
 of way, the content being GNU/Linux or Android/Linux binary packages, and the
 format being a signed repository accessible from the web or something like
 it  (It can also, for instance, be used to statically host software
 repositories over i2p with no substantial modification.) It does this by taking
 advantage of the structural regularity of these types of resources and
 constructs the whole site on the client side, transmitting content to the
 server only after a valid repository has been built. This means that the server
 doesn't have to run any code at all to present the site to the end-user taking
 advantage of the resource over the web, doesn't need to support ssh or remote
 desktop, and doesn't even technically need to support ftp or git, as long as a
 way of transferring the repository to the remote storage service can be
 included in the program.
 "
DEBFOLDERNAME="../$DEBFOLDER-$DEBVERSION"

cd $DEBFOLDER

# Create your scripts source dir
mkdir $DEBFOLDERNAME

# Copy your script to the source dir
cp $SOURCEBINPATH/$SOURCEBIN $DEBFOLDERNAME
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make -s --indep --createorig
echo "$CONTROL_FILE" > debian/control

# Remove make calls
grep -v makefile debian/rules > debian/rules.new
mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
echo $SOURCEBIN usr/bin > debian/install
#echo $SOURCEDOC usr/share/doc/apt-git >> debian/install

# Remove the example files
rm debian/*.ex

# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc > ../log
