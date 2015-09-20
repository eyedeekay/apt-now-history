# apt-git
A tool for setting up and hosting an apt repository using github pages to host.

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
