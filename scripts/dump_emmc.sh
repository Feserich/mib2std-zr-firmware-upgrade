#!/bin/bash
set -e

# This script will create a local disk dump of the connected emmc.
# After the dump has finished, this script will convert it to a *.vmdk file.
# The vmdk file can be mounted in a QNX VM, to modify the files. 

DUMP_FILE_NAME="mib2_emmc_dump.dd"
VMDK_FILE_NAME="mib2_emmc.vmdk"

if [ $# -eq 0 ]
then
    SCRIPT_NAME=$(basename "$0")
    echo "Not all required arguments provided!"
    echo "Please provide the path to the device which shall be dumped"
    echo "Usage: ./${SCRIPT_NAME} /dev/sdb"
    exit 1
fi


# adapt the path to sd card reader device!
echo "Creating a disk dump..."
sudo dd if=${1} of=${DUMP_FILE_NAME} bs=1M status=progress

echo "Start converting disk dump to *.vmdk..."
qemu-img convert -O vmdk ${DUMP_FILE_NAME} ${VMDK_FILE_NAME}