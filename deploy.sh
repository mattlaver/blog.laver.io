#!/bin/bash

    ncftpput -R -v -u "$USERNAME" -p "$PASSWORD" "$HOST" / .
fi