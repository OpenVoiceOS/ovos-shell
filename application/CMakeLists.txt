PROJECT(ovos-shell)

SET(ovos-shell_SRC
    main.cpp
    appsettings.cpp
    speechintent.cpp
    plugins/EnvironmentSummary.cpp
    plugins/ResetOperations.cpp
)

set(ovos-shell_EXTRA_LIBS
    Qt${QT_MAJOR_VERSION}::Widgets
    KF6::Kirigami2
)

qt6_add_resources(ovos-shell_SRC
    qml.qrc
)

add_executable(ovos-shell ${ovos-shell_SRC})
target_link_libraries(ovos-shell Qt${QT_MAJOR_VERSION}::Core Qt${QT_MAJOR_VERSION}::Quick Qt${QT_MAJOR_VERSION}::WebView ${ovos-shell_EXTRA_LIBS})

install(TARGETS ovos-shell ${INSTALL_TARGETS_DEFAULT_ARGS})
install(PROGRAMS ovos-shell.desktop DESTINATION  ${KDE_INSTALL_APPDIR} )
