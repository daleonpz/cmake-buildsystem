# daleonpz 2024, Apache License 2.0

#############################
# STM32F446G-DISCO CMake    #
#############################

if(STM32746G_Discovery_TOOLCHAIN_INCLUDED)
    return()
endif()

set(STM32746G_Discovery_TOOLCHAIN_INCLUDED true)

# Set the toolchain path
set(TOOLCHAIN_PATH /home/dnl/Documents/stm32/st/GNU-tools-for-STM32/bin/)

# Add the toolchain to the PATH
list(APPEND CMAKE_PROGRAM_PATH ${TOOLCHAIN_PATH})

# Set the CPU name
set(CPU_NAME STM32F746NGHx)

# Set the linker script directory and file
set(LINKER_SCRIPT_DIR ${CMAKE_SOURCE_DIR}/src/SW4STM32/STM32746G_DISCOVERY)
set(LINKER_SCRIPT_PRIMARY_FILE STM32F746NGHx_FLASH.ld)

message(STATUS "Using linker script: ${LINKER_SCRIPT_DIR}/${LINKER_SCRIPT_PRIMARY_FILE}")

# These dependencies are applied to add_executable targets by the
# AddExecutableWithLinkerScriptDep module
list(APPEND LINKER_SCRIPT_DEPENDENCIES "${LINKER_SCRIPT_DIR}/${LINKER_SCRIPT_PRIMARY_FILE}")

# Set the linker flags
set(LD_FLAGS "-T${LINKER_SCRIPT_DIR}/${LINKER_SCRIPT_PRIMARY_FILE}" )

# Include the cortex-m7 configuration
include(${CMAKE_CURRENT_LIST_DIR}/cortex-m7_hardfloat.cmake)
