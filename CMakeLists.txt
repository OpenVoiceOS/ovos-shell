# Set minimum CMake version (required for CMake 3.0 or later)
cmake_minimum_required(VERSION 3.15.0)

set(QT_MIN_VERSION "5.9.0")
set(KF5_MIN_VERSION "5.50.0")
set(KIRIGAMI_LEGACY OFF)

PROJECT(mycroft-gui)

# Use Extra CMake Modules (ECM) for common functionality.
# See http://api.kde.org/ecm/manual/ecm.7.html
# and http://api.kde.org/ecm/manual/ecm-kde-modules.7.html
IF(POLICY CMP0063)
    CMAKE_POLICY(SET CMP0063 NEW)
ENDIF(POLICY CMP0063)

find_package(ECM 1.6.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(ECMInstallIcons)
set(CMAKE_AUTOMOC ON)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall -Werror")

#this is used for mycroft spawning. It's horrible and should not be needed, but mycroft packaging is questionable at best
#in any sane world mycroft would install something in $PATH
#the Android case is a temporary hack, adjust it to where and android app can find
set(MYCROFT_CORE_DIR "~/mycroft-core")


#configure_file(config-mycroft.h.in ${CMAKE_CURRENT_BINARY_DIR}/config-mycroft.h)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

find_package(Qt5 ${QT_MIN_VERSION} CONFIG REQUIRED COMPONENTS
    Quick
    Core
    Qml
    Network
    WebView
    Widgets
)

find_package(KF5DBusAddons ${KF5_MIN_VERSION} REQUIRED)

find_package(KF5 ${KF5_MIN_VERSION} REQUIRED COMPONENTS I18n Kirigami2 GuiAddons CoreAddons Config ConfigWidgets IconThemes)

add_definitions(-DQT_DISABLE_DEPRECATED_BEFORE=0)

#add_definitions(-Wno-deprecated)

add_definitions(-DQT_NO_URL_CAST_FROM_STRING -DQT_USE_QSTRINGBUILDER -DQT_NO_CAST_TO_ASCII -DQT_NO_CAST_FROM_ASCII)

add_subdirectory(application)
add_subdirectory(lib)

if(KF5Kirigami2_VERSION VERSION_LESS 5.91.0)
    add_subdirectory(theme-legacy)
else()
    add_subdirectory(theme)
endif()

add_subdirectory(schemes)
