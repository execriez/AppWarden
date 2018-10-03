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

These example scripts use the "say" command to speak whenever an App is launched or quit. You should customise the scripts to your own needs.


## How to install:

Download the AppWarden installation package here [AppWarden.pkg](https://raw.githubusercontent.com/execriez/AppWarden/master/SupportFiles/AppWarden.pkg)

The installer will install the following files and directories:

	/Library/LaunchDaemons/com.github.execriez.appwarden.plist
	/usr/AppWarden/
	/usr/AppWarden/bin/
	/usr/AppWarden/bin/AppWarden
	/usr/AppWarden/bin/AppWarden-WillLaunch
	/usr/AppWarden/bin/AppWarden-DidLaunch
	/usr/AppWarden/bin/AppWarden-DidTerminate

There's no need to reboot.

After installation, your computer will speak whenever an application launches or quits. 

If the installer fails you should check the installation logs.

## Modifying the example scripts:

After installation, three simple example scripts can be found in the following location:

	/usr/AppWarden/bin/AppWarden-WillLaunch
	/usr/AppWarden/bin/AppWarden-DidLaunch
	/usr/AppWarden/bin/AppWarden-DidTerminate

These simple scripts are called as root, and use the "say" command to speak whenever an application launches or quits. Modify the scripts to alter this default behaviour.

**AppWarden-WillLaunch**

	#!/bin/bash
	#
	# Called as root like this:
	#   AppWarden-WillLaunch "WillLaunch:Epoch:ApplicationBundleIdentifier:ApplicationName:ApplicationPath:ApplicationProcessIdentifier"
	# i.e.
	#   AppWarden-WillLaunch "WillLaunch:1538162675:com.apple.TextEdit:TextEdit:/Applications/TextEdit.app:15061"

	# Get application name e.g. TextEdit
	sv_ThisAppName="$(echo ${1} | cut -d":" -f4)"

	# Do something
	say "${sv_ThisAppName} will launch."

**AppWarden-DidLaunch**

	#!/bin/bash
	#
	# Called as root like this:
	#   AppWarden-DidLaunch "DidLaunch:Epoch:ApplicationBundleIdentifier:ApplicationName:ApplicationPath:ApplicationProcessIdentifier"

	# Get application name e.g. TextEdit
	sv_ThisAppName="$(echo ${1} | cut -d":" -f4)"

	# Do something
	say "${sv_ThisAppName} did launch."

**AppWarden-DidTerminate**

	#!/bin/bash
	#
	# Called as root like this:
	#   AppWarden-DidTerminate "DidLaunch:Epoch:ApplicationBundleIdentifier:ApplicationName:ApplicationPath:ApplicationProcessIdentifier"

	# Get application name e.g. TextEdit
	sv_ThisAppName="$(echo ${1} | cut -d":" -f4)"

	# Do something
	say "${sv_ThisAppName} did quit."


## How to uninstall:

Download the AppWarden uninstaller package here [AppWarden-Uninstaller.pkg](https://raw.githubusercontent.com/execriez/AppWarden/master/SupportFiles/AppWarden-Uninstaller.pkg)

The uninstaller will remove the following files and directories:

	/Library/LaunchDaemons/com.github.execriez.appwarden.plist
	/usr/AppWarden/

After the uninstall everything goes back to normal, and application launches will not be tracked.

There's no need to reboot.

## Logs:

The AppWarden binary writes to the following log file:

	/var/log/systemlog
  
The following is an example of a typical system log file entry:

	Sep 28 19:33:43 mymac-01 AppWarden[11918]: Will launch: 'TextEdit'
	Sep 28 19:33:44 mymac-01 AppWarden[11918]: Did launch: 'TextEdit'
	Sep 28 19:33:47 mymac-01 AppWarden[11918]: Did terminate: 'TextEdit'


The installer writes to the following log file:

	/Library/Logs/com.github.execriez.appwarden.log
  
You should check this log if there are issues when installing.

## History:

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