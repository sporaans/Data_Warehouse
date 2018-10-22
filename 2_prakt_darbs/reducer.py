#! /usr/bin/env python

import sys

last_key = None
key_count = 0


for line in sys.stdin:

    line = line.strip()
    usr, dt, count = line.split("\t")
    key = usr+"\t"+dt
    count = int(count)
    # if this is the first iteration
    if not last_key:
        last_key = key

    # if they're the same, log it
    if key == last_key:
        key_count += count
    else: 
        result = [last_key, key_count]
        print("\t".join(str(v) for v in result))
        last_key = key
        key_count = 1

# this is to catch the final value that we output
print("\t".join(str(v) for v in [last_key, key_count]))