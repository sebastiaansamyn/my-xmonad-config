#!/bin/bash
amixer sget Master | tail -1 | cut -f6,8 -d' '
