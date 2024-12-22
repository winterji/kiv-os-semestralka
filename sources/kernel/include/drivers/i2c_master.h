#pragma once

#include <drivers/i2c.h>

class CI2C_MASTER : public CI2C
{
    protected:
        volatile uint32_t& Reg(hal::BSC_Reg reg);

        // vycka, az je dokoncena probihajici I2C operace
        void Wait_Ready();

    public:
        CI2C_MASTER(unsigned long base, uint32_t pin_sda, uint32_t pin_scl);

        // otevre driver
        bool Open() override;
        // zavre driver
        void Close() override;

        // odesle pres I2C na danou adresu obsah bufferu
        virtual void Send(uint16_t addr, const char* buffer, uint32_t len) override;
        // prijme z I2C z dane adresy obsah do bufferu o dane delce
        virtual void Receive(uint16_t addr, char* buffer, uint32_t len) override;

        virtual void Set_Address(uint8_t addr) override;
};

extern CI2C_MASTER sI2C_MASTER0;
extern CI2C_MASTER sI2C_MASTER1;
