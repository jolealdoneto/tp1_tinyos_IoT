COMPONENT=TPIoTAppC
BUILD_EXTRA_DEPS = TPIoT.py

TPIoT.py: TPIoT.h
	mig python -target=$(PLATFORM) $(CFLAGS) -python-classname=TPIoT TPIoT.h tp_iot -o $@

TPIoT.class: TPIoT.java
	javac TPIoT.java

include $(MAKERULES)

