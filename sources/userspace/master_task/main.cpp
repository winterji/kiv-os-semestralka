#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>
#include <drivers/i2c_master.h>

/**
 * Hello task - blicks LED on GPIO pin 47 and writes hello message to uart
 * 
 * Ceka na stisk tlacitka, po stisku vyblika LEDkou "SOS" signal
 **/

constexpr uint32_t symbol_tick_delay = 0x400;
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t led, uart, master, log;

void blink()
{
	write(led, "1", 1);
	sleep(0x1000);
	write(led, "0", 1);
}

int main(int argc, char** argv)
{
    char buff[4];

    log = pipe("log", 32);
    // trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);

    write(log, "Master task started\n", 21);

    // start i2c connection
    master = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    write(log, "I2C connection master started...\n", 33);
    for (;;) {
        write(log, "Hello from master\n", 18);
        sleep(0x10000);
    }

    close(master);
    write(log, "Open files closed in master\n", 29);
    close(log);

    return 0;
}
