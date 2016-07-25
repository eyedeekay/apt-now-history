#what is apt-now

Formerly called apt-git, apt-now is a static site generator which emits a
Debian repository which can be transferred to basically any http/s or similar
site, including things like Tor Hidden Services and i2p eepsites, but also
static hosting sites like github pages(You can even start by forking an
existing repository and cloning it, in the same vein as jekyll-now's fork-first
workflow). Right now it's default mode of operation is to assume that you are
using git to manage the uploading and downloading of files. The plan is to
eventually include many more ways of transferring the data.
Oh, it's also pretty much all shell scripts and programs you should already
have installed. If you don't use markdown, start. It's great.

##How do I use apt-now

Bear with me while I write the manuals, but it shouldn't take long, because as
you're about to see, it's really simple. First, you need to get a copy of the
system. You can do this by forking the apt-now repository and cloning it.

        git clone https://github.com/$YOUR_FORK/apt-git

BUT you'll still have the apt-now repository's public key in your copy if you
do it this way. No biggie, though just delete cmotc.github.io.gpg.key from your
copy and apt-now will automatically generate a new key for you next time you
use it.
apt-now also host's itself the site at https://cmotc.github.io/apt-now/ is a
live copy of the repository hosting apt-now and pkpage(A script which generates
pages for each of the packages hosted in your apt-now instance) and so is every
fork of that repository and the clone on your computer. So if you create a file
like /etc/apt/sources.list.d/apt-now.list with the contents

        deb https://cmotc.github.io/apt-git/debian rolling main

and tell your Package Manager to trust my key by running this command

        wget -qO - https://cmotc.github.io/apt-git/cmotc.github.io.gpg.key | sudo apt-key add -

then you'll be able to run the following commands

        sudo apt-get install apt-transport-https
        sudo apt-get update
        sudo apt-get install apt-now pkpage

and have a copy of apt-now installed on your system, managed by your package
manager, from a repository created by apt-now! Which is kinda cool. Now
unfortunately it's not totally zero-configuration yet. I'm working on it, some
things need to be a little bit better organized first to generate the
configuration file for you. But apt-now is intended to be pretty flexible to
configure, and you can do it by passing parameters to the program, or setting
environment variables, or by creating a configuration file which loads those
environment variables called aptgit.conf.

###Environment Variables

The basis for all the configuration is a group of environment variables which
are read by the program. You can set them in your shell, via a config file, or
as parameters.

* CURDIR= By default, apt-now will run from the directory where it's invoked.
  If you want to change where it runs by default, you can set the CURDIR
  environment variable.

  o example: "$HOME/Projects/apt-git"

* ORIGIN= This is the URL of the site where you'll be hosting your repository.
  It's used to generate the instructions for adding the repository to your
  sources.list that will be automatically added to your home page. If left
  blank, you'll need to modify your home page manually to add it or rely on
  people figuring it out. IT IS ONLY used to generate these instructions. If
  you don't care about the presence of the instructions, the repository will
  still be usable.

  o example: "user.github.io"

* REPONAME= This is the name you want to use for your repository. It will be
  used to generate the headline for your repository's home page. It's not the
  end of the world if it's left blank.

  o example: "apt-now"

* REPODESC= This is the long description of the repository which will be used
  generate the body of the repository home page. It can be left blank, too,
  with basically no consequences.

  o example: "Repository for apt-now, a system for setting up apt repositories
    on static hosts."

* CODENAME= This can be any value you like, but I personally like to use either
  testing, rolling, or unstable. It corresponds to the branch of the repository
  where the packages will be made available.

  o example: "testing"

* REPOARCH= This is a whitespace-separated list of the architectures that your
  packages are intended to support.

  o example: "amd64 i386"

* POLICY= This corresponds to the policy of the packages in the repository.
  Officially, it can be main, contrib, or non-free but Ubuntu calls them
  different things so it may be possible to assign them arbitrarily. Just don't
  use "main" unless you're sure that your software is Free-as-in-Freedom.

  o example: "main" "main contrib" "universe"

* KEY= This is the ID of the key you want to use to sign the packages. If you
  have a GPG key you want to use to sign the packages, you can set it here, or
  if you create a new key with apt-now you will be prompted to enter it
  interactively.

  o example: "554DB437"

* START_HTTPD= This starts a static httpd in the repository directory, serving
  the http server on port 45291(which spells "debia" and makes it accessible on
  the LAN, or I guess mesh too, or whatever.

  o example: "YES"

* LOCAL\_ONLY\_HTTPD= This runs in combination with START_HTTPD to make sure
  the httpd listens only on the local interfaces. This is intended to be used
  when hosting on hidden services and when server anonymity is as important as
  user anonymity.

  o example: "YES"

* OVERRIDE= This is the override settings for the repository. You probably
  won't need to change this setting.

  o example: "override.testing"

* USE_TOR= When set, this will attempt to set up a Tor Hidden Service using the
  directory /var/lib/tor/apt-now for configuration. To discover the hostname
  of your hidden service, do 'sudo cat /var/lib/tor/apt-now/hostname'

  o example: "YES"

* USE_I2P= When set, this will attempt to set up an i2p eepSite using a
  daemonized instance of i2p on Debian by modifying
  /var/lib/i2p/i2p-config/eepsite/contexts/base-context.xml
  to point to the apt-now directory. Your apt-now address will then be the
  same as the address of your default published eepSite.

  o example: "YES"

###aptgit.conf is just a shell script

These environment variables can also be set in a configuration file at the base
of your repository called aptgit.conf. This is an example aptgit.conf file for
the default apt-now repository.

        #! /bin/sh
        #CURDIR=""
        ORIGIN="cmotc.github.io"
        REPONAME="apt-now"
        REPODESC="Repository for apt-now, a system for setting up apt
        repositories on static hosts."
        CODENAME="rolling"
        REPOARCH="amd64 i386 armhf"
        POLICY="main"
        KEY="554DB437"
        OVERRIDE="override.testing"
        START_HTTPD=YES
        LOCAL_ONLY_HTTPD=YES
        USE_TOR=YES
        USE_I2P=YES


###Passing Parameters, I hope you hate this way.

You can also set all the variables by passing them as parameters to the apt-now
program. This is all available in the output of apt-now --help. Personally, I
think this is by far the least convenient way of using it. Most of these don't
need to be passed at all after an interactive run unless you want to change
something though. I'll try to improve how this soon.

        -d \ --directory
              Work in this directory, uses current directory by default
        -o \ --origin
              URL of the repository
        -c \ --codename
              Codename you want to use, defaults is \"testing\"
        -a \ --arch
              Architecture you want to host, defaults to \"all\"
        -p \ --policy
              Policy of packages you want to host, defaults to \"main\"
        -k \ --key
              ID of the package signing key
        -s \ --sources
              Folder with the packages to include in the repo
        -q \ --override
              Name of the override file
        -m \ --message
              Message to include in the commit
        -n \ --name
              Human-readable name of the Repository
        -v \ --desc
              Detailed repository description
        -c \ --check
              Make sure the dependencies are installed
        -r \ --reset
              Re-generate all components of the repository
        -u \ --user \ --org \ --organization
              Us as user/organization page, post page to master branch
        -l \ --serve
                Serve with a local, static httpd on port 45291(debia).
        -f \ --hide
                Make local httpd only accessible by localhost.
        -t \ --tor
                Serve local httpd with Tor Hidden Service.
        -i \ --i2p
                Point i2p eepSite at apt-now directory.
        -h \ --help
              Display this help message

