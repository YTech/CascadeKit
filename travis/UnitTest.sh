#!/bin/bash
set -e

echo "Running Unit Tests"
set -o pipefail && xcodebuild -workspace CascadeKit/CascadeKit.xcodeproj \
-scheme $CI_BUILD_TARGET \
-destination "platform=iOS Simulator,name=iPhone 11 Pro Max,OS="$OS \
-allowProvisioningDeviceRegistration -allowProvisioningUpdates test | xcpretty -s --color --utf

echo " Unit Tests Passed for iPhone"
