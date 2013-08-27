#!/bin/sh

QEMU=qemu-system-x86_64
IMG=$HOME/vm/win.qcow2
CAP=20G
MEM=4096

if [ ! -f $IMG ]; then
  if [ $# -eq 1 ]; then
    qemu-img create -f qcow2 $IMG $CAP
    exec $QEMU -enable-kvm -m $MEM -cdrom $1 -boot 
  else
    printf "Usage: %s <install.iso>\n" $0
    exit 64
  fi
fi

exec $QEMU -enable-kvm -m $MEM -vga std -full-screen $IMG
