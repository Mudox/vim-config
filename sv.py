#!/usr/bin/env python2
# encoding: utf-8

import subprocess
from glob import glob
from os import path

flag = False
for vimDir in ['.vim', 'vimfiles']:
    if path.exists(path.expanduser('~/%s' % vimDir)):
        configs_dir = path.expanduser('~/%s/chameleon/modes' % vimDir)
        cur_config = path.expanduser('~/%s/chameleon/cur_mode' % vimDir)
        if path.exists(configs_dir):
            flag = True

if not flag:
    print('* .vim/vimfiles path detection failed *')
    exit()

config_paths = glob(configs_dir + '/*')
config_names = [path.basename(x) for x in config_paths]
config_names = filter(lambda n: not n.startswith('sub_cfg_'), config_names)
config_names = filter(lambda n: not n.startswith('x_'), config_names)

menu_dict = {idx: name for idx, name in enumerate(sorted(config_names))}

print('-------- Vim Configuration Available --------')
for idx, name in menu_dict.items():
    print('[{0}] - {1}'.format(idx, name))

print('---------------------------------------------')

try:
    while 1:
        which = raw_input('your choice: ')
        try:
            which = int(which)
        except:
            for full_string in menu_dict.values():
                if which in full_string:
                    which = full_string
                    break  # break for

            if which in menu_dict.values():
                break  # break while 1
        else:
            if which in menu_dict:
                which = menu_dict[which]
                break  # break while 1
            else:
                print('invalid input!')
except Exception as e:  # got a EOF or Cancel key press.
    print('Oops ... ' + e)
else:
    with open(cur_config, 'w') as cc:
        cc.write(which)

    print('Switched to >> %s << !' % which)

    subprocess.Popen('gvim')
