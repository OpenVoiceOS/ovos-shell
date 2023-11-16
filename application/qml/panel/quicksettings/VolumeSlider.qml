/*
 * Copyright 2021 by Aditya Mehra <aix.m@outlook.com>
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
import Mycroft 1.0 as Mycroft

SliderBase {
    id: root
    property real changeValue: slider.value
    property bool muted: false
    iconSource: muted ? "qrc://icons/volume-mute" : "qrc://icons/volume-high"

    slider.from: 0
    slider.to: 100
    slider.stepSize: 10
    sliderButtonLabel: Math.round(slider.position * 100)

    onChangeValueChanged: {
        Mycroft.MycroftController.sendRequest("mycroft.volume.set.gui", {"percent": (changeValue / 100)},
            {"session": {"session_id": "default"}});
    }

    onIconClicked: {
        if(muted) {
            Mycroft.MycroftController.sendRequest("mycroft.volume.unmute", {},
                {"session": {"session_id": "default"}});
            muted = false
        } else {
            Mycroft.MycroftController.sendRequest("mycroft.volume.mute", {},
                {"session": {"session_id": "default"}});
            muted = true
        }
    }

    Component.onCompleted: {
        Mycroft.MycroftController.sendRequest("mycroft.volume.get", {},
            {"session": {"session_id": "default"}});
    }

    Connections {
        target: Mycroft.MycroftController
        onSocketStatusChanged: {
            if (Mycroft.MycroftController.status == Mycroft.MycroftController.Open) {
                Mycroft.MycroftController.sendRequest("mycroft.volume.get", {},
                    {"session": {"session_id": "default"}});
            }
        }
        onIntentRecevied: {
            if (type == "mycroft.volume.get.response") {
                slider.value = Math.round(data.percent * 100);
            }

            if (type == "mycroft.volume.get.sliding.panel.response") {
                slider.value = Math.round(data.percent * 100);
            }
        }
    }
}
