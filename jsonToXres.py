#!/usr/bin/python
# -*- coding: utf8 -*-

import json
import sys

print("Enter JSON in terminal and finish with Ctrl-D\n")
raw_json = "\n".join(sys.stdin.readlines())
json = json.loads(raw_json)

print("\nResult to copy in ~/.Xresources\n")

if 'foreground' in json:
    print("#define fg    {}".format(json['foreground']))
if 'background' in json:
    print("#define bg    {}".format(json['background']))
if 'color' in json and len(json['color']) >= 16:
    print("#define col0  {}".format(json['color'][0]))
    print("#define col8  {}".format(json['color'][8]))

    print("#define col1  {}".format(json['color'][1]))
    print("#define col9  {}".format(json['color'][9]))

    print("#define col2  {}".format(json['color'][2]))
    print("#define col10 {}".format(json['color'][10]))

    print("#define col3  {}".format(json['color'][3]))
    print("#define col11 {}".format(json['color'][11]))

    print("#define col4  {}".format(json['color'][4]))
    print("#define col12 {}".format(json['color'][12]))

    print("#define col5  {}".format(json['color'][5]))
    print("#define col13 {}".format(json['color'][13]))

    print("#define col6  {}".format(json['color'][6]))
    print("#define col14 {}".format(json['color'][14]))

    print("#define col7  {}".format(json['color'][7]))
    print("#define col15 {}".format(json['color'][15]))
