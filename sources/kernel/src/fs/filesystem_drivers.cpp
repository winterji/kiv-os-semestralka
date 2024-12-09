#include <fs/filesystem.h>

// includujeme prislusne drivery
#include <fs/drivers/gpio_fs.h>
#include <fs/drivers/uart_fs.h>
#include <fs/drivers/trng_fs.h>
#include <fs/drivers/shiftregister_fs.h>
#include <fs/drivers/segmentdisplay_fs.h>
#include <fs/drivers/oled_ssd1306_fs.h>
#include <fs/drivers/semaphore_fs.h>
#include <fs/drivers/mutex_fs.h>
#include <fs/drivers/condvar_fs.h>
#include <fs/drivers/pipe_fs.h>

// pole driveru - tady uvedeme vsechny, ktere jsou v systemu dostupne a ktere je zadouci pro tuto instanci naseho OS pripojit
const CFilesystem::TFS_Driver CFilesystem::gFS_Drivers[] = {
    // "skutecna" zarizeni
    { "GPIO_FS", "DEV:gpio", &fsGPIO_FS_Driver },
    { "UART_FS", "DEV:uart", &fsUART_FS_Driver },
    { "TRNG_FS", "DEV:trng", &fsTRNG_FS_Driver },
    // { "Shift_Reg_FS", "DEV:sr", &fsShift_Register_FS_Driver },
    // { "7Seg_Disp_FS", "DEV:segd", &fsSegment_Display_FS_Driver },
    // { "OLED_Disp_FS", "DEV:oled", &fsOLED_Display_FS_Driver },

    // virtualni zarizeni
    { "Mutex", "SYS:mtx", &fsMutex_FS_Driver },
    { "Semaphore", "SYS:sem", &fsSemaphore_FS_Driver },
    { "CondVar", "SYS:cv", &fsCond_Var_FS_Driver },
    { "Pipe", "SYS:pipe", &fsPipe_FS_Driver },
};

// pocet FS driveru - je staticky spocitan z velikosti vyse uvedeneho pole
const uint32_t CFilesystem::gFS_Drivers_Count = sizeof(CFilesystem::gFS_Drivers) / sizeof(CFilesystem::TFS_Driver);
