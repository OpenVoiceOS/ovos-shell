/*
    SPDX-FileCopyrightText: 2023 Aditya Mehra <aix.m@outlook.com>
    SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.kirigami 2.19 as Kirigami
import Mycroft 1.0 as Mycroft
import Qt5Compat.GraphicalEffects

Popup {
    id: termPopup
    width: parent.width * 0.8
    height: parent.height * 0.8
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

    background: Rectangle {
        color: "#2b2b2b"
        anchors.fill: parent
    }

    contentItem: Item {

        Item {
            width: rotation === 90 || rotation == -90 ? parent.height : parent.width
            height: rotation === 90 || rotation == -90 ? parent.width : parent.height
            anchors.centerIn: parent

            rotation: {
                switch (applicationSettings.rotation) {
                    case "CW":
                        return 90;
                    case "CCW":
                        return -90;
                    case "UD":
                        return 180;
                    case "NORMAL":
                    default:
                        return 0;
                }
            }

            Kirigami.Heading {
                id: headerTermLabel
                text: "Debug Terminal: Click Term Area To Activate"
                level: 3
                color: "white"
                anchors.top: parent.top
                width: parent.width
                height: parent.height * 0.1
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                maximumLineCount: 1
            }

            Loader {
                id: termLoader
                anchors.top: headerTermLabel.bottom
                anchors.bottom: closeButton.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 16
                source: "DebugTerm.qml"
            }

            Button {
                id: closeButton
                text: "Close"
                height: parent.height * 0.15
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                palette.buttonText: "white"

                onClicked: (mouse)=> {
                    termPopup.close()
                }

                background: Rectangle {
                    color: "#1b1b1b"
                    radius: 4
                }
            }
        }
    }
}
