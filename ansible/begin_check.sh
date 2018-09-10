#!/bin/bash
my_date=`date "+%Y%m%d"`
log_name=$my_date"_xj.log"
ansible -i hosts all -m shell -a "python /root/xj/xj.py" > /var/log/xj_log/$log_name