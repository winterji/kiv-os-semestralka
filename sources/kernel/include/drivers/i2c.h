#pragma once

#include <hal/peripherals.h>
#include <drivers/gpio.h>
#include <drivers/bridges/i2c_defs.h>

// maximalni pocet bytu v jedne transakci
constexpr uint32_t I2C_Transaction_Max_Size = 8;

class CI2C {
    protected:
        // baze pro registry BSC (I2C)
        volatile uint32_t* const mBSC_Base;

        // priznak otevreni
        bool mOpened;

        // data pin I2C
        uint32_t mSDA_Pin;
        // clock pin I2C
        uint32_t mSCL_Pin;

        // NGPIO function
        NGPIO_Function mGPIO_Function;

    public:
        CI2C(unsigned long base, uint32_t pin_sda, uint32_t pin_scl, NGPIO_Function func);

        // je driver otevreny?
        bool Is_Opened() const;

        // otevre driver
        virtual bool Open();
        // zavre driver
        virtual void Close();

        // odesle pres I2C na danou adresu obsah bufferu
        virtual void Send(uint16_t addr, const char* buffer, uint32_t len) = 0;
        // prijme z I2C z dane adresy obsah do bufferu o dane delce
        virtual void Receive(uint16_t addr, char* buffer, uint32_t len) = 0;

        virtual void Set_Address(uint8_t addr) = 0;
};
