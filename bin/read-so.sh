#!/bin/bash

watch -t -n 60 -c "rsstail -N -t -l -u 'http://stackoverflow.com/feeds/tag?tagnames=go&amp;sort=newest' -n 10 -1 | egrep -o 'http://stackoverflow\.com/questions/.*'"
