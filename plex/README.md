After updating plex remember to go in and disable Plex Relay


docker exec -it plex /bin/bash

chmod -x /usr/lib/plexmediaserver/Plex\ Relay

ps -elf | grep Plex

kill -9 `pidof Plex\ Relay`
