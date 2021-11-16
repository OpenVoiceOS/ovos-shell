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
import QtQuick.Window 2.2
import QtWayland.Compositor 1.3

WaylandOutput {
    id: output
    property ListModel shellSurfaces: ListModel {}
    property bool isNestedCompositor: Qt.platform.pluginName.startsWith("wayland") || Qt.platform.pluginName === "xcb"

    function handleShellSurface(shellSurface) {
        shellSurfaces.append({shellSurface: shellSurface});
    }

    window: Window {
        color: "black"
        visibility: Qt.WindowFullScreen

        WaylandMouseTracker {
            id: mouseTracker
            anchors.fill: parent
            windowSystemCursorEnabled: true

            Repeater {
                model: output.shellSurfaces
                SurfaceComponent {
                    shellSurface: modelData
                    onDestroyAnimationFinished: output.shellSurfaces.remove(index)
                }
            }

            Loader {
                anchors.fill: parent
                source: "Keyboard.qml"
            }

            WaylandCursorItem {
                inputEventsEnabled: false
                x: mouseTracker.mouseX
                y: mouseTracker.mouseY
                seat: output.compositor.defaultSeat
                visible: false
            }
        }

        Shortcut {
            sequence: StandardKey.Delete
            context: Qt.ApplicationShortcut
            onActivated: Qt.quit()
        }
    }
}
