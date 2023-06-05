import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Column {
    id: control

    property ListModel model: ListModel {}

    width: parent.width

    Repeater {
        model: control.model

        Rectangle {
            width: parent.width
            height: 42

            color: index % 2 ? Material.dividerColor : "transparent"
            radius: 8

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                Label {
                    Layout.fillWidth: true

                    text: field
                    font.pixelSize: 16
                }

                Label {
                    Layout.preferredWidth: 100

                    text: value
                    font.pixelSize: 16
                    horizontalAlignment: Label.AlignRight
                    font.weight: Font.Medium
                }
            }
        }
    }
}
