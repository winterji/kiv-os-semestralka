#include <hal/intdef.h>
#include <hal/peripherals.h>

#include <interrupt_controller.h>
#include <drivers/gpio.h>
#include <drivers/timer.h>
#include <process/process_manager.h>
#include <process/swi.h>

#include <drivers/i2c_slave.h>

extern "C"
{
    void enable_irq();
    void disable_irq();
}

unsigned int CIRQ_Mask_Guard::gMask_Counter = 0;

CInterrupt_Controller sInterruptCtl(hal::Interrupt_Controller_Base);

// handlery jednotlivych zdroju preruseni

static TSWI_Result _SWI_Result;

extern "C" TSWI_Result* _internal_software_interrupt_handler(uint32_t register r0, uint32_t register r1, uint32_t register r2, uint32_t register /*r3*/ service_identifier)
{
    // facility jsou horni 2 bity, zbytek je cislo sluzby v dane facility
    NSWI_Facility facility = static_cast<NSWI_Facility>(service_identifier >> 6);

    switch (facility)
    {
        case NSWI_Facility::Process:
            sProcessMgr.Handle_Process_SWI(static_cast<NSWI_Process_Service>(service_identifier & 0x3F), r0, r1, r2, _SWI_Result);
            break;
        case NSWI_Facility::Filesystem:
            sProcessMgr.Handle_Filesystem_SWI(static_cast<NSWI_Filesystem_Service>(service_identifier & 0x3F), r0, r1, r2, _SWI_Result);
            break;
    }

    return &_SWI_Result;
}

extern "C" void _internal_irq_handler()
{
    // jelikoz ARM nerozlisuje zdroje IRQ implicitne, ani nezarucuje, ze se navzajen nemaskuji, musime
    // projit vsechny mozne zdroje a podivat se (poll), zda nebylo vyvolano preruseni
    // i2c slave
    if (sI2C1_SLAVE.Is_IRQ_Pending())
        sI2C1_SLAVE.IRQ_Callback();
        
    // GPIO (samo si overi, zda k nejakemu doslo)
    sGPIO.Handle_IRQ();

    // casovac
    if (sTimer.Is_Timer_IRQ_Pending())
        sTimer.IRQ_Callback();
    
    
}

extern "C" void __attribute__((interrupt("FIQ"))) fast_interrupt_handler()
{
    // zatim nepouzivame
}

// implementace controlleru

CInterrupt_Controller::CInterrupt_Controller(unsigned long base)
    : mInterrupt_Regs(reinterpret_cast<unsigned int*>(base))
{
    //
}

volatile unsigned int& CInterrupt_Controller::Regs(hal::Interrupt_Controller_Reg reg)
{
    return mInterrupt_Regs[static_cast<unsigned int>(reg)];
}

void CInterrupt_Controller::Enable_Basic_IRQ(hal::IRQ_Basic_Source source_idx)
{
    Regs(hal::Interrupt_Controller_Reg::IRQ_Basic_Enable) = (1 << static_cast<unsigned int>(source_idx));
}

void CInterrupt_Controller::Disable_Basic_IRQ(hal::IRQ_Basic_Source source_idx)
{
    Regs(hal::Interrupt_Controller_Reg::IRQ_Basic_Disable) = (1 << static_cast<unsigned int>(source_idx));
}

void CInterrupt_Controller::Enable_IRQ(hal::IRQ_Source source_idx)
{
    const unsigned int idx_base = static_cast<unsigned int>(source_idx);

    Regs(idx_base < 32 ? hal::Interrupt_Controller_Reg::IRQ_Enable_1 : hal::Interrupt_Controller_Reg::IRQ_Enable_2) = (1 << (idx_base % 32));
}

void CInterrupt_Controller::Disable_IRQ(hal::IRQ_Source source_idx)
{
    const unsigned int idx_base = static_cast<unsigned int>(source_idx);

    Regs(idx_base < 32 ? hal::Interrupt_Controller_Reg::IRQ_Disable_1 : hal::Interrupt_Controller_Reg::IRQ_Disable_1) = (1 << (idx_base % 32));
}

void CInterrupt_Controller::Set_Mask_IRQ(bool state)
{
    if (state)
        disable_irq();
    else
        enable_irq();
}

CIRQ_Mask_Guard::CIRQ_Mask_Guard()
{
    if (gMask_Counter++ == 0)
        sInterruptCtl.Set_Mask_IRQ(true);
}

CIRQ_Mask_Guard::~CIRQ_Mask_Guard()
{
    if (--gMask_Counter == 0)
        sInterruptCtl.Set_Mask_IRQ(false);
}
