/*
    SPDX-FileCopyrightText: 2023 Aditya Mehra <aix.m@outlook.com>
    SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import org.kde.kirigami 2.19 as Kirigami
import Mycroft 1.0 as Mycroft
import Qt5Compat.GraphicalEffects

Item {
    id: serviceWatcherRoot
    property bool skillServiceAlive: false
    property bool guiServiceAlive: false

    function queryGuiServiceIsAlive() {
        Mycroft.MycroftController.sendRequest("mycroft.gui_service.is_alive", {})
    }

    function querySkillServiceIsAlive() {
        Mycroft.MycroftController.sendRequest("mycroft.skills.is_alive", {})
    }

    Timer {
        id: serviceCheckTimer
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            queryGuiServiceIsAlive()
            querySkillServiceIsAlive()
        }
    }

    Connections {
        target: Mycroft.MycroftController

        function onIntentRecevied(type, data) {
            if(type == "mycroft.gui_service.is_alive.response"){
                serviceWatcherRoot.guiServiceAlive = Boolean(data.status)
            }

            if(type == "mycroft.skills.is_alive.response"){
                serviceWatcherRoot.skillServiceAlive = Boolean(data.status)
            }
        }
    }

    Loader {
        id: splashAnimation
        anchors.fill: parent
        enabled: !serviceWatcherRoot.guiServiceAlive
        visible: !serviceWatcherRoot.guiServiceAlive
        source: "SplashScreen.qml"
    }
}
