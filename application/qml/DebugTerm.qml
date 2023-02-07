/*
    SPDX-FileCopyrightText: 2023 Aditya Mehra <aix.m@outlook.com>
    SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.19 as Kirigami
import QMLTermWidget 1.0
import Qt5Compat.GraphicalEffects

QMLTermWidget {
    id: terminal
    anchors.fill: parent
    font.family: "Monospace"
    font.pointSize: 12
    antialiasText:true
    colorScheme: "Linux"
    opacity: 100
    fullCursorHeight: true

    session: QMLTermSession {
        id: mainSession
    }

    Component.onCompleted: {
        mainSession.setShellProgram("/bin/bash")
        mainSession.setArgs([])
        mainSession.startShellProgram()
    }

    QMLTermScrollbar {
        terminal: terminal
        width: 20
        Rectangle {
            opacity: 0.4
            anchors.margins: 5
            radius: width * 0.5
            anchors.fill: parent
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: (mouse)=> {
            console.log("Giving Focus To Terminal")
            terminal.forceActiveFocus()
        }
    }
}