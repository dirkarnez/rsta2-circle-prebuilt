FROM armswdev/arm-tools:bare-metal-compilers

RUN sudo rm /var/lib/apt/lists/lock && \
	sudo apt-get update -y && \
	sudo apt-get upgrade -y && \
	sudo apt-get -y --no-install-recommends install \
	zip \
	unzip
   
RUN sudo mkdir -p /src/workspace

VOLUME /src/workspace

CMD cd /src/workspace && \
	git clone --recursive https://github.com/rsta2/circle.git && \ 
	cd circle && \
	git checkout Step45.1 && \
	./configure --raspberrypi 4 --realtime --prefix aarch64-none-elf- --multicore --c++17 && \
	./makeall clean && \
	./makeall && \
	zip --symlinks -r circle-step45.1.zip . && \
	exit
