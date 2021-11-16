PROJECT(mycroft-embedded-compositor)

SET(mycroft_gui_compositor_SRC
    main.cpp
)

qt5_add_resources(mycroft_gui_compositor_SRC
    qml.qrc
)

add_executable(mycroft-embedded-compositor ${mycroft_gui_compositor_SRC})
target_link_libraries(mycroft-embedded-compositor Qt5::Core Qt5::Quick Qt5::WebView Qt5::Widgets)

install(TARGETS mycroft-embedded-compositor ${INSTALL_TARGETS_DEFAULT_ARGS})
install(PROGRAMS ai.mycroft.embedded-compositor.desktop DESTINATION  ${KDE_INSTALL_APPDIR})
