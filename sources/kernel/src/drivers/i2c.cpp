#include <drivers/i2c.h>

#include <drivers/gpio.h>
#include <stdfile.h>

CI2C::CI2C(unsigned long base, uint32_t pin_sda, uint32_t pin_scl, NGPIO_Function func)
    : mBSC_Base(reinterpret_cast<volatile uint32_t*>(base)),
    mOpened(false),
    mSDA_Pin(pin_sda),
    mSCL_Pin(pin_scl),
    mGPIO_Function(func)
{
    //
}

bool CI2C::Open()
{
    uint32_t log = pipe("log", 32);
    if (!sGPIO.Reserve_Pin(mSDA_Pin, true, true)) {
        return false;
    }
    write(log, "SDA pin reserved\n", 17);
    if (!sGPIO.Reserve_Pin(mSCL_Pin, true, true)) {
        sGPIO.Free_Pin(mSDA_Pin, true, true);
        return false;
    }
    write(log, "SCL pin reserved\n", 17);

    sGPIO.Set_GPIO_Function(mSDA_Pin, mGPIO_Function);
    sGPIO.Set_GPIO_Function(mSCL_Pin, mGPIO_Function);

    mOpened = true;
    write(log, "I2C opened\n", 11);
    return true;
}

void CI2C::Close()
{

    sGPIO.Set_GPIO_Function(mSDA_Pin, NGPIO_Function::Input);
    sGPIO.Set_GPIO_Function(mSCL_Pin, NGPIO_Function::Input);

    sGPIO.Free_Pin(mSDA_Pin, true, true);
    sGPIO.Free_Pin(mSCL_Pin, true, true);

    mOpened = false;
}

bool CI2C::Is_Opened() const
{
    return mOpened;
}

void CI2C::Send(uint16_t addr, const char* buffer, uint32_t len)
{

}

void CI2C::Receive(uint16_t addr, char* buffer, uint32_t len)
{

}


