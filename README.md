## Bash-5.2.15
A  mac Installer package for Bash 5.2.15 release

[Download](https://github.com/LAbyOne/Bash-5.2/releases)

##
This script simply automates the process of downloading, building, and packaging bash for macOS.

The resulting package installer will install bash in /usr/local/bin and the supporting files in /usr/local.

This script will change the name of the bash binary installed in /usr/local/bin/ to bash5 to avoid 
any naming conflicts with the built-in bash v3 in /bin. 
This also allows you to have different builds installed on the same system.

The postinstall script add a symbolic link, so you basically can set 
`#!/usr/bin/env bash`
interpreter argument to your scripts, and won't have to specify 
`#!/usr/local/bin/bash5`

Eventually you want probably make it the default interpreter argument,
by typing this in your terminal `chsh -s /usr/local/bin/bash5`

The path to the bash binary will be added to /etc/shells on the target system,
so that users can use chsh to switch their default shell.

##
Thanks to Armin Briegel for suggestions
