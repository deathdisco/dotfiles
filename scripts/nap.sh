#!/bin/env
echo 'disabling caffeine...'
sleep-disable.sh 0
echo 'stopping bluetooth...'
sudo service bluetooth stop
echo 'sleeping...'
systemctl suspend
