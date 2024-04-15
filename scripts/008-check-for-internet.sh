#!/bin/bash

LOG "=========================================================";
LOG "===== Check for Internet connectivity"
LOG "=========================================================";

PING_HOST='google.com'

EXEC "/bin/ping -c 5 -q ${PING_HOST}"
LOG "\n\tPing to ${PING_HOST} is successful"
