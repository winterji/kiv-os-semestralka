#pragma once

#include <drivers/gpio.h>
#include <drivers/i2c_slave.h>
#include <drivers/i2c_master.h>
#include <hal/peripherals.h>
#include <memory/kernel_heap.h>
#include <fs/filesystem.h>
#include <stdstring.h>
#include <process/process_manager.h>

#include <stdfile.h>

// virtualni soubor pro GPIO pin
class CI2C_File final : public IFile
{
    private:
        // ulozeny ID pinu
        CI2C_Channel mChannelNum;
        // otevreny I2C konektor
        CI2C* mChannel;
        // zdrojova I2C adresa
        uint8_t mAddress = 0;
        // cilova I2C adresa
        uint8_t mTargetAddress = 0;

    public:
        CI2C_File(CI2C_Channel channelNum, CI2C* channel)
            : IFile(NFile_Type_Major::Character), mChannelNum(channelNum), mChannel(channel)
        {
            //
        }

        ~CI2C_File()
        {
            // pokud jeste je otevreny, zavreme
            Close();
        }

        virtual uint32_t Read(char* buffer, uint32_t num) override
        {
            if (num == 0 || buffer == nullptr)
                return 0;
            switch (mChannelNum)
            {
            case CI2C_Channel::Master1:
                mChannel->Receive(mTargetAddress, buffer, num);
                break;
            case CI2C_Channel::Slave:
                mChannel->Receive(mAddress, buffer, num);
                break;
            default:
                break;
            }
            return num;
        }

        virtual uint32_t Write(const char* buffer, uint32_t num) override
        {
            if (num > 0 && buffer != nullptr)
            {
                switch (mChannelNum)
                {
                case CI2C_Channel::Master1:
                    mChannel->Send(mTargetAddress, buffer, num);
                    break;
                case CI2C_Channel::Slave:
                    mChannel->Send(mAddress, buffer, num);
                    break;
                default:
                    break;
                }
                return num;
            }

            return 0;
        }

        virtual bool Close() override
        {

            mChannel->Close();
            mAddress = 0;
            mTargetAddress = 0;

            return IFile::Close();
        }

        virtual bool IOCtl(NIOCtl_Operation op, void* ctlptr) override
        {
            TI2C_IOCtl_Params* params = reinterpret_cast<TI2C_IOCtl_Params*>(ctlptr);

            switch (op)
            {
                case NIOCtl_Operation::Set_Params:
                    mAddress = params->address;
                    mTargetAddress = params->targetAdress;
                    return true;
                case NIOCtl_Operation::Get_Params:
                    params->address = mAddress;
                    params->targetAdress = mTargetAddress;
                    return true;
            }

            return false;
        }
};

// driver pro filesystem pro I2C rozhrani
class CI2C_FS_Driver : public IFilesystem_Driver
{
	public:
		virtual void On_Register() override
        {
            //
        }

        virtual IFile* Open_File(const char* path, NFile_Open_Mode mode) override
        {
            // v path ocekava zda otevira I2C jako master 1/2 nebo slave
            CI2C* channel;

            int inputChannelNum = atoi(path);
            CI2C_Channel channelNum = static_cast<CI2C_Channel>(inputChannelNum);
            switch (inputChannelNum)
            {
            case 0:
                // I2C master 0
                channel = &sI2C_MASTER0;
                break;
            case 1:
                // I2C master 1
                channel = &sI2C_MASTER1;
                break;
            case 2:
                // I2C slave
                channel = &sI2C1_SLAVE;
                break;
            default:
                return nullptr;
                break;
            }
            uint32_t log = pipe("log", 32);
            if (channel->Open()) {  
                CI2C_File* f = new CI2C_File(channelNum, channel);
                write(log, "I2C FS opened\n", 14);
                char buff[4];
                uint32_t fa = reinterpret_cast<uint32_t>(f);
                itoa(fa, buff, 10);
                write(log, buff, strlen(buff));
                return f;
            }
            else {
                return nullptr;
            }
        }
};

CI2C_FS_Driver fsI2C_FS_Driver;
