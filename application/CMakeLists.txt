PROJECT(ovos-shell)

SET(ovos-shell_SRC
    main.cpp
    appsettings.cpp
    speechintent.cpp
)

set(ovos-shell_EXTRA_LIBS
        Qt5::Widgets
        KF5::DBusAddons
        KF5::Kirigami2
    )

qt5_add_resources(ovos-shell_SRC
    qml.qrc
)

add_executable(ovos-shell ${ovos-shell_SRC})
target_link_libraries(ovos-shell Qt5::Core Qt5::Quick Qt5::WebView ${ovos-shell_EXTRA_LIBS})

install(TARGETS ovos-shell ${INSTALL_TARGETS_DEFAULT_ARGS})
install( PROGRAMS ovos-shell.desktop DESTINATION  ${KDE_INSTALL_APPDIR} )
