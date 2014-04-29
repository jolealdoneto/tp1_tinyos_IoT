#ifndef TP_IOT_H
#define TP_IOT_H

typedef nx_struct tp_iot {
  nx_uint16_t sender_nodeid;
  nx_uint16_t addressee_nodeid;
  nx_uint16_t error;
  nx_uint16_t data;
} tp_iot_t;

#define MESSAGE_BROADCAST -1

enum {
  AM_TP_IOT = 7,
};

#define RF230_DEF_RFPOWER 1
#endif
