#!/bin/bash
zpool iostat -v 4 2 | gsed -n 'H; /capacity/h; ${g;p;}'
