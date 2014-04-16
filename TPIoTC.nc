#include "TPIoT.h"

module TPIoTC @safe(){
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Packet;
    interface Read<uint16_t>;
    interface SplitControl as RadioControl;
  }
}
implementation {

  message_t packet;
  bool locked = FALSE;
  /* O ID do nó pai, onde ele deve enviar as informações */
  uint16_t root_node;
  
   
  event void Boot.booted() {
    call RadioControl.start();
  }

  event void RadioControl.startDone(error_t err) {
    if (err == SUCCESS) {
      root_node = -1;
    }
  }
  event void RadioControl.stopDone(error_t err) {}
  event void Read.readDone(error_t result, uint16_t data) {}

  task void sendBroadcast() {
    tp_iot_t* rsm = (tp_iot_t*)call Packet.getPayload(&packet, sizeof(tp_iot_t));
    if (rsm == NULL) {
      return;
    }
    // coloco o meu node id
    rsm->sender_nodeid = TOS_NODE_ID;
    rsm->message_type = MESSAGE_BROADCAST;
    call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(tp_iot_t));
  }
  task void sendToRoot() {
    call AMSend.send(root_node, &packet, sizeof(tp_iot_t));
  }

  void assignRootAndSendInfo(uint16_t sender_nodeid) {
    tp_iot_t* rsm = (tp_iot_t*)call Packet.getPayload(&packet, sizeof(tp_iot_t));
    if (rsm == NULL) {
      return;
    }
    root_node = sender_nodeid;
    rsm->sender_nodeid = TOS_NODE_ID;
    rsm->data = 2;
    rsm->message_type = MESSAGE_SENSEDINFO;

    post sendToRoot();
  }

  void forwardInfo(tp_iot_t* message) {
    tp_iot_t* rsm = (tp_iot_t*)call Packet.getPayload(&packet, sizeof(tp_iot_t));
    if (rsm == NULL) {
      return;
    }
    rsm->sender_nodeid = rsm->sender_nodeid;
    rsm->data = rsm->data;
    rsm->message_type = rsm->message_type;

    post sendToRoot();
  }

  event message_t* Receive.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    // checar o tamanho da msg
    if (len != sizeof(tp_iot_t)) {return bufPtr;}
    else {
      tp_iot_t* rsm = (tp_iot_t*)payload;

      // se a mensagem é de flooding e o nó não possui pai
      if (rsm->message_type == MESSAGE_BROADCAST) {
	if (root_node == -1 || rsm->sender_nodeid == root_node) {
	  assignRootAndSendInfo(rsm->sender_nodeid);
	  post sendBroadcast();
	}
      }
      else if (rsm->message_type == MESSAGE_SENSEDINFO) {
	forwardInfo(rsm);
      }

      return bufPtr;
    }
  }

  event void AMSend.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }
}
