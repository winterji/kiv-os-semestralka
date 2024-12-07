#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>

/**
 * Hello task - blicks LED on GPIO pin 47 and writes hello message to uart
 * 
 * Ceka na stisk tlacitka, po stisku vyblika LEDkou "SOS" signal
 **/

constexpr uint32_t symbol_tick_delay = 0x400;
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t sos_led;

void blink(bool short_blink)
{
	write(sos_led, "1", 1);
	sleep(short_blink ? 0x800 : 0x1000);
	write(sos_led, "0", 1);
}

int main(int argc, char** argv)
{
    char hello[] = "Hello! I'm hello_task.\n";

	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);

	uint32_t uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);

	while (true)
	{
        blink(false);
		write(uart, hello, strlen(hello));
	}

	close(sos_led);
    close(uart);

    return 0;
}
