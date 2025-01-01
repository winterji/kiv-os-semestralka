#include "../../userspace/build/src_init_task.h"
#include "../../userspace/build/src_sos_task.h"
#include "../../userspace/build/src_glucose_task_2.h"
#include "../../userspace/build/src_glucose_task_1.h"
#include "../../userspace/build/src_logger_task.h"

// #include <stdstring.h>
// #include <stdfile.h>
// #include <stdmutex.h>

// #include <drivers/gpio.h>
// #include <drivers/i2c_master.h>
// #include <drivers/i2c_slave.h>

// az budeme umet cist SD kartu, tento soubor uplne zmizi

// uint32_t sos_led, uart;

// void Process_I2C()
// {
//     char buff[4];

// 	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
// 	uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);

//     write(uart, "Hello task started...\n", 13);

//     // start i2c connection
//     sI2C_MASTER1.Open();
//     sI2C1_SLAVE.Open();

//     write(uart, "I2C connection started...\n", 13);
//     sleep(0x10000);

//     sI2C_MASTER1.Send(1, "X", 1);
//     sI2C1_SLAVE.Receive(1, buff, 1);

// 	write(uart, "I2C communication test...\n", 13);
//     write(uart, buff, 1);

//     sI2C_MASTER1.Close();
//     sI2C1_SLAVE.Close();

// 	close(sos_led);
//     close(uart);

//     // return 0;
// }