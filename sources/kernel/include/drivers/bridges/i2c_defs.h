#pragma once

#include <hal/intdef.h>

enum class CI2C_Channel
{
    Master0     = 0,
    Master1     = 1,
    Slave       = 2,
    Undefined   = 3
};

enum class CI2C_Mode
{
    Master,
    Slave
};

// parametry UARTu pro prenos skrz IOCTL rozhrani
struct TI2C_IOCtl_Params
{
    uint8_t address;
    uint8_t targetAdress;
};
