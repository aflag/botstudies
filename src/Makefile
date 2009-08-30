# External programs
CC=avr-gcc-43
CXX=avr-g++-43
AR=avr-ar
OBJCOPY=avr-objcopy
AVRDUDE=avrdude -F -V
RM=rm -f

# Upload configuration
PORT=/dev/cuaU0
BAUD=57600
PROTOCOL=stk500v1
PART=m328p

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
CXXSRC = $(LIB_DIR)/HardwareSerial.cpp $(LIB_DIR)/WMath.cpp

OBJ = $(SRC:.c=.o) $(CXXSRC:.cpp=.o)

$(LIB): $(OBJ)
	@for i in $(OBJ); do echo $(AR) rcs $(LIB) $$i; $(AR) rcs $(LIB) $$i; done

.PHONY: all
all: blink.hex

blink.hex: blink.elf

blink.elf: blink.s

blink.s: blink.c

.PHONY: clean
clean:
	$(RM) blink.elf blink.hex blink.s

.PHONY: upload
upload: blink.hex
	$(AVRDUDE) -c $(PROTOCOL) -p $(PART) -P $(PORT) -b $(BAUD) -U flash:w:$< -C $(CONFFILE)

%.elf: %.s ; $(CC) $(CFLAGS) -s -o $@ $<

%.s: %.c ; $(CC) $(CFLAGS) -S -o $@ $<

%.hex: %.elf ; $(OBJCOPY) -O $(BIN_FORMAT) -R .eeprom $< $@
