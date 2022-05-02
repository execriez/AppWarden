# AppWarden
![Logo](images/AppWarden.jpg "Logo")

Run custom code when a Mac OS app is launched or terminated.

## Description:

AppWarden catches MacOS application launch events, to allow you to run custom code when an application launches or quits.

AppWarden consists of the following components:

	AppWarden              - The main binary that catches the Application Notification events
	AppWarden-WillLaunch   - Called as an application is loading
	AppWarden-DidLaunch    - Called when an application has fully loaded
	AppWarden-DidTerminate - Called when an application quits
 
AppWarden-WillLaunch, AppWarden-DidLaunch and AppWarden-DidTerminate are bash scripts.

The example scripts simply write to a log file in ~/Library/Logs. You should customise the scripts to your own needs.


## How to install:

Open the Terminal app, and download the latest [AppWarden.pkg](https://raw.githubusercontent.com/execriez/AppWarden/master/SupportFiles/AppWarden.pkg) installer to your desktop by typing the following command. 

	curl -k --silent --retry 3 --retry-max-time 6 --fail https://raw.githubusercontent.com/execriez/AppWarden/master/SupportFiles/AppWarden.pkg

To install, double-click the downloaded package.

The installer will install the following files and directories:

	/Library/LaunchAgents/com.github.execriez.appwarden.plist
	/usr/AppWarden/
	/usr/AppWarden/bin/
	/usr/AppWarden/bin/AppWarden
	/usr/AppWarden/bin/AppWarden-WillLaunch
	/usr/AppWarden/bin/AppWarden-DidLaunch
	/usr/AppWarden/bin/AppWarden-DidTerminate

There's no need to reboot.

After installation, your computer will write to the log file ~/Library/Logs/AppWarden.log whenever an application launches or quits. 

If the installer fails you should check the installation logs.

## Modifying the example scripts:

After installation, three simple example scripts can be found in the following location:

	/usr/AppWarden/bin/AppWarden-WillLaunch
	/usr/AppWarden/bin/AppWarden-DidLaunch
	/usr/AppWarden/bin/AppWarden-DidTerminate

These scripts simply write to the log file ~/Library/Logs/AppWarden.log whenever the ConsoleUser changes. Modify the scripts to your own needs.

**AppWarden-WillLaunch**

	#!/bin/bash
	#
	# Called by AppWarden as user like this:
	#   AppWarden-WillLaunch "WillLaunch:Epoch:ApplicationBundleIdentifier:ApplicationName:ApplicationPath:ApplicationProcessIdentifier"
	# i.e.
	#   AppWarden-WillLaunch "WillLaunch:1538162675:com.apple.TextEdit:TextEdit:/Applications/TextEdit.app:15061"
	
	# Get application name e.g. TextEdit
	sv_ThisAppName="$(echo ${1} | cut -d":" -f4)"
	
	# Do something
	echo "$(date '+%d %b %Y %H:%M:%S %Z') WillLaunch - '${sv_ThisAppName}' will launch" >> ~/Library/Logs/AppWarden.log

**AppWarden-DidLaunch**

	#!/bin/bash
	#
	# Called by AppWarden as user like this:
	#   AppWarden-DidLaunch "DidLaunch:Epoch:ApplicationBundleIdentifier:ApplicationName:ApplicationPath:ApplicationProcessIdentifier"
	
	# Get application name e.g. TextEdit
	sv_ThisAppName="$(echo ${1} | cut -d":" -f4)"
	
	# Do something
	echo "$(date '+%d %b %Y %H:%M:%S %Z') DidLaunch - '${sv_ThisAppName}' did launch" >> ~/Library/Logs/AppWarden.log

**AppWarden-DidTerminate**

	#!/bin/bash
	#
	# Called by AppWarden as user like this:
	#   AppWarden-DidTerminate "DidLaunch:Epoch:ApplicationBundleIdentifier:ApplicationName:ApplicationPath:ApplicationProcessIdentifier"
	
	# Get application name e.g. TextEdit
	sv_ThisAppName="$(echo ${1} | cut -d":" -f4)"
	
	# Do something
	echo "$(date '+%d %b %Y %H:%M:%S %Z') DidTerminate - '${sv_ThisAppName}' did quit" >> ~/Library/Logs/AppWarden.log


## How to uninstall:

Open the Terminal app, and download the latest [AppWarden-Uninstaller.pkg](https://raw.githubusercontent.com/execriez/AppWarden/master/SupportFiles/AppWarden-Uninstaller.pkg) uninstaller to your desktop by typing the following command. 

	curl -k --silent --retry 3 --retry-max-time 6 --fail https://raw.githubusercontent.com/execriez/AppWarden/master/SupportFiles/AppWarden-Uninstaller.pkg --output ~/Desktop/ConsoleUserWarden-Uninstaller.pkg

To uninstall, double-click the downloaded package.

The uninstaller will remove the following files and directories:

	/Library/LaunchAgents/com.github.execriez.appwarden.plist
	/usr/AppWarden/

After the uninstall everything goes back to normal, and application launches will not be tracked.

There's no need to reboot.

## Logs:

The example scripts write to the following log file:

	~/Library/Logs/AppWarden.log

The installer writes to the following log file:

	/Library/Logs/com.github.execriez.appwarden.log
  
You should check this log if there are issues when installing.

## History:

1.0.12 - 02 MAY 2022

* Compiled as a fat binary to support both Apple Silicon and Intel Chipsets. This version requires MacOS 10.9 or later.

* The example scripts now just write to a log file. Previously they made use of the "say" command.

* The package creation and installation code has been aligned with other "Warden" projects.

1.0.11 - 07 OCT 2018

* Changed from a LaunchDaemon to a LaunchAgent, so that it runs as the user that launched the APP, rather than as root.

1.0.10 - 29 SEP 2018

* Application launch events no longer wait for earlier events to finish before running. Events can now be running simultaneously.

* The example scripts have been simplified, and the readme has been improved.

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
* 