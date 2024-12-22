#pragma once

#include <drivers/i2c.h>

// maximalni pocet bytu v jedne transakci
// constexpr uint32_t I2C_Transaction_Max_Size = 8;
constexpr uint32_t I2C_SLAVE_Buffer_Size = 128;

class CI2C_SLAVE : public CI2C
{

    private:
        // buffer pro prichozi zpravy
        char mBuffer[I2C_SLAVE_Buffer_Size];
        uint32_t mReadPointer;
        uint32_t mWritePointer;

    protected:
        volatile uint32_t& Reg(hal::I2C_SLAVE_Reg reg);

    public:
        CI2C_SLAVE(unsigned long base, uint32_t pin_sda, uint32_t pin_scl);
        
        // otevre driver
        bool Open() override;
        // zavre driver
        void Close() override;

        // odesle pres I2C na danou adresu obsah bufferu
        virtual void Send(uint16_t addr, const char* buffer, uint32_t len) override;
        // prijme z I2C z dane adresy obsah do bufferu o dane delce
        virtual void Receive(uint16_t addr, char* buffer, uint32_t len) override;
        // zkontruluje, zda je preruseni I2C Slave aktivni
        bool Is_IRQ_Pending();
        // callback v pripade preruseni
        void IRQ_Callback();

        virtual void Set_Address(uint8_t addr) override;

};

extern CI2C_SLAVE sI2C1_SLAVE;
