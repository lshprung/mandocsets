#!/usr/bin/env sh

SOURCE="$(apt-file list ncurses-doc | grep -Eo "/usr/share/man/.*")"
DESTINATION="$(dirname "$0")/../ncurses/"

# Copy files to source
echo "$SOURCE" | while read -r line; do
	unset CATEGORY
	CATEGORY="$(basename "$(dirname "$line")")"
	mkdir -p "$DESTINATION/$CATEGORY"
	cp "$line" "$DESTINATION/$CATEGORY"
done
