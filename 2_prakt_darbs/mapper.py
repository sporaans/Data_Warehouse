#! /usr/bin/env python

import sys

#dt	webct_kods	komp_kods	usr	ip	apj

for place, line in enumerate(sys.stdin):
	if place != 0:
		line = line.strip()
		unpacked = line.split("\t")
		dt,webct_kods,komp_kods,usr,ip,apj = line.split("\t")
		results = [usr,dt, "1"]
		print("\t".join(results))