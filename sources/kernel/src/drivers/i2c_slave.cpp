#include <drivers/i2c_slave.h>
#include <drivers/gpio.h>

#include <stdfile.h>
#include <stdstring.h>

CI2C_SLAVE sI2C1_SLAVE(hal::I2C_SLAVE_Base, 18, 19);

CI2C_SLAVE::CI2C_SLAVE(unsigned long base, uint32_t pin_sda, uint32_t pin_scl)
    : CI2C(base, pin_sda, pin_scl, NGPIO_Function::Alt_3), mReadPointer(0), mWritePointer(0)
{
    //
}

volatile uint32_t& CI2C_SLAVE::Reg(hal::I2C_SLAVE_Reg reg)
{
    return mBSC_Base[static_cast<uint32_t>(reg)];
}

bool CI2C_SLAVE::Open()
{
    if (CI2C::Open()) {
        Reg(hal::I2C_SLAVE_Reg::CR) = (1 << 0) | (1 << 2) | (1 << 9); // enable device, enable i2c, enable receive
        Reg(hal::I2C_SLAVE_Reg::IFLS) = 0; // set RX and TX FIFO interrupt to trigger when its 1/8 full
        return true;
    }
    return false;
}

void CI2C_SLAVE::Close()
{
    Reg(hal::I2C_SLAVE_Reg::CR) = 0;

    CI2C::Close();
}

void CI2C_SLAVE::Set_Address(uint8_t addr)
{
    Reg(hal::I2C_SLAVE_Reg::SLV) = addr;
}

void CI2C_SLAVE::Send(uint16_t addr, const char* buffer, uint32_t len)
{
    // Reg(hal::I2C_SLAVE_Reg::Data_Length) = len;
    // uint32_t log = pipe("log", 128);
    Reg(hal::I2C_SLAVE_Reg::CR) = (1 << 0) | (1 << 2) | (1 << 9) | (1 << 8); // enable transmit, vse ostatni by melo byt aktivni z open
    volatile uint32_t& f = Reg(hal::I2C_SLAVE_Reg::FR);

    for (uint32_t i = 0; i < len; i++) {
        Reg(hal::I2C_SLAVE_Reg::DR) = buffer[i];
    }

    // char pom[64];
    // bzero(pom, 64);
    // strncpy(pom, "I2C SLAVE sent: ", 16);
    // concat(pom, buffer);
    // concat(pom, "\n");
    // write(log, pom, strlen(pom));
}

void CI2C_SLAVE::Receive(uint16_t addr, char* buffer, uint32_t len)
{
    // uint32_t log = pipe("log", 128);
    uint32_t max = (mWritePointer + I2C_SLAVE_Buffer_Size - mReadPointer) % I2C_SLAVE_Buffer_Size;
    if (max > len) {
        max = len;
    }
    for (uint32_t i = 0; i < max; i++) {
        buffer[i] = mBuffer[mReadPointer];
        mBuffer[mReadPointer] = 0;
        mReadPointer = (mReadPointer + 1) % I2C_SLAVE_Buffer_Size;
    }
    // uint32_t log = pipe("log", 128);
    // if (max < 0) {
    //     write(log, "Slave read 0 bytes\n", 20);
    // }

    // char pom[64];
    // bzero(pom, 64);
    // strncpy(pom, "I2C SLAVE received: ", 20);
    // concat(pom, buffer);
    // concat(pom, "\n");
    // write(log, pom, strlen(pom));
}

bool CI2C_SLAVE::Is_IRQ_Pending()
{
    volatile uint32_t& r = Reg(hal::I2C_SLAVE_Reg::RIS);
    return r & (1 << 0);
}

void CI2C_SLAVE::IRQ_Callback()
{
    uint32_t counter = 0;
    volatile uint32_t& fr = Reg(hal::I2C_SLAVE_Reg::FR);
    while(!(fr & (1 << 1))) {
        mBuffer[mWritePointer] = Reg(hal::I2C_SLAVE_Reg::DR);
        mWritePointer = (mWritePointer + 1) % I2C_SLAVE_Buffer_Size;
        counter++;
    }
    // print info about received data
    // uint32_t log = pipe("log", 128);
    // char pom[32], msg[64];
    // strncpy(msg, "IRQ_Callback: ", 14);
    // itoa(counter, pom, 10);
    // concat(pom, " bytes received\n");
    // concat(msg, pom);
    // write(log, msg, strlen(msg));
}
