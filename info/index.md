Testing Repository
============
testing
------------
###amd64 i386
###main
###Example
###user.github.io
####Latest update: date


  * [apt-git_20160625-1_all.deb ](user.github.io/info/apt-git_20160625-1_all.deb.html) 

  * [pkpage_20160625-1_all.deb ](user.github.io/info/pkpage_20160625-1_all.deb.html) 

This repository was generated with [apt-git](https://cmotc.github.io/apt-git), a static site
generator which emits apt repositories

###to add this repository to your Debian-based system:

echo "deb https://user.github.io/apt-git/debian unstable main" | sudo tee /etc/apt/source.list.d/user.github.io.list

wget -q0 - https://user.github.io/apt-git/user.github.io.gpg.key | sudo apt-key add -


