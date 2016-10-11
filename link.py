#!/usr/bin/python

import os
import shutil

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

echo('Linking home')
linkAllFiles('home', HOME) 

echo('Linking config')
linkAllFiles('config', os.path.join(HOME, '.config')) 

echo('Linking fonts')
linkAllFiles('fonts', os.path.join(HOME, '.fonts')) 

echo('Linking sshrc.d')
linkFile('home', os.path.join(HOME, '.sshrc.d'))
