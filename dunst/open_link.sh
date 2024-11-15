#!/bin/bash

# Add the following to the end of the dunstrc to activate

# [open_link]
#	appname = Brave
#	urgency = normal
#	script = "/home/marco/.config/dunst/open_link.sh"

logger "dunst" "starting open_link.sh"
logger "dunst" "DUNST_APP_NAME: $DUNST_APP_NAME"
logger "dunst" "DUNST_SUMMARY: $DUNST_SUMMARY"
logger "dunst" "DUNST_BODY:$DUNST_BODY"
logger "dunst" "DUNST_URGENCY: $DUNST_URGENCY"
logger "dunst" "DUNST_URLS: $DUNST_URLS"
logger "dunst" "DUNST_DESKTOP_ENTRY: $DUNST_DESKTOP_ENTRY"

key=$(echo $DUNST_URLS | sed -rn 's/\[(.*)\].*/\1/p')
link=$(echo $DUNST_URLS | sed -rn 's/.*(https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)).*/\1/p')

logger "dunst" "key: $key"
logger "dunst" "link: $link"

exclusions=("app.slack.com" "calendar.google.com" "equalexperts.blogin.co")
if [[ "${exclusions[*]}" =~ "$key" ]]; then
	logger "dunst" "Exclusion rule for $key found, not opening $link"
else
	logger "dunst" "Opening link for $key: $link"
	flatpak run com.brave.Browser "$link" &> /dev/null
fi

