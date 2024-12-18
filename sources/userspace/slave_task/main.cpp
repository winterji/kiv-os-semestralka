#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>
#include <drivers/i2c_slave.h>

/**
 * Hello task - blicks LED on GPIO pin 47 and writes hello message to uart
 * 
 * Ceka na stisk tlacitka, po stisku vyblika LEDkou "SOS" signal
 **/

constexpr uint32_t symbol_tick_delay = 0x400;
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t log, slave;

// void blink()
// {
// 	write(led, "1", 1);
// 	sleep(0x1000);
// 	write(led, "0", 1);
// }

// void get_random(char* buff)
// {
//     read(trng, buff, 4);
// }

// void do_cycle_random() {
//     char buff[4], temp_buff[32]; // buffer nulled
//     uint32_t* wbuf;
//     int rndNum;

//     write(uart, "Random number: ", 15);
//     blink();
//     get_random(buff);
//     wbuf = reinterpret_cast<uint32_t*>(buff);
//     rndNum = wbuf[0];
//     itoa(rndNum, temp_buff, 10);
//     write(uart, temp_buff, strlen(temp_buff));
// }

int main(int argc, char** argv)
{
    char buff[4];

    log = pipe("log", 32);

    write(log, "Slave task started\n", 19);

    // start i2c connection
    slave = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    write(log, "I2C connection slave started...\n", 30);
    for (;;) {
        write(log, "Hello from slave\n", 17);
        sleep(0x10000);
    }

    close(slave);
    write(log, "Open files closed in slave\n", 28);
    close(log);

    return 0;
}
