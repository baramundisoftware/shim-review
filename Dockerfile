FROM ubuntu:18.04

RUN apt update -y \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get install -y \
	  make \
	  openssl \
	  gcc-4.8 \
	  bsdmainutils \
	  gnu-efi \
	  git

COPY ./ /shim-review/

WORKDIR /shim_source
RUN git clone https://github.com/baramundisoftware/shim.git	--branch baramundi-shim-08 . \
	&& git checkout f4c75aecb23f66ab789c5b59f16e0ef07302d99d

#build shim for x64 systems
WORKDIR /shim_x64
RUN LIB_PATH=/usr/lib64 \
	&& make -C /shim_source clean \
	&& make -C /shim_source shim.efi CC=gcc-4.8 ARCH=x86_64 EFI_PATH=/usr/lib DEFAULT_LOADER=bblefi-x64/grub2_x64.efi VENDOR_CERT_FILE=/shim-review/bsAG_EV_productive_2020.cer \
	&& cp /shim_source/shim.efi ./shim_x64.efi
	
#build shim for x86 systems
WORKDIR /shim_x86
RUN LIB_PATH=/usr/lib32 \
	&& make -C /shim_source clean \
	&& make -C /shim_source shim.efi CC=gcc-4.8 ARCH=ia32 EFI_PATH=/usr/lib32 DEFAULT_LOADER=bblefi-x86/grub2_x86.efi VENDOR_CERT_FILE=/shim-review/bsAG_EV_productive_2020.cer \
	&& cp /shim_source/shim.efi ./shim_x86.efi

WORKDIR /

# FIXME: This only works on x86-64 efi binary
RUN hexdump -Cv /shim-review/shim_x64.efi > orig_x64 && \
    hexdump -Cv /shim_x64/shim_x64.efi > build_x64 && \
    diff -u orig_x64 build_x64
	
RUN hexdump -Cv /shim-review/shim_x86.efi > orig_x86 && \
   hexdump -Cv /shim_x86/shim_x86.efi > build_x86 && \
   diff -u orig_x86 build_x86