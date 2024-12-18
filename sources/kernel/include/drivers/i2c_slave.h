#pragma once

#include <drivers/i2c.h>

// maximalni pocet bytu v jedne transakci
// constexpr uint32_t I2C_Transaction_Max_Size = 8;

class CI2C_SLAVE : public CI2C
{

    private:
        // buffer pro prichozi zpravy
        char mBuffer[I2C_Transaction_Max_Size];
        

    protected:
        volatile uint32_t& Reg(hal::I2C_SLAVE_Reg reg);

        // vycka, az je dokoncena probihajici I2C operace
        void Wait_Ready();

    public:
        CI2C_SLAVE(unsigned long base, uint32_t pin_sda, uint32_t pin_scl);
        
        bool mIRQ_Pending;
        uint32_t mBuffer_len;

        // otevre driver
        bool Open();
        // zavre driver
        void Close();
        // je driver otevreny?
        bool Is_Opened() const;

        // odesle pres I2C na danou adresu obsah bufferu
        void Send(uint16_t addr, const char* buffer, uint32_t len);
        // prijme z I2C z dane adresy obsah do bufferu o dane delce
        void Receive(uint16_t addr, char* buffer, uint32_t len);
        // zkontruluje, zda je preruseni I2C Slave aktivni
        bool Is_IRQ_Pending();
        // callback v pripade preruseni
        void IRQ_Callback();

};

extern CI2C_SLAVE sI2C1_SLAVE;
