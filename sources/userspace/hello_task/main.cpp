#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>
#include <drivers/i2c.h>

/**
 * Hello task - blicks LED on GPIO pin 47 and writes hello message to uart
 * 
 * Ceka na stisk tlacitka, po stisku vyblika LEDkou "SOS" signal
 **/

constexpr uint32_t symbol_tick_delay = 0x400;
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t sos_led, uart, trng;

void blink()
{
	write(sos_led, "1", 1);
	sleep(0x1000);
	write(sos_led, "0", 1);
}

void get_random(char* buff)
{
    read(trng, buff, 4);
}

void do_cycle_random() {
    char buff[4], temp_buff[32]; // buffer nulled
    uint32_t* wbuf;
    int rndNum;

    write(uart, "Random number: ", 15);
    blink();
    get_random(buff);
    uint32_t* wbuf = reinterpret_cast<uint32_t*>(buff);
    rndNum = wbuf[0];
    itoa(rndNum, temp_buff, 10);
    write(uart, temp_buff, strlen(temp_buff));
}

int main(int argc, char** argv)
{
	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
	uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);
    trng = open("DEV:trng/0", NFile_Open_Mode::Read_Write);

    write(uart, "Hello task started...\n", 13);

    // start i2c connection
    sI2C1.Open();

	while (true)
	{
        
        
	}

	close(sos_led);
    close(uart);

    return 0;
}
