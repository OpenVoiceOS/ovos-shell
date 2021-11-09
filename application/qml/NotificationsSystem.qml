import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import org.kde.kirigami 2.9 as Kirigami
import QtQuick.Window 2.2
import Mycroft 1.0 as Mycroft

Column {
    id: notificationsSys
    anchors.fill: parent
    anchors.margins: Mycroft.Units.gridUnit * 2
    spacing: Mycroft.Units.gridUnit * 2
    property int cellWidth: notificationsSys.width
    property int cellHeight: notificationsSys.height
    signal clearNotificationSessionData
    z: 999

    property var notificationData

    Connections {
        target: Mycroft.MycroftController

        onIntentRecevied: {
            if (type == "ovos.notification.notification_data") {
                var notifdata = data.notification
                notificationsSys.notificationData = notifdata
            }
            if (type == "ovos.notification.show") {
                display_notification()
            }
        }
    }

    Connections {
        target: notificationsSys
        onClearNotificationSessionData: {
            Mycroft.MycroftController.sendRequest("ovos.notification.api.pop.clear", {"notification": notificationsSys.notificationData})
        }
    }

    function display_notification() {
        if(notificationsSys.notificationData !== undefined) {
            if(notificationsSys.notificationData.type === "sticky"){
                var component = Qt.createComponent("NotificationPopSticky.qml");
            } else {
                component = Qt.createComponent("NotificationPopTransient.qml");
            }
            if (component.status !== Component.Ready)
            {
                if (component.status === Component.Error) {
                    console.debug("Error: "+ component.errorString());
                }
                return;
            } else {
                var notif_object = component.createObject(notificationsSys, {currentNotification: notificationsSys.notificationData})
            }
        }
    }
}
