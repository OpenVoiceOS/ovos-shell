import QtQuick.Layouts 1.4
import QtQuick 2.9
import QtQuick.Controls 2.12
import org.kde.kirigami 2.11 as Kirigami
import QtGraphicalEffects 1.0
import Mycroft 1.0 as Mycroft
import QtWebEngine 1.9

Popup {
    id: oAuthPopup
    width: parent.width * 0.8
    height: parent.height * 0.8
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property string url: ""

    function forwardAuthentication(redirectURL) {
        Mycroft.MycroftController.sendRequest("ovos.shell.oauth.authentication.forward", {
            "redirectURL": redirectURL
        })
    }

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
            
            WebEngineView {
                id: engineView
                anchors.fill: parent
                enabled: oAuthPopup.opened
                visible: oAuthPopup.opened
                url: oAuthPopup.url

                onUrlChanged: {
                    url_to_check = engineView.url
                    if (url_to_check.indexOf("code") > -1 && url_to_check.indexOf("state") > -1) {
                        oAuthPopup.forwardAuthentication(url_to_check)
                        oAuthPopup.close()
                    }
                }
            }
        }
     }
}