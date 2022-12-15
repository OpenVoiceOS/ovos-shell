import QtQuick 2.1
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami
import Mycroft 1.0 as Mycroft

Delegate {
    iconSource: "qrc://icons/screen-rotate"
    text: qsTr("Rotation")

    onClicked: {
        if (applicationSettings.rotation === "CW") {
            applicationSettings.rotation = "NORMAL";
        } else if (applicationSettings.rotation === "NORMAL") {
            applicationSettings.rotation = "CCW";
        } else if (applicationSettings.rotation === "CCW") {
            applicationSettings.rotation = "UD";
        } else {
            //if (applicationSettings.rotation === "UD") {
            applicationSettings.rotation = "CW";
        }
        console.log(applicationSettings.rotation)
    }
}
