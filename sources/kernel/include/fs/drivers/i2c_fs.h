#pragma once

#include <drivers/gpio.h>
#include <drivers/i2c_slave.h>
#include <drivers/i2c_master.h>
#include <hal/peripherals.h>
#include <memory/kernel_heap.h>
#include <fs/filesystem.h>
#include <stdstring.h>
#include <process/process_manager.h>

// #include <stdfile.h>

// virtualni soubor pro GPIO pin
class CI2C_File final : public IFile
{
    private:
        // ulozeny ID channelu
        CI2C_Channel mChannelNum;
        // otevreny I2C konektor
        CI2C* mChannel;
        // zdrojova I2C adresa
        uint8_t mAddress = 0;
        // cilova I2C adresa
        uint8_t mTargetAddress = 0;

    public:
        // temporarily
        uint32_t mRawChannelNum;

        CI2C_File(CI2C_Channel channelNum, CI2C* channel, uint32_t rawChannelNum)
            : IFile(NFile_Type_Major::Character), mChannelNum(channelNum), mChannel(channel), mRawChannelNum(rawChannelNum)
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
            case CI2C_Channel::Master0:
                mChannel->Receive(mTargetAddress, buffer, num);
                break;
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

        bool Handshake()
        {
            if (mChannel->Is_Opened()) {
                // handshake from master
                char buff[4];
                bzero(buff, 4);
                if (mChannelNum == CI2C_Channel::Master0 || mChannelNum == CI2C_Channel::Master1) {
                    // fake syn for testing
                    // for (uint32_t i = 0; i < 4; i++) {
                    //     mChannel->Send(mTargetAddress, "hah", 4);
                    //     TSWI_Result target;
                    //     sProcessMgr.Handle_Process_SWI(NSWI_Process_Service::Sleep, 100, Deadline_Unchanged, 0, target);
                    //     // mChannel->Receive(mTargetAddress, buff, 4);
                    // }
                    // real syn
                    while (strlen(buff) == 0 || strncmp(buff, "ack", 4) != 0) {
                        mChannel->Send(mTargetAddress, "syn", 4);
                        TSWI_Result target;
                        sProcessMgr.Handle_Process_SWI(NSWI_Process_Service::Sleep, 0x100, Deadline_Unchanged, 0, target);
                        mChannel->Receive(mTargetAddress, buff, 4);
                    }
                    return true;
                }
                // handshake from slave
                else if (mChannelNum == CI2C_Channel::Slave) {
                    while (strlen(buff) == 0 || strncmp(buff, "syn", 4) != 0) {
                        // if (strlen(buff) != 0 && strncmp(buff, "syn", 4) != 0)
                        //     mChannel->Send(mAddress, "non", 4);
                        TSWI_Result target;
                        sProcessMgr.Handle_Process_SWI(NSWI_Process_Service::Sleep, 0x100, Deadline_Unchanged, 0, target);
                        mChannel->Receive(mAddress, buff, 4);
                    }
                    mChannel->Send(mAddress, "ack", 4);
                }
                else {
                    return false;
                }
                return true;
            }
            else return false;
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
                    switch (mChannelNum)
                    {
                    case CI2C_Channel::Master0:
                        mChannel->Set_Address(mTargetAddress);
                        Handshake();
                        break;
                    case CI2C_Channel::Master1:
                        mChannel->Set_Address(mTargetAddress);
                        Handshake();
                        break;
                    case CI2C_Channel::Slave:
                        mChannel->Set_Address(mAddress);
                        Handshake();
                        break;
                    default:
                        break;
                    }
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

            uint32_t inputChannelNum = atoi(path);
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
            if (channel->Open()) {  
                CI2C_File* f = new CI2C_File(channelNum, channel, inputChannelNum);
                return f;
            }
            else {
                return nullptr;
            }
        }
};

CI2C_FS_Driver fsI2C_FS_Driver;
