# Need CMake 3.28
cmake_minimum_required (VERSION 3.28.0)

# This is the name of the repository
project ("hardware info")

# Set the correct paths
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)
set(CMAKE_PREFIX_PATH ${CMAKE_SOURCE_DIR}/extern/)

# Comment out for Debug mode
set(IS_DEBUG_BUILD CMAKE_BUILD_TYPE STREQUAL "Debug")

# Set debug mode
if (${IS_DEBUG_BUILD})
    add_compile_definitions(NDEBUG)
endif()

# Add the hardware info project
if ( NOT "${HAS_HWINFO}")

    # Log
    message("[hardware info] Adding hardware info project")

    # Set the include directory
    set (HWINFO_INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/include)

    # Let any parent project know that it has the hardware info project
    if(NOT PROJECT_IS_TOP_LEVEL)
        set(HAS_HWINFO true PARENT_SCOPE)
        set(HWINFO_INCLUDE_DIR ${HWINFO_INCLUDE_DIR} PARENT_SCOPE)
    endif()
endif()


set(CMAKE_ASM_NASM_CREATE_SHARED_LIBRARY
  "ld -lc -shared  <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
enable_language(ASM_NASM)

set_source_files_properties("cpu-info.asm" PROPERTIES LANGUAGE ASM_NASM)

# Add source to this project's executable.
add_executable(hwinfo_example "main.c")
add_dependencies(hwinfo_example hwinfo)
target_include_directories(hwinfo_example PUBLIC ${HWINFO_INCLUDE_DIR})
target_link_libraries(hwinfo_example hwinfo)

# Add source to the library
add_library(hwinfo SHARED "cpu-info.asm")
target_include_directories(hwinfo PUBLIC ${HWINFO_INCLUDE_DIR})
