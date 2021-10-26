/*
 * Copyright 2020 Aditya Mehra <Aix.m@outlook.com>
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
import QtWayland.Compositor 1.3

ShellSurfaceItem {
    id: chrome

    property bool isChild: parent.shellSurface !== undefined

    signal destroyAnimationFinished

    autoCreatePopupItems: true

    onSurfaceDestroyed: {
        bufferLocked = true;
        destroyAnimation.start();
    }

    transform: [
        Scale {
            id: scaleTransform
            origin.x: chrome.width / 2
            origin.y: chrome.height / 2
        }
    ]

    Connections {
        target: shellSurface
        ignoreUnknownSignals: true
        onActivatedChanged: {
            if (shellSurface.activated) {
                receivedFocusAnimation.start();
            }
        }
    }

    SequentialAnimation {
        id: destroyAnimation

        ParallelAnimation {
            NumberAnimation { target: scaleTransform; property: "yScale"; to: 2/height; duration: 150 }
            NumberAnimation { target: scaleTransform; property: "xScale"; to: 0.4; duration: 150 }
            NumberAnimation { target: chrome; property: "opacity"; to: chrome.isChild ? 0 : 1; duration: 150 }
        }
        NumberAnimation { target: scaleTransform; property: "xScale"; to: 0; duration: 150 }
        ScriptAction { script: destroyAnimationFinished() }
    }

    SequentialAnimation {
        id: receivedFocusAnimation

        ParallelAnimation {
            NumberAnimation { target: scaleTransform; property: "yScale"; to: 1.02; duration: 100; easing.type: Easing.OutQuad }
            NumberAnimation { target: scaleTransform; property: "xScale"; to: 1.02; duration: 100; easing.type: Easing.OutQuad }
        }
        ParallelAnimation {
            NumberAnimation { target: scaleTransform; property: "yScale"; to: 1; duration: 100; easing.type: Easing.InOutQuad }
            NumberAnimation { target: scaleTransform; property: "xScale"; to: 1; duration: 100; easing.type: Easing.InOutQuad }
        }
    }
}
