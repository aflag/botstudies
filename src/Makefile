include config.mk

# Building configuration
F_CPU=16000000UL
MCU=atmega328p
CFLAGS=-Wall -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU)
CXXFLAGS =-Wall -Os -DF_CPU=$(F_CPU) -mmcu=$(MCU)
BIN_FORMAT=ihex
CONFFILE=lib/avrdude.conf

# Additional library
LIB_DIR=lib
LIB=$(LIB_DIR)/core.a
SRC =  $(LIB_DIR)/pins_arduino.c $(LIB_DIR)/wiring.c \
$(LIB_DIR)/wiring_analog.c $(LIB_DIR)/wiring_digital.c \
$(LIB_DIR)/wiring_pulse.c $(LIB_DIR)/wiring_shift.c\
$(LIB_DIR)/WInterrupts.c
CXXSRC = $(LIB_DIR)/HardwareSerial.cpp $(LIB_DIR)/WMath.cpp\
$(LIB_DIR)/Print.cpp $(LIB_DIR)/cxx_pure_virtual.cpp

OBJ = $(SRC:.c=.o) $(CXXSRC:.cpp=.o)

.PHONY: upload
upload: $(target).hex
	$(AVRDUDE) -c $(PROTOCOL) -p $(PART) -P $(PORT) -b $(BAUD) -U flash:w:$< -C $(CONFFILE)

$(LIB): $(OBJ)
	@for i in $(OBJ); do echo $(AR) rcs $(LIB) $$i; $(AR) rcs $(LIB) $$i; done

.PHONY: clean clean-all
clean:
	$(RM) *.hex *.s *.elf
clean-all: clean
	$(RM) $(OBJ) $(LIB)

%.hex: %.elf
	$(OBJCOPY) -O $(BIN_FORMAT) -R .eeprom $< $@
%.elf: %.s $(LIB)
	$(CXX) $(CFLAGS) -s -o $@ $< -L. $(LIB)
%.s: %.c
	$(CXX) $(CFLAGS) -S -o $@ $<
%.c: %.pde
	@echo '#include "lib/WProgram.h"' > $@
	@cat $< lib/main.cxx >> $@
