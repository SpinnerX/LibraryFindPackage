## Description
Figuring out how find_package works, and exporting as well simplifying how to import find_package(<LibraryName> ...)

## Things Learned
1.) One thing to note is that if you want configure find_package for your library project, find_package has a default filepath that
    it points to. In this case on M1 mac the filepath would be "/usr/local", but if you wanted to know the CMAKE_INSTALL_PREFIX
    then you type the command "ccmake .", the dot(.) referencing to current dir (just in case). Ccmake is how you can see the configs
    for CMake, and the default setting that CMake uses for a lot of its find_packages when calling libraries, and things like that

## Cmake Modules
2.) Second, is that when doing exporting/importing find_package. Definitely should organize the projects to using cmake modules 
    as in a dir called cmake, and a bunch cmake files containing either different library configs, third party library configurations in the CMake.


## `<LibraryName>Config.cmake`
3.) The most important to note, when doing modules and trying to get find_package working, is make sure you have a cmake Congif file like the on
    in cmake directory in this repo. In the format of <Libraryname>Config.cmake. The reason for this is because when you install the CMake modules from cmake
    directory, these will go either to the default/customized (if adjustments made) filepath. So, in this case if your on M1 mac, then  the Config would go into
    /usr/local/cmake. Hence, if you look at the CMakeLists.txt file it shows the install(), of installing files from cmake dir to cmake dir in /usr/local

## Commands to Run (Installation)
4.) When trying to compile and run/install the library you can pretty muchh just do this:

`cd build && cmake ..` - In build directory compile cmake \
`sudo make install` - Then, you use sudo if necessary, and then do make install and will install what you configured in
the cmake onto your system, and if settings are default like filepath, etc. Thenthose files would go into cmake in `/usr/local` \
or include in `/usr/local`. 
