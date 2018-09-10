#!/bin/bash
src="/root/cluster_check"
dest="/root/xj"
ansible -i hosts all -m copy -a "src=$src/scripts/xj.py dest=$dest/xj.py"