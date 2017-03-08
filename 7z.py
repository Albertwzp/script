#! /bin/env python
#coding=utf-8
data = open('data.txt')
out = open('out', 'a')
while True:
	d = data.read(8)
	if len(d) != 8:
		break
	out.write(chr(eval("0b%s" % d)))
data.close()
out.close()
