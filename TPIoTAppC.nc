#include "TPIoT.h"

configuration TPIoTAppC {}
implementation {
  components MainC, TPIoTC as App, LedsC, new PhotoC() as Sensor;
  components ActiveMessageC, SerialActiveMessageC;
  components new SerialAMSenderC(AM_TP_IOT);
  components new SerialAMReceiverC(AM_TP_IOT);
  components new AMSenderC(AM_TP_IOT);
  components new AMReceiverC(AM_TP_IOT);
  components new TimerMilliC();

  App.MilliTimer -> TimerMilliC;
  App.Boot -> MainC.Boot;

  App.UartReceive -> SerialAMReceiverC;
  App.UartSend -> SerialAMSenderC;
  App.AMSerialControl -> SerialActiveMessageC;
  
  App.Receive -> AMReceiverC;
  App.AMSend -> AMSenderC;
  App.AMControl -> ActiveMessageC;
  
  App.Leds -> LedsC;
  App.Packet -> AMSenderC;
  App.Read -> Sensor;

}
