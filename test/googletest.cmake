#################
# GTest Module #
#################
# This module simplifies the process of adding Catch2 testing support to your build.
#
# You can link against the `googletest_dep` library to access the dependency
#
include(${CMAKE_CURRENT_LIST_DIR}/../CPM.cmake)

## Set Default Options
if(NOT GOOGLETEST_INCLUDE_DIR)
    set(GOOGLETEST_INCLUDE_DIR ${CMAKE_BINARY_DIR}/test/ CACHE STRING "Location of the GTest include directory.")
endif()

######################
# Satisfy Dependency #
######################
CPMAddPackage(
  NAME GTest
  GITHUB_REPOSITORY google/googletest
  GIT_TAG release-1.12.1
  VERSION 1.12.1
  OPTIONS
    "INSTALL_GTEST OFF"
    "gtest_force_shared_crt ON"
    "BUILD_GMOCK ON"
)

# Define a build target that users can link against to build a googletest program
add_library(googletest_dep INTERFACE)
target_link_libraries(googletest_dep INTERFACE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)

target_include_directories(googletest_dep INTERFACE ${GOOGLETEST_INCLUDE_DIR})

# Function to register GoogleTest tests
function(register_google_test test_name target)
  # Add the test to CTest
  add_test(NAME ${test_name}
    COMMAND ${target}
  )

  # Add a custom target to run the tests
  add_custom_target(test-${target}
    COMMAND ${target}
  )

  # Set properties for the test
  set_tests_properties(${test_name}
    PROPERTIES
      DEPENDS ${target}
  )
endfunction()

