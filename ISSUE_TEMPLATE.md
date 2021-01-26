Make sure you have provided the following information:

 - [X] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 https://github.com/baramundisoftware/shim-review
 - [x] completed README.md file with the necessary information
 https://github.com/baramundisoftware/shim-review/blob/master/README.md 
 - [x] shim.efi to be signed
 https://github.com/baramundisoftware/shim-review/blob/master/shim_x64.efi
 https://github.com/baramundisoftware/shim-review/blob/master/shim_x86.efi
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 https://github.com/baramundisoftware/shim-review/blob/master/bsAG_EV_productive_2020.cer
 - [x] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes whitelisted )
 No vendor_db is used
 - [x] any extra patches to shim via your own git tree or as files
 N/A
 - [x] any extra patches to grub via your own git tree or as files
 N/A
 - [x] build logs
 https://github.com/baramundisoftware/shim-review/blob/master/grub2_x64_build.log
 https://github.com/baramundisoftware/shim-review/blob/master/grub2_x86_build.log


###### What organization or people are asking to have this signed:
baramundi software AG

###### What product or service is this for:
baramundi Management Suite

###### What is the origin and full version number of your shim?
https://github.com/baramundisoftware/shim/tree/baramundi-shim-08

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
The SHIM bootloader starts a grub2 which decides if it should boot the local installed windows operating system or netboot a windows PE image.
This is necessary to support remote operating system installation on clients in the LAN.
With a signed SHIM bootloader we are able to support clients with enabled secure boot feature.

###### How do you manage and protect the keys used in your SHIM?
Private key is stored in hardware module with controlled access.

###### Do you use EV certificates as embedded certificates in the SHIM?
Yes

###### If you use new vendor_db functionality, are any hashes whitelisted, and if yes: for what binaries ?
No

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a linux kernel ?
No Linux kernel is used.

###### if SHIM is loading grub2 bootloader, is CVE CVE-2020-10713 fixed ?
- Yes
- The grub2 sources we use have it's origin in the commit https://git.launchpad.net/ubuntu/+source/grub2/tag/?h=applied/2.04-1ubuntu26.4

##### Did you change your certificate strategy, so that affected by CVE CVE-2020-10713 grub2 bootloaders can not be verified ?
- We used a new EV certificate which is only used for the new grub 2.04 which origin is the commit https://git.launchpad.net/ubuntu/+source/grub2/tag/?h=applied/2.04-1ubuntu26.4

###### What is the origin and full version number of your bootloader (GRUB or other)?
- grub 2.04
- The grub2 sources we use have it's origin in the commit https://git.launchpad.net/ubuntu/+source/grub2/tag/?h=applied/2.04-1ubuntu26.4

###### If your SHIM launches any other components, please provide further details on what is launched
Our shim only launches the mentioned grub 2.04

###### How do the launched components prevent execution of unauthenticated code?
- with standard grub 2.04 functionality, we prevent to start any unsigned bootloader

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
- No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
- We launch Windows and Windows PE loader and kernel

###### What changes were made since your SHIM was last signed?
This is the first submission

###### What is the hash of your final SHIM binary?
- shim_x64 MD5 hash: c0a928af63609a4c9ada8a297f027028
- shim_x86 MD5 hash: 537899f7377ff2486bd0527bd0418230