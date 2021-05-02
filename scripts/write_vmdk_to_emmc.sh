#!/bin/bash
set -e

# This script will convert the local *.vmdk file to a raw disk dump.
# The raw disk dump will then be written back to the connected emmc.

DUMP_FILE_NAME="mib2_emmc_patched.dd"
VMDK_FILE_NAME="mib2_emmc.vmdk"

if [ $# -eq 0 ]
then
    SCRIPT_NAME=$(basename "$0")
    echo "Not all required arguments provided!"
    echo "Please provide the path to the device, where the vmdk should be written to"
    echo "Usage: ./${SCRIPT_NAME} /dev/sdb"
    exit 1
fi

echo "Start converting *.vmdk to disk dump..."
qemu-img convert -O raw ${VMDK_FILE_NAME} ${DUMP_FILE_NAME}

echo "Start writing the dump to the emmc..."
sudo dd if=${DUMP_FILE_NAME} of=${1} bs=1M status=progress conv=fdatasync

