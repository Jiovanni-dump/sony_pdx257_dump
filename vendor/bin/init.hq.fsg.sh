#!/vendor/bin/sh
# Copyright (c) 2018, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#

#cmdline=`cat /proc/cmdline`
#boardid=`echo ${cmdline##*pcb_board_id} | awk -F '[= ]' '{print $2}'`
pcbid=`cat /sys/bus/platform/drivers/HardwareInfo/HardwareInfo/modem_id`

echo "pcbid=$pcbid"
if [ ! -f /mnt/vendor/persist/flag/fsg_flag ];then
fsg_flag_path="/mnt/vendor/persist/flag/fsg_flag"
    case "$pcbid" in
        "N4(N/J)")
        if [ -f /vendor/etc/fsg/NJ_fs_image.tar.gz.mbn.img ]; then
            dd if=/vendor/etc/fsg/NJ_fs_image.tar.gz.mbn.img of=/dev/block/bootdevice/by-name/fsg
            echo "write N/J fsg"
        fi
        ;;
        "K4(K/S)")
        if [ -f /vendor/etc/fsg/KS_fs_image.tar.gz.mbn.img ]; then
            dd if=/vendor/etc/fsg/KS_fs_image.tar.gz.mbn.img of=/dev/block/bootdevice/by-name/fsg
            echo "write K/S fsg"
        fi
        ;;
        "A4/C2")
        if [ -f /vendor/etc/fsg/AC_fs_image.tar.gz.mbn.img ]; then
            dd if=/vendor/etc/fsg/AC_fs_image.tar.gz.mbn.img of=/dev/block/bootdevice/by-name/fsg
            echo "write A/C fsg"
        fi
        ;;
        "S4")
        if [ -f /vendor/etc/fsg/S4_fs_image.tar.gz.mbn.img ]; then
            dd if=/vendor/etc/fsg/S4_fs_image.tar.gz.mbn.img of=/dev/block/bootdevice/by-name/fsg
            echo "write S4 fsg"
        fi
        ;;
    esac
        touch $fsg_flag_path
        echo 1 > $fsg_flag_path
fi
 
