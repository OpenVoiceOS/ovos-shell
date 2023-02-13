set(OpenVoiceStyle_SRCS
    ovostheme.cpp
    ovosthemeunits.cpp
    kirigamiplasmafactory.cpp
)

kcoreaddons_add_plugin(OpenVoiceStyle SOURCES ${OpenVoiceStyle_SRCS} INSTALL_NAMESPACE "kf6/kirigami" JSON ovostheme.json)

target_link_libraries(OpenVoiceStyle
    PUBLIC
        Qt::Core
        KF6::Kirigami2
    PRIVATE
        Qt::DBus
        Qt::Qml
        Qt::Quick
        KF6::GuiAddons
        KF6::ConfigWidgets
        KF6::IconThemes
)

install(FILES Theme.qml DESTINATION ${KDE_INSTALL_QMLDIR}/org/kde/kirigami.2/styles/OpenVoiceStyle)
