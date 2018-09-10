#!/bin/bash
number=100000
#1. zpool status
echo "xxxxxxxxxxxxxxxxxxxxxx1.CHECK DISKxxxxxxxxxxxxxxxxxxxxxxxx"
for i in {1..10}; do
	echo "=========xt$i DISK STATE READ WRITE CKSUM=========="
	ssh xt$i zpool status|grep "-"|grep -v raid|awk '{print $2}'|sort -u #STATE
	ssh xt$i zpool status|grep "-"|grep -v raid|awk '{print $3}'|sort -u #READ
	ssh xt$i zpool status|grep "-"|grep -v raid|awk '{print $4}'|sort -u #WRITE
	ssh xt$i zpool status|grep "-"|grep -v raid|awk '{print $5}'|sort -u #CKSUM
done
online 0 4 0


#2. memory
echo "xxxxxxxxxxxxxxxxxxxxxx2.CHECK MEMORY SWAPxxxxxxxxxxxxxxxxxxxxxxxx"
for i in {1..10};do
	echo "=========xt$i HOST MEMORY SWAP============="
	ssh xt$i "free -h"
done

#3 nfs.log
#/var/log/glusterfs/nfs.log
echo "xxxxxxxxxxxxxxxxxxxxxx3.CHECK NFS LOGxxxxxxxxxxxxxxxxxxxxxxxx"
for i in {1..10};do
	echo "DISCONN  xt$i"
	ssh xt$i  tail -n $number /var/log/glusterfs/nfs.log.1|grep DISCONN|grep -v nfs-server
	ssh xt$i  tail -n $number /var/log/glusterfs/nfs.log|grep DISCONN|grep -v nfs-server
	echo "disconnected from|Connected to"
	ssh xt$i tail -n $number  /var/log/glusterfs/nfs.log.1|grep -E 'disconnected from|Connected to'|grep -v nfs-server
	ssh xt$i tail -n $number  /var/log/glusterfs/nfs.log|grep -E 'disconnected from|Connected to'|grep -v nfs-server
	echo "call_bail"
	ssh xt$i tail -n $number  /var/log/glusterfs/nfs.log.1|grep call_bail
	ssh xt$i tail -n $number /var/log/glusterfs/nfs.log|grep call_bail
	echo " C "
	ssh xt$i tail -n $number /var/log/glusterfs/nfs.log.1|grep ' C '
	ssh xt$i tail -n $number /var/log/glusterfs/nfs.log|grep ' C '
	echo " E "
	ssh xt$i tail -n $number /var/log/glusterfs/nfs.log.1|grep ' E '|grep -v -E 'Stale file handle|No such file or directory|Permission denied|Disk quota exceeded'
	ssh xt$i tail -n $number /var/log/glusterfs/nfs.log|grep ' E '|grep -v -E 'Stale file handle|No such file or directory|Permission denied|Disk quota exceeded'
	echo
	echo
done

#4 coredump
echo "xxxxxxxxxxxxxxxxxxxxxx4.CHECK COREDUMPxxxxxxxxxxxxxxxxxxxxxxxx"
for i in {1..10}; do
	echo "==========xt$i COREDUMP=============="
	ssh xt$i ls /var/crash -l
done

echo "xxxxxxxxxxxxxxxxxxxxxx5.CHECK ZPOOL IOSTAT 1 3xxxxxxxxxxxxxxxxxxxxxxxx"
for i in {1..10}; do
	ssh xt$i zpool iostat 1 3
done

echo "xxxxxxxxxxxxxxxxxxxxxx6.CHECK GLUSTERFS PROCESS STSATUSxxxxxxxxxxxxxxxxxxxxxxxx"
for i in {1..10}; do
	echo "=========xt$i GLUSTER STATUS============="
	ssh xt$i ps aux|grep gluster|grep -v grep|awk '{print $8}'|sort -u
done
