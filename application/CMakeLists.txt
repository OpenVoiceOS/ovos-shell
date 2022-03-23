PROJECT(mycroft-embedded-shell)

SET(mycroft_gui_app_SRC
    main.cpp
    appsettings.cpp
    speechintent.cpp
)

set(mycroft_gui_app_EXTRA_LIBS
        Qt5::Widgets
        KF5::DBusAddons
        KF5::Kirigami2
    )

qt5_add_resources(mycroft_gui_app_SRC
    qml.qrc
)

add_executable(mycroft-embedded-shell ${mycroft_gui_app_SRC})
target_link_libraries(mycroft-embedded-shell Qt5::Core Qt5::Quick Qt5::WebView ${mycroft_gui_app_EXTRA_LIBS})

install(TARGETS mycroft-embedded-shell ${INSTALL_TARGETS_DEFAULT_ARGS})
install( PROGRAMS ai.mycroft.embedded-shell.desktop DESTINATION  ${KDE_INSTALL_APPDIR} )
