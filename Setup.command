#!/bin/sh

cd "$(dirname "$0")"

#generation
xcodegen generate

#pods
pod deintegrate
pod install

#resorces
cd "Modules/Resources/Resources"
swiftgen config lint
swiftgen 

