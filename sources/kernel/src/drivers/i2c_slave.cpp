#include <drivers/i2c_slave.h>

#include <drivers/gpio.h>

CI2C_SLAVE sI2C1_SLAVE(hal::I2C_SLAVE_Base, 18, 19);

CI2C_SLAVE::CI2C_SLAVE(unsigned long base, uint32_t pin_sda, uint32_t pin_scl)
    : CI2C(base, pin_sda, pin_scl, NGPIO_Function::Alt_3)
{
    //
}

volatile uint32_t& CI2C_SLAVE::Reg(hal::I2C_SLAVE_Reg reg)
{
    return mBSC_Base[static_cast<uint32_t>(reg)];
}

void CI2C_SLAVE::Wait_Ready()
{
    volatile uint32_t& s = Reg(hal::I2C_SLAVE_Reg::FR);

    // pockame, dokud nebude ve status registru zapnuty ready bit
    while( !(s & (1 << 1)) )
        ;
}

bool CI2C_SLAVE::Open()
{
    if (CI2C::Open()) {
        Reg(hal::I2C_SLAVE_Reg::CR) = (1 << 0) | (1 << 2) | (1 << 9); // enable device, enable i2c, enable receive
        Reg(hal::I2C_SLAVE_Reg::IFLS) = 0x00000000; // set RX and TX FIFO interrupt to trigger when its 1/8 full

        return true;
    }
    return false;
}

void CI2C_SLAVE::Close()
{
    Reg(hal::I2C_SLAVE_Reg::CR) = 0;

    CI2C::Close();
}

bool CI2C_SLAVE::Is_Opened() const
{
    return mOpened;
}

void CI2C_SLAVE::Send(uint16_t addr, const char* buffer, uint32_t len)
{
    Reg(hal::I2C_SLAVE_Reg::SLV) = addr;
    // Reg(hal::I2C_SLAVE_Reg::Data_Length) = len;

    for (uint32_t i = 0; i < len; i++)
        Reg(hal::I2C_SLAVE_Reg::DR) = buffer[i];

    // Reg(hal::I2C_SLAVE_Reg::RSR) = (1 << 9) | (1 << 8) | (1 << 1); // reset "slave clock hold", "slave fail" a "status" bitu
    Reg(hal::I2C_SLAVE_Reg::CR) = (1 << 15) | (1 << 7); // zapoceti noveho prenosu (enable bsc + start transfer)

    Wait_Ready();
}

void CI2C_SLAVE::Receive(uint16_t addr, char* buffer, uint32_t len)
{
    // Reg(hal::I2C_SLAVE_Reg::SLV) = addr;

    // Reg(hal::I2C_SLAVE_Reg::RSR) = 0x00000000; // clear status
    // // Reg(hal::I2C_SLAVE_Reg::CR) = (1 << 0) | (1 << 2) | (1 << 9); // enable device, enable i2c, enable receive
    // // Reg(hal::I2C_SLAVE_Reg::IFLS) = 0x00000000; // set RX and TX FIFO interrupt to trigger when its 1/8 full

    // for (uint32_t i = 0; i < len; i++)
    //     buffer[i] = Reg(hal::I2C_SLAVE_Reg::DR);
    if (mIRQ_Pending) {
        mIRQ_Pending = false;
        // uint32_t counter = 0;
        // volatile uint32_t& dr_reg = Reg(hal::I2C_SLAVE_Reg::DR);
        // while(dr_reg & (0 << 17)) {
        //     buffer[counter] = dr_reg;
        //     counter += 1;
        // }
    
    }
    // uint32_t max = len;
    // if (mBuffer_len < len)
    //     max = mBuffer_len;
    // for (uint32_t i = 0; i < max; i++)
    //     buffer[i] = mBuffer[i];
}

bool CI2C_SLAVE::Is_IRQ_Pending()
{
    return Reg(hal::I2C_SLAVE_Reg::RIS) & (1 << 0);
}

void CI2C_SLAVE::IRQ_Callback()
{
    // uint32_t counter = 0;
    mIRQ_Pending = true;
    // volatile uint32_t& dr_reg = Reg(hal::I2C_SLAVE_Reg::DR);
    // while(dr_reg & (0 << 17)) {
    //     mBuffer[counter] = dr_reg;
    //     counter += 1;
    // }
    // mBuffer_len = counter;
}
