# This module defines
# CLARABEL_FOUND, if false, do not try to link to CLARABEL
# CLARABEL_LIBRARIES, the names of the libraries to link against (w/o the '-l')
# CLARABEL_INCLUDE_DIRS, the include preprocessor flags (w/o the '-I')
# In addition it defines the target CLARABEL::clarabel.

if(NOT TARGET CLARABEL::clarabel)
    find_package(PkgConfig REQUIRED)
    pkg_check_modules(CLARABEL REQUIRED Clarabel)
    set(CLARABEL_LIBRARIES_FULL_PATHS "")
    foreach(CLARABEL_LIB ${CLARABEL_LIBRARIES})
        find_library(CLARABEL_LIBRARY_FULL_PATH_${CLARABEL_LIB}
            NAMES ${CLARABEL_LIB}
            PATHS ${CLARABEL_LIBRARY_DIRS}
        )
        list(APPEND CLARABEL_LIBRARIES_FULL_PATHS ${CLARABEL_LIBRARY_FULL_PATH_${CLARABEL_LIB}})
        unset(CLARABEL_LIBRARY_FULL_PATH_${CLARABEL_LIB})
    endforeach()
    unset(CLARABEL_LIB)
    add_library(CLARABEL::clarabel INTERFACE IMPORTED)
    set_target_properties(CLARABEL::clarabel PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${CLARABEL_INCLUDE_DIRS}"
        INTERFACE_LINK_LIBRARIES "${CLARABEL_LIBRARIES_FULL_PATHS}"
        INTERFACE_COMPILE_OPTIONS "${CLARABEL_CFLAGS};${CLARABEL_CFLAGS_OTHER}"
    )
    unset(CLARABEL_LIBRARIES_FULL_PATHS)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CLARABEL DEFAULT_MSG
    CLARABEL_FOUND
    CLARABEL_LIBRARIES
    CLARABEL_INCLUDE_DIRS
)

