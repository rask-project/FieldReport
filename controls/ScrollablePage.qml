import QtQuick
import QtQuick.Controls

import "." as Controls

Controls.Page {
    id: page

    default property alias content: pane.contentItem

    Flickable {
        anchors.fill: parent
        contentHeight: pane.implicitHeight
        flickableDirection: Flickable.AutoFlickIfNeeded

        Pane {
            id: pane

            width: parent.width
            padding: 0
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }
}
