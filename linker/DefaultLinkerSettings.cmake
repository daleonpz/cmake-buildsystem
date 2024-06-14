###########################
# Default Linker Settings #
###########################
#
# This module applies linker flags that are commonly used on Embedded Artistry projects.

include(${CMAKE_CURRENT_LIST_DIR}/../compiler/CheckAndApplyFlags.cmake)

set(desired_common_linker_optimization_flags
	# This seems to cause problems with GCC...
	#-Wl,-dead_strip # Strip dead symbols for OS X
	-Wl,--gc-sections # Strip dead sections for GCC
    -Wl,--print-gc-sections # Print out the sections that were stripped
    -Wl,--print-memory-usage # Print out memory usage
)

####################################################
# Settings enforced when we're the primary project #
####################################################

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  apply_supported_linker_flags_globally(C desired_common_linker_optimization_flags)
  apply_supported_linker_flags_globally(CXX desired_common_linker_optimization_flags)
endif()

####################################
# Settings enforced no matter what #
####################################

