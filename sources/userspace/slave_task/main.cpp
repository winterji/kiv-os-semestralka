#include <stdstring.h>
#include <stdfile.h>
#include <stdmutex.h>

#include <drivers/gpio.h>
#include <drivers/i2c_slave.h>

constexpr float UPPER_BOUND = 11.0F;
constexpr float LOWER_BOUND = 3.5F;

constexpr uint32_t ADDRESS = 2;
constexpr uint32_t TARGET_ADDRESS = 1;
constexpr CI2C_Mode DESIRED_ROLE = CI2C_Mode::Slave;
CI2C_Mode agreed_role = CI2C_Mode::Undefined;

uint32_t log_fd, slave;

const float random_values[] = {
    6.71f, 4.23f, 5.12f, 3.99f, 2.22f, 7.20f, 11.93f, 10.96f
};
const uint32_t random_values_len = 8;
float prev_value = random_values[0];

void prep_msg(char* buff, const char* msg) {
    switch (agreed_role)
    {
    case CI2C_Mode::Master:
        strncpy(buff, "MASTER: ", 8);
        break;
    case CI2C_Mode::Slave:
        strncpy(buff, "SLAVE: ", 7);
        break;
    default:
        strncpy(buff, "UNSET: ", 7);
        break;
    }
    
    strncpy(buff + 7, msg, strlen(msg));
}

void log(const char* msg)
{
    char new_buff[strlen(msg) + 7];
    prep_msg(new_buff, msg);
    write(log_fd, new_buff, strlen(msg)+7);
}

void log(const uint32_t value) {
    char buff[32], pom[32];
    itoa(value, pom, 10);
    prep_msg(buff, pom);
    write(log_fd, buff, strlen(buff));
}

void send_data(const float value)
{
    float next_predict = -1.0f;
    char msg[6];
    if (value < LOWER_BOUND || value > UPPER_BOUND)
        msg[0] = 'd';
    else {
        // doplnit vypocet trendu
        next_predict = value + (value - prev_value);
        if (next_predict < LOWER_BOUND || next_predict > UPPER_BOUND) {
            msg[0] = 't';
        }
        else {
            msg[0] = 'v';
        }
    }
    memcpy(&value, msg + 1, 4);
    msg[5] = '\0';
    write(slave, msg, 6);
}

void send_value(const float value) {
    char pom[5], buff[32];
    bzero(pom, 5);
    bzero(buff, 32);
    strncpy(buff, "Sending: ", 15);
    ftoa(value, pom, 2);
    concat(buff, pom);
    concat(buff, "\n");
    log(buff);
    send_data(value);
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
            log("Desired roles are the same\n");
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

    write(slave, role, 4);
    while (strlen(buff) == 0) {
        read(slave, buff, 4);
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

int main(int argc, char** argv)
{
    uint32_t counter = 0;
    char buff[32];
    bzero(buff, 32);

    log_fd = pipe("log", 128);

    log("Slave task started\n");

    // start i2c connection
    slave = open("DEV:i2c/2", NFile_Open_Mode::Read_Write);
    if (slave == Invalid_Handle) {
        log("Error opening I2C slave connection\n");
        return 1;
    }
    // set addresses
    TI2C_IOCtl_Params params;
    params.address = ADDRESS;
    params.targetAdress = TARGET_ADDRESS;
    ioctl(slave, NIOCtl_Operation::Set_Params, &params);
    log("I2C connection slave started...\n");

    sleep(0x100);
    set_roles(DESIRED_ROLE);

    for (;;) {
        send_value(random_values[counter]);
        prev_value = random_values[counter];
        counter = (counter + 1) % random_values_len;
        sleep(0x15000);
    }

    close(slave);
    log("Open files closed in slave\n");
    close(log_fd);

    return 0;
}
