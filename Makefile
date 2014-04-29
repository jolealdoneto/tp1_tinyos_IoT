COMPONENT=TPIoTAppC
BUILD_EXTRA_DEPS = TPIoT.py TPIoT.class TPIoT.java
SENSORBOARD=mda100
PFLAGS+=-DRF230_DEF_RFPOWER=1

TPIoT.py: TPIoT.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=TPIoT TPIoT.h tp_iot -o $@

TPIoT.class: TPIoT.java
	javac TPIoT.java

TPIoT.java: TPIoT.h
	mig java -target=$(PLATFORM) $(CFLAGS) -java-classname=TPIoT TPIoT.h tp_iot -o $@

include $(MAKERULES)

