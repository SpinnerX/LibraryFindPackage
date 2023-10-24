
################################################################################################################################

#<library_name>Config.cmake
# This allows us to configure the library
# Meaning, by showing CMake where all our source, files, dependencies are going to be located
# in our file structures

################################################################################################################################

# configure_file(
#   ${CMAKE_SOURCE_DIR}/LibraryFindPackage/version.h.in
#   ${CMAKE_BINARY_DIR}/LibraryFindPackage/version.h
#   @ONLY
# )

# Reset the CMake module path to its state when this script was called.
set(CMAKE_MODULE_PATH ${CALLERS_CMAKE_MODULE_PATH})
set(LIBRARY_FIND_PACKAGE_INCLUDE_DIRS "${CMAKE_INSTALL_PREFIX}/include")
set(LIBRARY_FIND_PACKAGE_LIBRARIES "${CMAKE_INSTALL_PREFIX}/lib/lib${PROJECT_NAME}.a")

# Provide the include and library directories to the config file
list(APPEND LIBRARYFINDPACKAGE_INCLUDE_DIRS "${LIBRARYFINDPACKAGE_INCLUDE_DIRS}")
set(LIBRARYFINDPACKAGE_INCLUDE_DIRS ${LIBRARY_FIND_PACKAGE_INCLUDE_DIRS} PARENT_SCOPE)
set(LIBRARYFINDPACKAGE_LIBRARIES ${LIBRARY_FIND_PACKAGE_LIBRARIES} PARENT_SCOPE)

# These are going to let cmake know that when we configure this project
# We are going to tell CMake, that here are our configuration cmake files for the library.
set(
  LIBRARY_MODULE_FILES
  LibraryFindPackageConfig.cmake
)

## find relative path to make package relocatable
# this is a bit involved to handle these cases:
#   - CMAKE_INSTALL_LIBDIR is overridden by the user
#   - CMAKE_INSTALL_LIBDIR contains multiple levels for Debian multiarch support
if (IS_ABSOLUTE "${CMAKE_INSTALL_PREFIX}")
  set(ABS_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
else()
  get_filename_component(ABS_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}" ABSOLUTE)
endif()