# quit-aycan-workstation

The current installer package for
[aycan workstation](https://www.aycan.de/produkte/aycan-workstation.html)
is broken:
It does not quit the app before installation when the package gets
installed via Mobile Device Management (MDM).
(However, manual package installations are not affected.)

This script `quit-aycan-workstation` ensures that aycan workstation is stopped.
To do so the installer has to be patched to include this script.
