# pde filename
target=mouse

# External programs
CC=avr-gcc
CXX=avr-g++
AR=avr-ar
OBJCOPY=avr-objcopy
AVRDUDE=avrdude -F -V
RM=rm -f

# Upload configuration
PORT=/dev/ttyUSB0
BAUD=57600
PROTOCOL=stk500v1
PART=m328p
