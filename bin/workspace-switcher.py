#!/usr/bin/python
# -*- coding: utf8 -*-

help = """Workspace switcher
 
Usage:
  workspace-switcher.py right
  workspace-switcher.py left
 
Options:
  -h --help          Affiche l'aide.
 
Trop cool !
"""

from envoy import run
from docopt import docopt

arguments = docopt(help)

total_ws = int(run('gconftool-2 --get /apps/metacity/general/num_workspaces').std_out)
current_ws = int(run('wmctrl -d | grep \* | cut -d " " -f 1').std_out)

command = ""

if arguments['left']:
    if(current_ws > 0):
        command = 'wmctrl -s {}'.format(current_ws - 1)
elif arguments['right']:
    if(current_ws < total_ws):
        command = 'wmctrl -s {}'.format(current_ws + 1)

run(command)
