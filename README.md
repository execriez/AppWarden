# AppWarden
Run custom code when an OSX app is launched or terminated.

##Description:

AppWarden catches OSX WillLaunch, DidLaunch and DidTerminate Application Notification events, to allow you to run custom code when an application launches or quits.

It consists of the following components:

	appwarden              - The main binary that catches the Application Notification events
	appwarden-WillLaunch   - Called as an application is loading
	appwarden-DidLaunch    - Called when an application has fully loaded
	appwarden-DidTerminate - Called when an application quits

The example appwarden-WillLaunch, appwarden-DidLaunch and appwarden-DidTerminate are bash scripts.

These example scripts simply use the "say" command to let you know when an App is launched or quit. You should customise these scripts to your own needs.


##How to install:

1. Download and unzip the software to a convenient location.
2. Double click the file "Install.command"
3. Reboot

##How to uninstall:

1. Delete the following files and folders

		/usr/local/AppWarden
		/Library/LaunchDaemons/com.github.execriez.AppWarden.Example.plist
	
2. Reboot

##History:

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
