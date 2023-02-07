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
    id: oAuthQrCodePopup
    width: parent.width * 0.8
    height: parent.height * 0.8
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property var appID
    property var skillID 
    property var qrCodePath

    background: Rectangle {
        color: Kirigami.Theme.backgroundColor
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

            Rectangle {
                anchors.fill: parent
                color: Kirigami.Theme.backgroundColor
                visible: oAuthQrCodePopup.opened
                enabled: oAuthQrCodePopup.opened
                
                Rectangle{
                    id: qrCodeSetupPageHeading
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: Mycroft.Units.gridUnit * 3
                    color: Kirigami.Theme.highlightColor

                    Label {
                        text: qsTr("Scan the QR code below to continue")
                        fontSizeMode: Text.Fit
                        minimumPixelSize: 10
                        elide: Text.ElideRight
                        font.pixelSize: Mycroft.Units.gridUnit * 1.5
                        color: Kirigami.Theme.textColor
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.margins: Mycroft.Units.gridUnit * 0.5
                    }
                }

                Image {
                    id: qrCodeImage
                    anchors.top: qrCodeSetupPageHeading.bottom
                    anchors.topMargin: Mycroft.Units.gridUnit * 0.5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: qrCodePopupCancelButton.top
                    anchors.bottomMargin: Mycroft.Units.gridUnit * 0.5
                    fillMode: Image.PreserveAspectFit
                    source: oAuthQrCodePopup.qrCodePath
                }

                Button {
                    id: qrCodePopupCancelButton
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: Mycroft.Units.gridUnit * 3

                    background: Rectangle {
                        id: qrCodePopupCancelButtonBackground
                        color: Kirigami.Theme.highlightColor
                        radius: Mycroft.Units.gridUnit * 0.5
                    }

                    contentItem: Item {
                        RowLayout {
                            id: qrCodePopupCancelButtonLayout
                            anchors.centerIn: parent

                            Kirigami.Icon {
                                id: qrCodePopupCancelButtonIcon
                                Layout.fillHeight: true
                                Layout.preferredWidth: height
                                Layout.alignment: Qt.AlignVCenter
                                source: "window-close-symbolic"

                                ColorOverlay {
                                    anchors.fill: parent
                                    source: parent
                                    color: Kirigami.Theme.textColor
                                }
                            }

                            Kirigami.Heading {
                                id: qrCodePopupCancelButtonLabel
                                level: 2
                                Layout.fillHeight: true
                                wrapMode: Text.WordWrap
                                font.bold: true
                                elide: Text.ElideRight
                                color: Kirigami.Theme.textColor
                                text: qsTr("Cancel")
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                            }
                        }
                    }

                    onClicked: (mouse)=> {
                        oAuthQrCodePopup.close()
                    }

                    onPressed: (mouse)=> {
                        qrCodePopupCancelButtonBackground.color = Qt.darker(Kirigami.Theme.highlightColor, 2)
                    }
                    onReleased: (mouse)=> {
                        qrCodePopupCancelButtonBackground.color = Kirigami.Theme.highlightColor
                    }
                }
            }
        }
    }
}
