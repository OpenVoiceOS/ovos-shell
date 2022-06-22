import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.9
import QtGraphicalEffects 1.0
import org.kde.kirigami 2.9 as Kirigami
import QMLTermWidget 1.0

QMLTermWidget {
    id: terminal
    anchors.fill: parent
    font.family: "Monospace"
    font.pointSize: 12
    antialiasText:true
    colorScheme: "Linux"
    opacity: 100
    fullCursorHeight: true

    session: QMLTermSession {
        id: mainSession
    }

    Component.onCompleted: {
        mainSession.setShellProgram("/bin/bash")
        mainSession.setArgs([])
        mainSession.startShellProgram()
    }

    QMLTermScrollbar {
        terminal: terminal
        width: 20
        Rectangle {
            opacity: 0.4
            anchors.margins: 5
            radius: width * 0.5
            anchors.fill: parent
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("Giving Focus To Terminal")
            terminal.forceActiveFocus()
        }
    }
}