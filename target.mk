
# make TARGET=linaro_stm32 will include target_linaro_stm32.mk
ifneq ("$(wildcard $(PROJECT_ROOT)/target_$(TARGET).mk)","")
$(info include target_$(TARGET).mk)
include $(PROJECT_ROOT)/target_$(TARGET).mk
else
#Default or wrong arg, use pc/linux
$(info include target_gcc_linux.mk)
include $(PROJECT_ROOT)/target_gcc_linux.mk
TARGET=gcc_linux
endif

CFLAGS+=-DTARGET=\"$(TARGET)\"

