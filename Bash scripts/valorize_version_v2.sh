#!/bin/bash

NEW_BUILD_VERSION=$1
REGISTRY=$2
REPO=$3
shift
shift
shift
FILES=$@

if [ -z "$FILES" ]; then
    FILES=("deployment-dev.yaml" "deployment-eu.yaml")
    echo "setting up default files: ${FILES[@]}"
fi

# Usage infos
if [ -z "$NEW_BUILD_VERSION" ] || [ -z "$REGISTRY" ] || [ -z "$REPO" ]; then
    echo "Usage: $0 <new_build_version> <registry> <repo> (files..)"
    exit 1
fi

IMAGE_BASE_PATH="$REGISTRY/$REPO"

get_version() {
    file="${1}"
    # --- Example ---
    # greps this line:
    # image: "roarv2euaci.azurecr.io/roarv2-survey-engine-api:latest"
    # and returns 
    # latest or whatever version we have after ":"
    current_version=$(grep "$IMAGE_BASE_PATH:" $file | cut -d ':' -f3 | cut -d '"' -f1)
}

set_version() {
    old="$IMAGE_BASE_PATH:${1}"
    new="image: $IMAGE_BASE_PATH:${2}"
    file="${3}"
    # Matches existing line containing image version
    # then substitute it entirely with a new line containing the new version
    # preserving whitespace indentation 
    # "s@.*$IMAGE_PATH_xxx.*@$IMAGE_PATH_NEW@" -> main substitution using @ separator
    # we used @ separator since / is a special character in a sed command
    # (^\([[:blank:]]*\)) and \1 ->  do the whitespace trick
    sed -i -e "s@^\([[:blank:]]*\).*$old.*@\1$new@" $file
}

for file in "${FILES[@]}";
    do
        echo "Valorizing $file"
        current_version="unknown"
        get_version $file
        echo "Current version is $current_version"
        set_version $current_version $NEW_BUILD_VERSION $file
        echo "New version set is $NEW_BUILD_VERSION"
    done

echo "Done!"

exit 0
