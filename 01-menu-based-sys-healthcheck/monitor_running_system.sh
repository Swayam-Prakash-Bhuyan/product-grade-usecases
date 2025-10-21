#!/bin/bash
active_services=$(systemctl --type=service --state=active --no-pager --no-legend)
if [ -n "$active_services" ]; then
    echo "The following services are currently running:"
    echo "$active_services"
else
    echo "No active services found."
fi
