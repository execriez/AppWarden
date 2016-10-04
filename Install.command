#!/bin/bash
#
# Short:    Install AppWarden from the command-line
# Author:   Mark J Swift
# Version:  1.0.7
# Modified: 04-Oct-2016
#
# Called as follows:    
#   Install.command

# ---

GLB_Tag="Example"

# Set the signature for the AppWarden installation
GLB_AppWardenSignature="com.github.execriez.AppWarden"

# Path to this script
GLB_MyDir="$(dirname "${0}")"

# Change working directory
cd "${GLB_MyDir}"

# Filename of this script
GLB_MyFilename="$(basename "${0}")"

# Filename without extension
GLB_MyName="$(echo ${GLB_MyFilename} | sed 's|\.[^.]*$||')"

# Full souce of this script
GLB_MySource="${0}"

# ---

# Get user name
GLB_UserName="$(whoami)"

# ---

# Check if user is an admin (returns "true" or "false")
if [ "$(dseditgroup -o checkmember -m "${GLB_UserName}" -n . admin | cut -d" " -f1)" = "yes" ]
then
  GLB_IsAdmin="true"
else
  GLB_IsAdmin="false"
fi

# ---

if [ "${GLB_IsAdmin}" = "false" ]
then
  echo "Sorry, you must be an admin to install this script."
  echo ""

else
  echo ""
  echo "Installing AppWarden."
  echo "If asked, enter the password for user '"${GLB_UserName}"'"
  echo ""
  
  sudo su root <<HEREDOC

  # Delete any unwanted files from the install
  find "${GLB_MyDir}" -iname .DS_Store -exec rm -f {} \;

  # Lets begin
  mkdir -p /usr/local/AppWarden
  chown root:wheel /usr/local/AppWarden
  chmod 755 /usr/local/AppWarden
  
  if test -f "${GLB_MyDir}/LICENSE"
  then
    cp "${GLB_MyDir}/LICENSE" /usr/local/AppWarden/
    chown root:wheel "/usr/local/AppWarden/LICENSE"
    chmod 755 "/usr/local/AppWarden/LICENSE"
  fi
  
  if test -f "${GLB_MyDir}/README.md"
  then
    cp "${GLB_MyDir}/README.md" /usr/local/AppWarden/
    chown root:wheel "/usr/local/AppWarden/README.md"
    chmod 755 "/usr/local/AppWarden/README.md"
  fi
  
  if test -d "${GLB_MyDir}/payload"
  then
    cp -pR "${GLB_MyDir}/payload/" "/usr/local/AppWarden/"
    chown -R root:wheel "/usr/local/AppWarden"
    chmod -R 755 "/usr/local/AppWarden"

    if test -f "/usr/local/AppWarden/appwarden"
    then
      cat << EOF > /Library/LaunchAgents/${GLB_AppWardenSignature}.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>${GLB_AppWardenSignature}</string>
	<key>Program</key>
	<string>/usr/local/AppWarden/appwarden</string>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<false/>
</dict>
</plist>
EOF
      chown root:wheel /Library/LaunchAgents/${GLB_AppWardenSignature}.plist
      chmod 644 /Library/LaunchAgents/${GLB_AppWardenSignature}.plist

    fi
  fi
    
  echo "PLEASE REBOOT."
  echo ""

HEREDOC

fi
