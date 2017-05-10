#!/bin/sh
echo "Start script waiting for SIGTERM."
trap "echo Got SIGTERM. Goodbye!; exit" SIGTERM
tail -f /dev/null &
wait
