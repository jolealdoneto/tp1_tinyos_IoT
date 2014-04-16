#ifndef TP_IOT_H
#define TP_IOT_H

typedef nx_struct tp_iot {
  nx_uint16_t sender_nodeid;
  nx_uint16_t error;
  nx_uint16_t data;
  nx_uint8_t message_type;
} tp_iot_t;

#define MESSAGE_BROADCAST 0
#define MESSAGE_SENSEDINFO 1

enum {
  AM_RADIO_SENSE_MSG = 7,
};

#endif
