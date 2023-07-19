#!/bin/bash

NEW_BUILD_VERSION=$1
REGISTRY=$2
REPO=$3

# Usage info
if [ -z "$NEW_BUILD_VERSION" ] || [ -z "$REGISTRY" ] || [ -z "$REPO" ]; then
    echo "Usage: $0 <new_build_version> <registry> <repo>"
    exit 1
fi

IMAGE_BASE_PATH="$REGISTRY/$REPO"

# --- Example ---
# greps this line:
# image: "roarv2euaci.azurecr.io/roarv2-survey-engine-api:latest"
# and returns 
# latest or whatever version we have after ":"
DEV_BUILD_VERSION=$(grep "$IMAGE_BASE_PATH:" deployment-dev.yaml | cut -d ':' -f3 | cut -d '"' -f1)
EU_BUILD_VERSION=$(grep "$IMAGE_BASE_PATH:" deployment-eu.yaml | cut -d ':' -f3 | cut -d '"' -f1)

IMAGE_PATH_DEV="$IMAGE_BASE_PATH:$DEV_BUILD_VERSION"
IMAGE_PATH_EU="$IMAGE_BASE_PATH:$EU_BUILD_VERSION"
IMAGE_PATH_NEW="image: $IMAGE_BASE_PATH:$NEW_BUILD_VERSION"

# Matches existing line containing image version
# then substitute it entirely with a new line containing the new version
# preserving whitespace indentation 
# "s@.*$IMAGE_PATH_xxx.*@$IMAGE_PATH_NEW@" -> main substitution using @ separator
# we used @ separator since / is a special character in a sed command
# (^\([[:blank:]]*\)) and \1 ->  do the whitespace trick
sed -i -e "s@^\([[:blank:]]*\).*$IMAGE_PATH_DEV.*@\1$IMAGE_PATH_NEW@" deployment-dev.yaml
sed -i -e "s@^\([[:blank:]]*\).*$IMAGE_PATH_EU.*@\1$IMAGE_PATH_NEW@" deployment-eu.yaml

echo "Done!"

exit 0
