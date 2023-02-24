#!/bin/sh

cd "$(dirname "$0")"
pod deintegrate
pod install

#generated
cd "Modules/Resources/Resources"
swiftgen config lint
swiftgen 

