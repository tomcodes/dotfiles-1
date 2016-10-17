#!/usr/bin/python
# -*- coding: utf8 -*-

import argparse
import os
import shutil

parser = argparse.ArgumentParser(
    description='Link dotfiles'
)

parser.add_argument(
    '-t',
    '--only-terminal',
    action='store_true',
    help='Link only terminal based config'
)
args = parser.parse_args()


def echo(message, depth=0):
    print('{}> {}'.format('  ' * depth, message))


def rm(path):
    if os.path.islink(path):
        os.unlink(path)
    elif os.path.isdir(path):
        shutil.rmtree(path)
    elif os.path.isfile(path):
        os.remove(path)


def linkAllFiles(src_folder, dest_folder):
    for root, _, files in os.walk(src_folder):
        root = '/'.join(root.strip('/').split('/')[1:])
        for file in files:
            path = os.path.abspath(os.path.join(src_folder, root, file))
            link = os.path.join(dest_folder, root, file)
            rm(link)
            os.makedirs(os.path.dirname(link), exist_ok=True)
            echo(file, depth=1)
            os.symlink(path, link)


def linkFile(path, link):
    rm(link)
    echo(path, depth=1)
    os.symlink(os.path.abspath(path), link)


HOME = os.environ['HOME']
GUI = 'graphical'
CUI = 'terminal'

echo('Linking terminal config')
linkAllFiles(CUI, HOME)

echo('Linking sshrc.d')
linkFile(CUI, os.path.join(HOME, '.sshrc.d'))

if not args.only_terminal:
    echo('Linking graphical config')
    linkAllFiles(GUI, HOME)
