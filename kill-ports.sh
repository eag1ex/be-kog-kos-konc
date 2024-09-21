#!/bin/bash
set -a

echo '<< Kill all ports >>'
## emulator ports 
yarn kill-port 5001 9090 9000 4200 9099 5000 8085 9199 9299 # busy port
# yarn kill-port 9090 # busy port
# yarn kill-port 9000 # busy port
# yarn kill-port 4200 # exit client proccess
# yarn kill-port 9099
# yarn kill-port 5000
# yarn kill-port 8085
# yarn kill-port 9199
# yarn kill-port 9299
echo '<< Kill all ports, done! >>'
set +a

