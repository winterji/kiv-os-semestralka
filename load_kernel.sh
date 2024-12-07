#!/bin/bash
echo "Loading kernel to the board..."

device="/dev/ttyUSB0"
# if its run on mac, change the device
if [[ "$OSTYPE" == "darwin"* ]]; then
    device="/dev/tty.usbserial-0070A3FB"
fi
echo "Load to $device"
# load kernel to the board using the variable loader

# ./../SREC-UART-Loader/build/uart_flasher $core/$build_dir/kernel.srec $device
./uart_flasher sources/build/kernel.srec $device

