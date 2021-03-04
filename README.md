# Bash-5.1
A  mac Installer package for Bash 5.1 release
##
This script simply automates the process of downloading, building, and packaging bash for macOS.

The resulting package installer will install bash in /usr/local/bin and the supporting files in /usr/local.

This script will change the name of the bash binary installed in /usr/local/bin/ to bash5 to avoid 
any naming conflicts with the built-in bash v3 in /bin. 
This also allows you to have different builds installed on the same system.

Eventually you can modify the postinstall script to add a symbolic link.

The path to the bash binary will be added to /etc/shells on the target system,
so that users can use chsh to switch their default shell.
# 
Direct Download :  
[Here](curl -Ls https://github.com/HelmoHass/Bash-5.1/raw/main/Bash-5-Installer-Builder.7z > Bash-5-Installer-Builder.7z)
# 
