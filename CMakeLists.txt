cmake_minimum_required(VERSION 3.15)
project(LibraryFindPackage VERSION 0.1.0 LANGUAGES C CXX)

# This is basically telling CMake to set the environment variable CMAKE_PREFIX_PATH
# are set to this specific directory path, and where the dependencies are located
list(APPEND CMAKE_PREFIX_PATH ~/Desktop/LibraryFindPackage)

# Add the installation prefix to CMAKE_PREFIX_PATH
set(CMAKE_PREFIX_PATH ~/Desktop/LibraryFindPackage)

# Set the correct directory for CMAKE_MODULE_PATH
set(CMAKE_MODULE_PATH ~/Desktop/LibraryFindPackage/cmake)

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG true)


# What we did to compile and install this library onto our system
# cmake ..
# Then do: sudo make install

set(
    all_src
    include/Foo.cpp
    include/Foo.h
)

add_library(${PROJECT_NAME} ${all_src})
add_library(LibFindPackage::LibFindPackage ALIAS ${PROJECT_NAME})

# These expressions here are called generated expressions for CMake.
# They allow us to have builds and installs in different contextual builds. Such as if directories are consistently required.
# Though Generated Expressions, are basically what allow you to dynamically include or exclude directories based on certain conditions or
#   properties depending on build configurations. Allowing for a more fine-grained control andd customization towards your build and installation.

# Other words generated expressions provide a way to conditionally specify dirs and properties based on the context given in CMake making
# build systems flexible and adaptable to different situations.
target_include_directories(${PROJECT_NAME} PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}-targets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

# Our default location is /usr/local
# So, when we are installing a file we specify that this is going to be a file like shown below with FILE ${PROJECT_NAME}-config.cmake
# we basically through this function are telling CMake to install this file, and using DESTINATION keyword to tell that this file must be installed
# to the cmake directory in the default path, which is: /usr/local/cmake
install(EXPORT ${PROJECT_NAME}-targets
    FILE ${PROJECT_NAME}-config.cmake
    DESTINATION cmake
)

# When we specify FILES
# This means that we want to install(add the specified files) to the include directory (which is located where the default path)
# NOTE: The default path, is where find_package will mostly find all it's dependencies, which on
#   M1 mac, it would be the /usr/local directory. If you see an include directory of some kind it would be because
#   the DESTINATION that we set is a directory called include (and if this doesn't exist, then one would be created)

install(FILES include/Foo.h DESTINATION include)