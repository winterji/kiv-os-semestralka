#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>
#include <process/process_manager.h>

/**
 * SOS blinker task
 * 
 * Ceka na stisk tlacitka, po stisku vyblika LEDkou "SOS" signal
 **/

constexpr uint32_t symbol_tick_delay = 0x400;
constexpr uint32_t char_tick_delay = 0x1000;

uint32_t sos_led, uart;

void blink(bool short_blink)
{
	write(sos_led, "1", 1);
	sleep(short_blink ? 0x800 : 0x1000);
	write(sos_led, "0", 1);
}

int main(int argc, char** argv)
{
	sos_led = open("DEV:gpio/47", NFile_Open_Mode::Write_Only);
	uart = open("DEV:uart/0", NFile_Open_Mode::Read_Write);

	while (true)
	{

		// tady by se mohla hodit inverze priorit:
		// 1) pipe je plna
		// 2) my mame deadline 0x300
		// 3) log task ma deadline 0x1000
		// 4) jiny task ma deadline 0x500
		// jiny task dostane prednost pred log taskem, a pokud nesplni v kratkem case svou ulohu, tento task prekroci deadline
		// TODO: inverzi priorit bychom docasne zvysili prioritu (zkratili deadline) log tasku, aby vyprazdnil pipe a my se mohli odblokovat co nejdrive
		write(uart, "SOS!", 5);

		blink(true);
		sleep(symbol_tick_delay);
		blink(true);
		sleep(symbol_tick_delay);
		blink(true);

		sleep(char_tick_delay);

		blink(false);
		sleep(symbol_tick_delay);
		blink(false);
		sleep(symbol_tick_delay);
		blink(false);
		sleep(symbol_tick_delay);

		sleep(char_tick_delay);

		blink(true);
		sleep(symbol_tick_delay);
		blink(true);
		sleep(symbol_tick_delay);
		blink(true);
	}

	close(uart);
	close(sos_led);

    return 0;
}
