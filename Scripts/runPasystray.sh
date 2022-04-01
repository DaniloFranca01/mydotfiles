#! /bin/sh

APP_ID=$(pgrep pasystray)
if [ -n "${APP_ID}" ]; then
  kill -9 $APP_ID
fi
pasystray &
