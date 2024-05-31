Builds seadrive-gui for Ubuntu 24.04 via docker.

Steps:

1. Clone this repository into a folder.
2. Within that folder run `docker build --tag build-seadrive-gui .`.
3. Then run `docker run -v ./data:/data build-seadrive-gui`.
4. The resulting .deb packages will be in data/.
5. To install them on your system run `cd data && sudo dpkg -i *.deb` and then `sudo apt --fix-broken install`.
