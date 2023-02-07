set(openvoiceshell_SRCS openvoiceshellplugin.cpp configuration.cpp placesmodel.cpp)

include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_library(openvoiceshellplugin SHARED ${openvoiceshell_SRCS} ${RESOURCES})

target_link_libraries(openvoiceshellplugin
    Qt${QT_MAJOR_VERSION}::Core
    Qt${QT_MAJOR_VERSION}::Quick
    Qt${QT_MAJOR_VERSION}::Qml
    Qt${QT_MAJOR_VERSION}::DBus
    KF6::GuiAddons
    KF6::ConfigWidgets
)

########### install files ###############
install(TARGETS openvoiceshellplugin DESTINATION ${KDE_INSTALL_QMLDIR}/OVOSPlugin)
install(FILES qmldir DESTINATION ${KDE_INSTALL_QMLDIR}/OVOSPlugin)
install(FILES plugins.qmltypes DESTINATION ${KDE_INSTALL_QMLDIR}/OVOSPlugin)
