apt-git
-------
A tool for setting up and hosting an apt repository using arbitrary http/s hosts to
make files accessible with extra features for git-enabled hosting sites.

This tool, currently called apt-git but soon to be changed to apt-now, then repo-git,
then repo-now, is essentially a static site generator geared toward generating and
formatting a specific type of content in a specific type of way, the content being
GNU/Linux or Android/Linux binary packages, and the format being a signed repository
accessible from the web or something like it(It can also, for instance, be used to
statically host software repositories over i2p with no substantial modification.) It
does this by taking advantage of the structural regularity of these types of resources
and constructs the whole site on the client side, transmitting content to the server
only after a valid repository has been built. This means that the server doesn't have
to run any code at all to present the site to the end-user taking advantage of the
resource over the web, doesn't need to support ssh or remote desktop, and doesn't even
technically need to support ftp or git, as long as a way of transferring the
repository to the remote storage service can be included in the program.

Use Cases
---------

Versioning and Features
-----------------------
Right now, binary repository generation for Debian(APT Repositories) is stable and
source repository generation for Debian/Apt is nearing stability and are in usuable
form. While these are the only working types of repositories, the pre-hyphenate part
of this project's name will be "apt." Additionally, while an end user could use any
means to transfer the repository constructed by the apt-git tool, there is currently
only support for the use of github-pages as a hosting medium in the code. While this
remains the case the post-hyphenate part of this project's name will be "git." When
experimental support for F-Droid and Redhat(Yellowdog Updater) are complete,
additional ways of transferring the files will be considered and added, and the final
version will implement APT, YUM, and F-Droid repositories in an easy to configure,
polyglot(But probably not agnostic) way.

###Repository Types
  * Debian/APT
    - Binary Repository(Complete, Stable)
    - Source Repository(Final stages, Unstable)
    - Notes: Depends on normal debian tools, including reprepro
  * Android/F-Droid
    - Binary Repository(Experimental, Unstable, broken, see fdroid-git)
    - Source Repository(Research phases)
    - Notes: Android implies somewhat different separation of logic from GNU/Linux
  * Redhat/YUM
    - Binary Repository(Experimental, Still researching)
    - Source Repository(Experimental, Still researching)
    - Notes: None yet. But I'm sure there's something.

Related Projects
----------------
[Reprepro, obviously](http://mirrorer.alioth.debian.org/)
[Effing Package Management](https://github.com/jordansissel/fpm) - Some packages
depend on this, but it isn't in may repo's besides the ruby gems, somewhat ironically.


apt-git personal repository tool
================================
This tool helps developers host their own applications by posting them to 
github pages for download.  

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
        -c \ --check
              Make sure the dependencies are installed
        -r \ --reset
              Re-generate all components of the repository
        -u \ --user \ --org \ --organization
              Us as user/organization page, post page to master branch
        -h \ --help 
              Display this help message

to add this repository to your Debian-based system:  

        echo "deb https://cmotc.github.io/apt-git/debian unstable main" | sudo tee /etc/apt/source.list.d/cmotc.github.io.list
        wget -qO - https://cmotc.github.io/apt-git/cmotc.github.io.gpg.key | sudo apt-key add -

apt-git to-do list
------------------

   * Break more functionality into smaller chunks. Right now the generate
   function is huge and duplicates a pretty sizable amount of code. Write a
   generic function for building according to script, then existing spec, then
   guessing. This will make supporting more package types and more package
   building tools and techniques easier.
