#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>
#include <drivers/i2c_master.h>

constexpr uint32_t ADDRESS = 1;
constexpr uint32_t TARGET_ADDRESS = 2;
constexpr CI2C_Mode DESIRED_ROLE = CI2C_Mode::Master;
CI2C_Mode agreed_role = CI2C_Mode::Undefined;

uint32_t master, log_fd;

float received_values[32];
uint32_t received_values_len = 0;

void prep_msg(char* buff, const char* msg) {
    uint16_t ofset = 0;
    switch (agreed_role)
    {
    case CI2C_Mode::Master:
        strncpy(buff, "MASTER: ", 8);
        ofset = 8;
        break;
    case CI2C_Mode::Slave:
        strncpy(buff, "SLAVE: ", 7);
        ofset = 7;
        break;
    default:
        strncpy(buff, "UNSET: ", 7);
        ofset = 7;
        break;
    }
    
    strncpy(buff + ofset, msg, strlen(msg));
}

void log(const char* msg)
{
    char new_buff[strlen(msg) + 7];
    prep_msg(new_buff, msg);
    write(log_fd, new_buff, strlen(msg)+7);
}

CI2C_Mode decide_role(CI2C_Mode my_role, char* other_role_buff)
{
    CI2C_Mode other_role = CI2C_Mode::Undefined;
    if (strncmp(other_role_buff, "mst", 3) == 0)
    {
        other_role = CI2C_Mode::Master;
    }
    else if (strncmp(other_role_buff, "slv", 3) == 0)
    {
        other_role = CI2C_Mode::Slave;
    }

    if (my_role == CI2C_Mode::Undefined)
    {
        if (other_role == CI2C_Mode::Master)
        {
            return CI2C_Mode::Slave;
        }
        else if (other_role == CI2C_Mode::Slave)
        {
            return CI2C_Mode::Master;
        }
    }
    else {
        if (my_role == other_role)
        {
            if (ADDRESS < TARGET_ADDRESS)
                return CI2C_Mode::Master;
            else
                return CI2C_Mode::Slave;
        }
    }
    return my_role;
}

bool set_roles(CI2C_Mode desired_role)
{
    char role[4], buff[32], log_msg[32];
    bzero(role, 4);
    bzero(buff, 32);
    bzero(log_msg, 32);
    switch (desired_role)
    {
    case CI2C_Mode::Master:
        strncpy(role, "mst", 3);
        break;
    case CI2C_Mode::Slave:
        strncpy(role, "slv", 3);
        break;
    default:
        strncpy(role, "slv", 3);
        break;
    }

    write(master, role, 4);
    while (strlen(buff) == 0) {
        read(master, buff, 4);
        sleep(0x100);
    }

    agreed_role = decide_role(desired_role, buff);
    strncpy(log_msg, "Roles set. I am ", 16);
    switch (agreed_role)
    {
    case CI2C_Mode::Master:
        concat(log_msg, "Master\n");
        break;
    case CI2C_Mode::Slave:
        concat(log_msg, "Slave\n");
        break;
    }
    log(log_msg);
    return agreed_role == desired_role;
}

void handle_data(char value_state, float value)
{
    char log_msg[32], value_str[16];
    bzero(log_msg, 32);
    bzero(value_str, 16);
    strncpy(log_msg, "Received ", 10);
    ftoa(value, value_str, 2);
    concat(log_msg, value_str);
    switch (value_state)
    {
    case 'v':
        // vse v poradku
        concat(log_msg, " - OK");
        break;
    case 'd':
        // nebezpecna hodnota
        concat(log_msg, " - DANGER");
        break;
    case 't':
        // dalsi hodnota muze byt nebezpecna
        concat(log_msg, " - WARNING");
        break;
    
    }
    concat(log_msg, "\n");
    log(log_msg);
}

void receive_data()
{
    char buff[6], log_msg[32];
    bzero(buff, 6);
    bzero(log_msg, 32);
    char value_state;
    float value;

    while (strlen(buff) == 0) {
        read(master, buff, 6);
        sleep(0x100);
    }

    value_state = buff[0];
    memcpy(buff + 1, &value, 4);

    handle_data(value_state, value);
}

int main(int argc, char** argv)
{
    char buff[9], msg[32];
    uint32_t slave_input;

    log_fd = pipe("log", 128);

    log("Master task started\n");

    // start i2c connection
    master = open("DEV:i2c/1", NFile_Open_Mode::Read_Write);
    if (master == Invalid_Handle) {
        log("Error opening I2C master connection\n");
        return 1;
    }
    // set addresses
    TI2C_IOCtl_Params params;
    params.address = ADDRESS;
    params.targetAdress = TARGET_ADDRESS;
    ioctl(master, NIOCtl_Operation::Set_Params, &params);
    log("I2C connection master started...\n");

    sleep(0x100);
    set_roles(DESIRED_ROLE);

    sleep(0x100);
    for (;;) {
        bzero(msg, 32);
        bzero(buff, 9);
        receive_data();

        sleep(0x15000);
    }

    close(master);
    log("Open files closed in master\n");
    close(log_fd);

    return 0;
}
