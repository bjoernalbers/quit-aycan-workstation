# quit-aycan-workstation

The current macOS installer package (.pkg) for
[aycan workstation](https://www.aycan.de/produkte/aycan-workstation.html)
is broken:
It does not quit the app before installation when the package gets
installed via Mobile Device Management (MDM).
(However, manual package installations are not affected.)

This script `quit-aycan-workstation` ensures that aycan workstation is stopped.
To do so the installer has to be patched to run the script (see below).

## Patching the installer

1. Download current installation package for aycan workstation
2. Clone this repository and `cd` into it
3. Create a patched installer:

    ```bash
    $ ./create-patched-installer ~/Downloads/aycan_workstation_4.00.006.pkg
    aycan_workstation_4.00.006-patched.pkg
    ```

4. Sign patched installer (which requires an Apple Developer Account):

    ```bash
    $ productsign --sign "Developer ID Installer: Your Name (0123456789)" \
        aycan_workstation_4.00.006-patched.pkg \
        aycan_workstation_4.00.006-patched-and-signed.pkg
    ```

5. Deploy patched & signed package with your MDM of choice
