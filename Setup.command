#!/bin/sh

cd "$(dirname "$0")"

#generation
xcodegen generate

#pods
sh PodInstall.command

#resorces
cd "Modules/Resources/Resources"
swiftgen config lint
swiftgen 

