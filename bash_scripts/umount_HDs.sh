#!/bin/bash
umount -tvR  /dev/sdb1  
umount -tvR /dev/sdb2  
umount -tvR /dev/sdb3  
umount -tvR /dev/sdb4  
umount -tvR /dev/sdc1  
umount -tvR /dev/sdc2  
umount -tvR /dev/sdc3  
mount -v
echo " All umounted OK ===> from /mnt/"