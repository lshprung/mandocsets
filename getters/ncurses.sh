#!/usr/bin/env sh

PACKAGES="lib32ncurses-dev
lib32ncurses6
lib32ncursesw6
lib32tinfo6
lib64ncurses-dev
lib64ncurses6
lib64ncursesw6
lib64tinfo6
libncurses-dev
libncurses5
libncurses5-dev
libncurses6
libncursesw5
libncursesw5-dev
libncursesw6
libncursesw6-udeb
libtinfo-dev
libtinfo5
libtinfo6
libtinfo6-udeb
ncurses-base
ncurses-bin
ncurses-doc
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
	unset XCATEGORY
	CATEGORY="$(echo "$line" | grep -Eo "[0-9][^.]*\.gz$" | sed 's/\.gz$//')"

	# Check if the category is NX (e.g., 3ncurses -> 3X)
	if [ $(echo "$CATEGORY" | wc -m) -gt 2 ]; then
		XCATEGORY="$(echo "$CATEGORY" | cut -c -1)X"
	fi

	# Copy file, and rename if necessary
	if [ -n "$XCATEGORY" ]; then
		mkdir -p "$DESTINATION/man$XCATEGORY"
		cp "$line" "$DESTINATION/man$XCATEGORY/$(basename "$line" | sed "s/$CATEGORY/$XCATEGORY/")"
	else
		mkdir -p "$DESTINATION/man$CATEGORY"
		cp "$line" "$DESTINATION/man$CATEGORY"
	fi

done
