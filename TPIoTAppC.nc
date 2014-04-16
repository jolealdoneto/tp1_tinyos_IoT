#include "TPIoT.h"

configuration TPIoTAppC {}
implementation {
  components MainC, TPIoTC as App, LedsC, new DemoSensorC();
  components ActiveMessageC;
  components new AMSenderC(AM_RADIO_SENSE_MSG);
  components new AMReceiverC(AM_RADIO_SENSE_MSG);
  
  App.Boot -> MainC.Boot;
  
  App.Receive -> AMReceiverC;
  App.AMSend -> AMSenderC;
  App.RadioControl -> ActiveMessageC;
  App.Leds -> LedsC;
  App.Packet -> AMSenderC;
  App.Read -> DemoSensorC;
}
