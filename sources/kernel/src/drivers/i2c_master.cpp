#include <drivers/i2c_master.h>

#include <drivers/gpio.h>

CI2C_MASTER sI2C_MASTER0(hal::BSC1_Base, 0, 1);
CI2C_MASTER sI2C_MASTER1(hal::BSC1_Base, 2, 3);

CI2C_MASTER::CI2C_MASTER(unsigned long base, uint32_t pin_sda, uint32_t pin_scl)
    : CI2C(base, pin_sda, pin_scl, NGPIO_Function::Alt_0)
{
    //
}

volatile uint32_t& CI2C_MASTER::Reg(hal::BSC_Reg reg)
{
    return mBSC_Base[static_cast<uint32_t>(reg)];
}

bool CI2C_MASTER::Open()
{
    if (CI2C::Open()) {
        // Reg(hal::BSC_Reg::Control) = (1 << 15); // enable device
        // Reg(hal::BSC_Reg::Clock_Div) = 150; // 150 = 100kHz
        return true;
    }
    return false;
}

void CI2C_MASTER::Close()
{
    Reg(hal::BSC_Reg::Control) = 0;
    CI2C::Close();
}

void CI2C_MASTER::Wait_Ready()
{
    volatile uint32_t& s = Reg(hal::BSC_Reg::Status);

    // pockame, dokud nebude ve status registru zapnuty ready bit
    while( !(s & (1 << 1)) )
        ;
}

void CI2C_MASTER::Send(uint16_t addr, const char* buffer, uint32_t len)
{
    Reg(hal::BSC_Reg::Slave_Address) = addr;
    Reg(hal::BSC_Reg::Data_Length) = len;

    volatile uint32_t& status_reg = Reg(hal::BSC_Reg::Status);
    status_reg = (1 << 9) | (1 << 8) | (1 << 1); // reset "slave clock hold", "slave fail" a "status" bitu
    Reg(hal::BSC_Reg::Control) = (1 << 15) | (1 << 7) | (1 << 4); // zapoceti noveho prenosu (enable bsc + start transfer)

    for (uint32_t i = 0; i < len; i++)
        Reg(hal::BSC_Reg::Data_FIFO) = buffer[i];

    Wait_Ready();
}

void CI2C_MASTER::Receive(uint16_t addr, char* buffer, uint32_t len)
{
    Reg(hal::BSC_Reg::Slave_Address) = addr;
    Reg(hal::BSC_Reg::Data_Length) = len;

    Reg(hal::BSC_Reg::Status) = (1 << 9) | (1 << 8) | (1 << 1); // reset "slave clock hold", "slave fail" a "status" bitu
    Reg(hal::BSC_Reg::Control) = (1 << 15) | (1 << 7) | (1 << 0); // zapoceti cteni (enable bsc + clear fifo + start transfer + read)

    Wait_Ready();

    for (uint32_t i = 0; i < len; i++)
        buffer[i] = Reg(hal::BSC_Reg::Data_FIFO);
}
