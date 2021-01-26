This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch
- approval is ready when you have accepted tag

Note that we really only have experience with using grub2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
baramundi software AG

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
baramundi Management Suite

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
The SHIM bootloader starts a grub2 which decides if it should boot the local installed windows operating system or netboot a windows PE image.
This is necessary to support remote operating system installation on clients in the LAN.
With a signed SHIM bootloader we are able to support clients with enabled secure boot feature.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name:
- Position:
- Email address:
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name:
- Position:
- Email address:
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/baramundisoftware/shim/releases/tag/0.8

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/baramundisoftware/shim/tree/baramundi-shim-08
Exact commit:
https://github.com/baramundisoftware/shim/commit/f4c75aecb23f66ab789c5b59f16e0ef07302d99d

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Some code that will not be used in our scenarios was removed:
- Removed MOK support
- Removed fallback support 

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2: is CVE-2020-10713 fixed ?
-------------------------------------------------------------------------------
- Yes
- The grub2 sources we use have it's origin in the commit https://git.launchpad.net/ubuntu/+source/grub2/tag/?h=applied/2.04-1ubuntu26.4

-------------------------------------------------------------------------------
If bootloader, shim loading is, grub2, and previous shims were trusting affected
by CVE-2020-10713 grub2:
* were old shims hashes provided to Microsoft for verification
  and to be added to future DBX update ?
* Does your new chain of trust disallow booting old, affected by CVE-2020-10713,
  grub2 builds ?
-------------------------------------------------------------------------------
Yes

-------------------------------------------------------------------------------
If your boot chain of trust includes linux kernel, is
"efi: Restrict efivar_ssdt_load when the kernel is locked down"
upstream commit 1957a85b0032a81e6482ca4aab883643b8dae06e applied ?
Is "ACPI: configfs: Disallow loading ACPI tables when locked down"
upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 applied ?
-------------------------------------------------------------------------------
No Linux kernel is used.

-------------------------------------------------------------------------------
If you use vendor_db functionality of providing multiple certificates and/or
hashes please briefly describe your certificate setup. If there are whitelisted hashes
please provide exact binaries for which hashes are created via file sharing service,
available in public with anonymous access for verification
-------------------------------------------------------------------------------
No vendor_db is used because of the removed MOK support. 
We only use the EV certificate which is provided in this repository.
The only binary signed with the provided EV certificate will be the grub2 efi binaries.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
If possible, provide a Dockerfile that rebuilds the shim.
-------------------------------------------------------------------------------
This information is provided in the Dockerfile of in this repository.
https://github.com/baramundisoftware/shim-review/blob/master/Dockerfile

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
- https://github.com/baramundisoftware/shim-review/blob/master/grub2_x64_build.log
- https://github.com/baramundisoftware/shim-review/blob/master/grub2_x86_build.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
- We submit our signing request to both the SHIM review board and through the Microsoft signing portal.
