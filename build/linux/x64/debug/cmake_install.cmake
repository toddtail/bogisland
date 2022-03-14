# Install script for directory: /home/ephf/Project/flutter/bogisland/linux

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/")
  
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island"
         RPATH "$ORIGIN/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle" TYPE EXECUTABLE FILES "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/intermediates_do_not_run/bog_island")
  if(EXISTS "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island"
         OLD_RPATH "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/plugins/url_launcher_linux:/home/ephf/Project/flutter/bogisland/linux/flutter/ephemeral:"
         NEW_RPATH "$ORIGIN/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/bog_island")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/data" TYPE FILE FILES "/home/ephf/Project/flutter/bogisland/linux/flutter/ephemeral/icudtl.dat")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/lib/libflutter_linux_gtk.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/lib" TYPE FILE FILES "/home/ephf/Project/flutter/bogisland/linux/flutter/ephemeral/libflutter_linux_gtk.so")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/lib/liburl_launcher_linux_plugin.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/lib" TYPE FILE FILES "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/plugins/url_launcher_linux/liburl_launcher_linux_plugin.so")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/data/flutter_assets")
  
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/bundle/data" TYPE DIRECTORY FILES "/home/ephf/Project/flutter/bogisland/build//flutter_assets")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/flutter/cmake_install.cmake")
  include("/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/plugins/url_launcher_linux/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/ephf/Project/flutter/bogisland/build/linux/x64/debug/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
