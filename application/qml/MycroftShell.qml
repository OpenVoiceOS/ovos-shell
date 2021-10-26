/*
 * Copyright 2020 Aditya Mehra <Aix.m@outlook.com>
 * Copyright 2018 by Marco Martin <mart@kde.org>
 * Copyright 2018 David Edmundson <davidedmundson@kde.org>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import org.kde.kirigami 2.9 as Kirigami
import QtQuick.Window 2.2
import Mycroft 1.0 as Mycroft
import QtQuick.Controls.Material 2.0
import "./panel" as Panel
import "./osd" as Osd

Kirigami.AbstractApplicationWindow {
    id: root
    visible: true
    visibility: "Maximized"
    flags: Qt.FramelessWindowHint

    Component.onCompleted: {
        Kirigami.Units.longDuration = 100;
        Kirigami.Units.shortDuration = 100;
    }

    Timer {
        interval: 20000
        running: Mycroft.GlobalSettings.autoConnect && Mycroft.MycroftController.status != Mycroft.MycroftController.Open
        triggeredOnStart: true
        onTriggered: {
            print("Trying to connect to Mycroft");
            Mycroft.MycroftController.start();
        }
    }

    Rectangle {
        id: contentsRect
        color: "black"
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
        width: rotation === 90 || rotation == -90 ? parent.height : parent.width
        height: rotation === 90 || rotation == -90 ? parent.width : parent.height
        
        Image {
            source: "background.png"
            fillMode: Image.PreserveAspectFit
            anchors.fill: parent
            opacity: !mainView.currentItem
            Behavior on opacity {
                OpacityAnimator {
                    duration: Kirigami.Units.longDuration
                    easing.type: Easing.InQuad
                }
            }
        }
        
        StatusIndicator {
            id: si
            anchors {
                top: parent.top
                right: parent.right
                margins: Kirigami.Units.largeSpacing
            }
            z: 998
        }

        Item {
            anchors.fill: parent
            visible: slidingPanel.position < 0.05
            enabled: slidingPanel.position < 0.05
            z: 10

            Osd.VolumeOSD {
                id: volumeOSD
                width: parent.width - Kirigami.Units.gridUnit
                height: Kirigami.Units.gridUnit * 3
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Mycroft.Units.gridUnit * 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height * 0.25
                refSlidingPanel: slidingPanel.position
                horizontalMode: root.width > root.height ? 1 : 0
            }
        }

        Mycroft.SkillView {
            id: mainView
            Kirigami.Theme.colorSet: Kirigami.Theme.Complementary
            anchors.fill: parent

            ListenerAnimation {
                id: listenerAnimator
                anchors.fill: parent
            }
        }

        FastBlur {
            anchors.fill: mainView
            source: mainView
            radius: 50
            visible: slidingPanel.position > 0.5 ? 1 : 0
            opacity: slidingPanel.position > 0.5 ? 1 : 0
        }

        Item {
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
            height: Kirigami.Units.gridUnit * 2
            clip: slidingPanel.position <= 0.25
            Panel.SlidingPanel {
                id: slidingPanel
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                height: contentsRect.height
            }
            z: 999
        }
        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: (1 - applicationSettings.fakeBrightness) * 0.85
        }
    }
}
