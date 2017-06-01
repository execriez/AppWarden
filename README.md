# AppWarden
![Logo](images/AppWarden.jpg "Logo")

Run custom code when a Mac OS app is launched or terminated.

## Description:

AppWarden catches Mac OS WillLaunch, DidLaunch and DidTerminate Application Notification events, to allow you to run custom code when an application launches or quits.

It consists of the following components:

	AppWarden              - The main binary that catches the Application Notification events
	AppWarden-WillLaunch   - Called as an application is loading
	AppWarden-DidLaunch    - Called when an application has fully loaded
	AppWarden-DidTerminate - Called when an application quits

The example AppWarden-WillLaunch, AppWarden-DidLaunch and AppWarden-DidTerminate are bash scripts.

These example scripts simply use the "say" command to let you know when an App is launched or quit. You should customise these scripts to your own needs.


## How to install:

Download the AppWarden zip archive from <https://github.com/execriez/AppWarden>, then unzip the archive on a Mac workstation.

Ideally, to install - you should double-click the following installer package which can be found in the "SupportFiles" directory.

	AppWarden.pkg
	
If the installer package isn't available, you can run the command-line installer which can be found in the "util" directory:

	sudo Install

The installer will install the following files and directories:

	/Library/LaunchDaemons/com.github.execriez.appwarden.plist
	/usr/AppWarden/

There's no need to reboot.

After installation, your computer will speak whenever the primary network status changes.

You can alter the example shell scripts to alter this behavior, these can be found in the following location:

	/usr/AppWarden/bin/AppWarden-DidLaunch
	/usr/AppWarden/bin/AppWarden-DidTerminate
	/usr/AppWarden/bin/AppWarden-WillLaunch

If the installer fails you should check the logs.

## Logs

Logs are written to the following file:

	/Library/Logs/com.github.execriez.appwarden.log

## How to uninstall:

To uninstall you should double-click the following uninstaller package which can be found in the "SupportFiles" directory.

	AppWarden-Uninstaller.pkg
	
If the uninstaller package isn't available, you can uninstall from a shell by typing the following:

	sudo /usr/local/AppWarden/util/Uninstall

The uninstaller will uninstall the following files and directories:

	/Library/LaunchDaemons/com.github.execriez.appwarden.plist
	/usr/AppWarden/

There's no need to reboot.

After the uninstall everything goes back to normal, and application launches will not be tracked.

## History:

1.0.9 - 01 JUN 2017

* Recompiled to be backward compatible with MacOS 10.7 and later

1.0.8 - 23 MAY 2017

* Updated the installer to be more in line with my other projects

* Example scripts now write to a log file

1.0.7 - 04 OCT 2016

* Added install.command - I forgot to include it in the last update.

1.0.6 - 21 MAY 2016

* Changed installation location to /usr/local/AppWarden 
* Simplified example scripts
* Moved to GitHub

1.0.4 to 1.0.5

* Changes relating to the example scripts that are no-longer relevant.

1.0.3 - 02 SEP 2015

* First public release.
  Tidied up the code (a little) so I could release it to the wild.
  Renamed to AppWarden from appwatch/appwatcher

1.0.0 - 31 MAR 2009

* Created as the basis for an application auditing system that I never got round to writing.
