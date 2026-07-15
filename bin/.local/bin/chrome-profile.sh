#!/usr/bin/env bash

osascript \
  -e 'tell application "Google Chrome" to activate' \
  -e "tell application \"System Events\" to tell process \"Google Chrome\" to click menu item \"$1\" of menu 1 of menu bar item \"Profiles\" of menu bar 1"
