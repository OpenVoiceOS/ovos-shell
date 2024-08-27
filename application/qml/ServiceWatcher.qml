import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
import org.kde.kirigami 2.10 as Kirigami
import Mycroft 1.0 as Mycroft

Item {
    id: serviceWatcherRoot
    property bool skillServiceAlive: false
    property bool guiServiceAlive: false

    function queryGuiServiceIsAlive() {
        Mycroft.MycroftController.sendRequest("mycroft.gui_service.is_alive", {})
    }

    function querySkillServiceIsAlive() {
        Mycroft.MycroftController.sendRequest("mycroft.skills.is_alive", {})
    }

    Timer {
        id: serviceCheckTimer
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            queryGuiServiceIsAlive()
            querySkillServiceIsAlive()
        }
    }

    Connections {
        target: Mycroft.MycroftController

        onIntentRecevied: {
            if(type == "mycroft.gui_service.is_alive.response"){
                serviceWatcherRoot.guiServiceAlive = Boolean(data.status)
            }

            if(type == "mycroft.skills.is_alive.response"){
                serviceWatcherRoot.skillServiceAlive = Boolean(data.status)
            }
        }
    }

    Loader {
        id: splashAnimation
        anchors.fill: parent
        enabled: !serviceWatcherRoot.guiServiceAlive
        visible: !serviceWatcherRoot.guiServiceAlive
        source: "SplashScreen.qml"
    }
}
