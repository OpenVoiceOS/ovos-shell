/*
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

import QtQuick 2.9
import Mycroft 1.0 as Mycroft

SliderBase {
    id: root

    iconSource: Qt.resolvedUrl("./brightness-increase.svg")

    slider.value: applicationSettings.fakeBrightness
    slider.onMoved: {
       applicationSettings.fakeBrightness = slider.value;
       var fixedValue = parseFloat(slider.value).toFixed(1);
       console.log("Fixed Brightness Value: " + fixedValue)
       Mycroft.MycroftController.sendRequest("phal.brightness.control.set", {"brightness": fixedValue})
    }
    slider.from: 0
    slider.to: 1

    Connections {
        target: Mycroft.MycroftController
        onIntentRecevied: {
            if (type == "mycroft.display.set.brightness") {
                slider.value = data.percent;
            }
            if (type == "phal.brightness.control.get.response") {
                var roundingValue = data.brightness / 100;
                slider.value = parseFloat(roundingValue).toFixed(1);
            }
            if (type == "phal.brightness.control.auto.dim.update") {
                var roundingDimValue = data.brightness / 100;
                slider.value = parseFloat(roundingDimValue).toFixed(1);
            }
        }
    }
}
