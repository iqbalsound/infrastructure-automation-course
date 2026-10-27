#!/usr/bin/env bash
THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "WARNING: disk usage at ${USAGE}%"
else
  echo "OK: disk usage at ${USAGE}%"
fi
