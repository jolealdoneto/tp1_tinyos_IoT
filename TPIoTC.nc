#include "AM.h"
#include "Serial.h"
#include "TPIoT.h"

module TPIoTC @safe(){
  uses {
    interface Leds;
    interface Boot;
    interface Packet;
    interface SplitControl as AMSerialControl;
    interface SplitControl as AMControl;

    interface Receive as UartReceive;
    interface AMSend as UartSend;
    
    interface Receive;
    interface AMSend;
    interface Packet as RadioPacket;
    interface AMPacket as RadioAMPacket;

    interface Timer<TMilli> as MilliTimer;
    interface Read<uint16_t>;

  }
}
implementation {
  // booleans que simplesmente guardam estado sobre o envio/sensoriamento
  bool radioBusy, uartBusy, shouldSendBroadcastAfterFinish, sensorLocked;
  message_t packet;
  /* O ID do nó pai, onde ele deve enviar as informações */
  uint16_t root_node;

  event void Boot.booted() {
    uartBusy = FALSE;
    radioBusy = FALSE;
    shouldSendBroadcastAfterFinish = FALSE;
    sensorLocked = FALSE;

    call AMControl.start();
    call AMSerialControl.start();

    call Leds.led0Off();
    call Leds.led1Off();
    call Leds.led2Off();
  }


  event void AMControl.startDone(error_t error) {
    if (error == SUCCESS) {
      root_node = -1;
      call MilliTimer.startPeriodic(1000);
    }
  }

  event void AMSerialControl.startDone(error_t error) {
    if (error == SUCCESS) { }
  }

  event void AMSerialControl.stopDone(error_t error) {}
  event void AMControl.stopDone(error_t error) {}

  uint8_t count = 0;

  message_t* receive(message_t *msg, void *payload, uint8_t len);
  event message_t* Receive.receive(message_t *msg, void *payload, uint8_t len) {
    return receive(msg, payload, len);
  }

  uint8_t tmpLen;
  
  event void UartSend.sendDone(message_t* msg, error_t error) {
    uartBusy = FALSE;
  }

  task void sendBroadcast();

  event void MilliTimer.fired() {
    if (TOS_NODE_ID == 1) {
      dbg("TPIoT", "TPIoTc: timer fired, counter\n");
      //call Leds.led0Toggle();
      //post sendBroadcast();
    }
  }

  event message_t *UartReceive.receive(message_t *msg, void *payload, uint8_t len) {
    call Leds.led0Toggle();
    post sendBroadcast();

    return msg;
  }

  event void AMSend.sendDone(message_t* msg, error_t error) {
    radioBusy = FALSE;
    atomic {
      if (shouldSendBroadcastAfterFinish) {
	shouldSendBroadcastAfterFinish = FALSE;
	post sendBroadcast();
      }
    }
  }
  
  task void sendBroadcast() {
    tp_iot_t* rsm;

    if (radioBusy) return;

    rsm = (tp_iot_t*)call Packet.getPayload(&packet, sizeof(tp_iot_t));
    if (rsm == NULL) {
      return;
    }
    // coloco o meu node id
    rsm->sender_nodeid = TOS_NODE_ID;
    rsm->addressee_nodeid = MESSAGE_BROADCAST;
    call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(tp_iot_t));
  }
  task void sendToRoot() {
    if (radioBusy) {
      return;
    }
    
    if (TOS_NODE_ID != 1) {
      call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(tp_iot_t));
    } else {
      call UartSend.send(AM_BROADCAST_ADDR, &packet, sizeof(tp_iot_t));
    }
  }

  void assignRootAndSendInfo(uint16_t sender_nodeid) {
    if (sensorLocked) return;

    root_node = sender_nodeid;
    call Read.read();
  }

  void forwardInfo(tp_iot_t* message) {
    tp_iot_t* rsm = (tp_iot_t*)call Packet.getPayload(&packet, sizeof(tp_iot_t));
    tp_iot_t* receivedMessage = message;
    if (rsm == NULL) {
      return;
    }
    rsm->sender_nodeid = receivedMessage->sender_nodeid;
    rsm->data = receivedMessage->data;
    rsm->addressee_nodeid = root_node;

    post sendToRoot();
  }

  message_t* receive(message_t *msg, void *payload, uint8_t len) {
    // checar o tamanho da msg
    if (len != sizeof(tp_iot_t)) {
      return msg;
    }
    else {
      tp_iot_t* rsm = (tp_iot_t*)payload;

      // se a mensagem é de flooding e o nó não possui pai
      if (rsm->addressee_nodeid == MESSAGE_BROADCAST) {
	call Leds.led1Toggle();
	if ((root_node == -1 && TOS_NODE_ID != 1) || rsm->sender_nodeid == root_node) {
	  assignRootAndSendInfo(rsm->sender_nodeid);
	}
      }
      else if (rsm->addressee_nodeid == TOS_NODE_ID) {
	call Leds.led2Toggle();
	forwardInfo(rsm);
      }

      return msg;
    }
  }
  event void Read.readDone(error_t result, uint16_t data) {
    sensorLocked = FALSE;
    call Leds.led2Toggle();
    if (result == SUCCESS){
      tp_iot_t* rsm = (tp_iot_t*)call Packet.getPayload(&packet, sizeof(tp_iot_t));
      if (rsm == NULL) {
	return;
      }
      rsm->sender_nodeid = TOS_NODE_ID;
      rsm->data = data;
      rsm->addressee_nodeid = root_node;

      shouldSendBroadcastAfterFinish = TRUE;
      post sendToRoot();
    }
  }
}
