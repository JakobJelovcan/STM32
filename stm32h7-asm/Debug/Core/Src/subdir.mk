################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (10.3-2021.10)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Core/Src/DMA.s \
../Core/Src/GPIO.s \
../Core/Src/Main.s \
../Core/Src/SysTick.s \
../Core/Src/USART.s 

OBJS += \
./Core/Src/DMA.o \
./Core/Src/GPIO.o \
./Core/Src/Main.o \
./Core/Src/SysTick.o \
./Core/Src/USART.o 

S_DEPS += \
./Core/Src/DMA.d \
./Core/Src/GPIO.d \
./Core/Src/Main.d \
./Core/Src/SysTick.d \
./Core/Src/USART.d 


# Each subdirectory must supply rules for building sources it contributes
Core/Src/%.o: ../Core/Src/%.s Core/Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m7 -g3 -DDEBUG -c -list -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Core-2f-Src

clean-Core-2f-Src:
	-$(RM) ./Core/Src/DMA.d ./Core/Src/DMA.o ./Core/Src/GPIO.d ./Core/Src/GPIO.o ./Core/Src/Main.d ./Core/Src/Main.o ./Core/Src/SysTick.d ./Core/Src/SysTick.o ./Core/Src/USART.d ./Core/Src/USART.o

.PHONY: clean-Core-2f-Src

