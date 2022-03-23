/*
 * Copyright 2020 Aditya Mehra <Aix.m@outlook.com>
 * Copyright 2018 by Marco Martin <mart@kde.org>
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

import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.5 as Kirigami

Controls.Control {
    id: delegateRoot
    property bool toggled
    property alias iconSource: icon.source

    signal clicked(var mouse)

    leftPadding: Kirigami.Units.largeSpacing
    rightPadding: Kirigami.Units.largeSpacing
    topPadding: Kirigami.Units.largeSpacing
    bottomPadding: Kirigami.Units.largeSpacing

    implicitWidth: Kirigami.Units.iconSizes.medium * 2 + leftPadding + rightPadding
    implicitHeight: contentItem.implicitHeight + topPadding + bottomPadding

    Layout.fillWidth: true
    Layout.maximumWidth: Kirigami.Units.iconSizes.huge * 2 + leftPadding + rightPadding

    contentItem: RowLayout {
        spacing: Kirigami.Units.largeSpacing
        Kirigami.Icon {
            id: icon
            isMask: true
            color: iconMouseArea.pressed ? Kirigami.Theme.highlightedTextColor : "white"
            Layout.preferredWidth: parent.width / 2
            Layout.preferredHeight: Layout.preferredWidth
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }

    background: Rectangle {
        radius: Kirigami.Units.largeSpacing
        color: Qt.rgba((Kirigami.Theme.highlightColor.r - 0.315), (Kirigami.Theme.highlightColor.g + 0.001), (Kirigami.Theme.highlightColor.b + 0.001), 1)
        layer.enabled: true
        layer.effect: DropShadow {
            samples: 16
            transparentBorder: true
            horizontalOffset: 2
            verticalOffset: 2
        }
    }

    MouseArea {
        id: iconMouseArea
        anchors.fill: parent
        onClicked: {
            delegateRoot.clicked(mouse);
            root.delegateClicked();
        }
    }
}

