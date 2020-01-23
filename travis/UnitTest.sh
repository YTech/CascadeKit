#!/bin/bash
set -e

echo "Running Unit Tests"
set -o pipefail && xcodebuild -project CascadeKit/CascadeKit.xcodeproj \
-scheme $CI_BUILD_TARGET \
-destination "platform=iOS Simulator,name=iPhone Xs,OS="$OS \
-allowProvisioningDeviceRegistration -allowProvisioningUpdates test | xcpretty -s --color --utf

echo " Unit Tests Passed for iPhone"
