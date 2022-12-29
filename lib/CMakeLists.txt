set(openvoiceshell_SRCS openvoiceshellplugin.cpp configuration.cpp placesmodel.cpp)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_library(openvoiceshellplugin SHARED ${openvoiceshell_SRCS} ${RESOURCES})

target_link_libraries(openvoiceshellplugin
    Qt5::Core
    Qt5::Quick
    Qt5::Qml
    Qt5::DBus
    KF5::GuiAddons
    KF5::ConfigWidgets
)

########### install files ###############
install(TARGETS openvoiceshellplugin DESTINATION ${KDE_INSTALL_QMLDIR}/OVOSPlugin)
install(FILES qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/OVOSPlugin)
install(FILES plugins.qmltypes DESTINATION ${KDE_INSTALL_QMLDIR}/OVOSPlugin)
