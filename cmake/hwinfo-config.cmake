# HWINFO CMake configuration file:
# This file is meant to be placed in a cmake subfolder of HWINFO-devel-2.x.y-VC

cmake_minimum_required(VERSION 3.0)

include(FeatureSummary)
set_package_properties(HWINFO PROPERTIES
    URL "https://www.g10.app/status#miscellaneous"
    DESCRIPTION "hardware info"
)

# Copied from `configure_package_config_file`
macro(set_and_check _var _file)
    set(${_var} "${_file}")
    if(NOT EXISTS "${_file}")
        message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
    endif()
endmacro()

# Copied from `configure_package_config_file`
macro(check_required_components _NAME)
    foreach(comp ${${_NAME}_FIND_COMPONENTS})
        if(NOT ${_NAME}_${comp}_FOUND)
            if(${_NAME}_FIND_REQUIRED_${comp})
                set(${_NAME}_FOUND FALSE)
            endif()
        endif()
    endforeach()
endmacro()

set(HWINFO_FOUND TRUE)

# For compatibility with autotools HWINFO-config.cmake, provide HWINFO_* variables.

set_and_check(HWINFO_PREFIX       "${CMAKE_CURRENT_LIST_DIR}/..")
set_and_check(HWINFO_EXEC_PREFIX  "${CMAKE_CURRENT_LIST_DIR}/..")
set_and_check(HWINFO_INCLUDE_DIR  "${HWINFO_PREFIX}/include")
set(HWINFO_INCLUDE_DIRS           "${HWINFO_INCLUDE_DIR}")
set_and_check(HWINFO_BINDIR       "${CMAKE_CURRENT_LIST_DIR}/../build/Debug/")
set_and_check(HWINFO_LIBDIR       "${CMAKE_CURRENT_LIST_DIR}/../build/Debug/")

set(HWINFO_LIBRARIES hwinfo::hwinfo)

# All targets are created, even when some might not be requested though COMPONENTS.
# This is done for compatibility with CMake generated HWINFO-target.cmake files.

set(_HWINFO_library     "${HWINFO_LIBDIR}/hwinfo.lib")
set(_HWINFO_dll_library "${HWINFO_BINDIR}/hwinfo.dll")
if(EXISTS "${_HWINFO_library}" AND EXISTS "${_HWINFO_dll_library}")
    if(NOT TARGET hwinfo::hwinfo)
        add_library(hwinfo::hwinfo SHARED IMPORTED)
        set_target_properties(hwinfo::hwinfo
            PROPERTIES
                INTERFACE_INCLUDE_DIRECTORIES "${HWINFO_INCLUDE_DIRS}"
                IMPORTED_IMPLIB "${_HWINFO_library}"
                IMPORTED_LOCATION "${_HWINFO_dll_library}"
                COMPATIBLE_INTERFACE_BOOL "HWINFO_SHARED"
                INTERFACE_HWINFO_SHARED "ON"
        )
    endif()
    set(HWINFO_HWINFO_FOUND TRUE)
else()
    set(HWINFO_HWINFO_FOUND FALSE)
endif()
unset(_HWINFO_library)
unset(_HWINFO_dll_library)

check_required_components(HWINFO)
