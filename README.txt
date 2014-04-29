== TP-IoT ==

= Resources =
* Best one - http://www.tinyos.net/dist-2.0.0/tinyos-2.x/doc/html/tutorial/lesson4.html

= Environment =
- For serial forwarder:
    $ export MOTECOM=sf@localhost:9002
- For serial using iris:
    $ export MOTECOM=serial@/dev/ttyUSB1:57600

- Compiling
    $ make iris
- Compiling and deploy
    $ make iris install,<NODE_ID> mib520,/dev/ttyUSB0

- Sending package:
    $ java net.tinyos.tools.Send 00 FF FF FF 01 08 3F 07 00 02 FF FF 00 00 00 08
