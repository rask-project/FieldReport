import QtQuick.Controls

import "../controls" as Controls

Controls.Page {
    id: page

    title: qsTr("Interested")
    objectName: "InterestedPage"

    padding: 10

    Controls.InfoMessage {
        anchors.centerIn: parent
        message: "Nothing to show"
        messageType: Controls.InfoMessage.Info
    }
}
