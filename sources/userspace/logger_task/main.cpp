#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/bridges/uart_defs.h>

/**
 * Logger task
 * 
 * Prijima vsechny udalosti od ostatnich tasku a oznamuje je skrz UART hostiteli
 **/

static void fputs(uint32_t file, const char* string)
{
	write(file, string, strlen(string));
}

int main(int argc, char** argv)
{
	uint32_t uart_file = open("DEV:uart/0", NFile_Open_Mode::Write_Only);

	TUART_IOCtl_Params params;
	params.baud_rate = NUART_Baud_Rate::BR_115200;
	params.char_length = NUART_Char_Length::Char_8;
	ioctl(uart_file, NIOCtl_Operation::Set_Params, &params);

	fputs(uart_file, "Logger task starting!");

	char buf[33];
	char big_buf[128];
	char tickbuf[16];
	bzero(big_buf, 128);
	bzero(tickbuf, 16);
	bzero(buf, 33);
	

	uint32_t last_tick = 0, free_index = 0;

	uint32_t logpipe = pipe("log", 128);

	while (true)
	{
		
		wait(logpipe, 1, 0x1000);
		uint32_t v = read(logpipe, buf, 32);
		// if (v <= 0) {
		// 	wait(logpipe, 1, 0x1000);
		// 	continue;
		// }
			

		// for (uint32_t i = 0; i < v; i++) {
		// 	buf[free_index++] = big_buf[i];
		// 	if (big_buf[i] == '\n') {
		// 		buf[i+1] = '\0';
		// 		fputs(uart_file, "\r\n[ ");
		// 		uint32_t tick = get_tick_count();
		// 		itoa(tick, tickbuf, 16);
		// 		fputs(uart_file, tickbuf);
		// 		fputs(uart_file, "]: ");
		// 		fputs(uart_file, buf);
		// 		// sleep before it is actually written
		// 		// sleep(0x100);
		// 		// zero out the buffer
		// 		bzero(buf, 129);
		// 		free_index = 0;
		// 	}
		// }
		if (v > 0)
		{
			buf[v] = '\0';
			fputs(uart_file, "\r\n[ ");
			uint32_t tick = get_tick_count();
			itoa(tick, tickbuf, 16);
			fputs(uart_file, tickbuf);
			fputs(uart_file, "]: ");
			fputs(uart_file, buf);
		}
	}

    return 0;
}