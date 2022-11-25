#!/usr/bin/env sh

PACKAGES="ncurses-base
ncurses-doc
ncurses-hexedit   
ncurses-bin
ncurses-examples
ncurses-term"

DESTINATION="$(dirname "$0")/../ncurses/"

get_source() {
	echo "$PACKAGES" | while read -r package; do
		apt-file list "$package" | grep -Eo "/usr/share/man/.*"
	done
}

# Copy files to source
get_source | while read -r line; do
	unset CATEGORY
	CATEGORY="$(basename "$(dirname "$line")")"
	mkdir -p "$DESTINATION/$CATEGORY"
	cp "$line" "$DESTINATION/$CATEGORY"
done
