import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Window
import QtQuick.Layouts

Dialog {
    id: control

    margins: 10
    verticalPadding: 8
    modal: true
    closePolicy: Dialog.NoAutoClose

    transformOrigin: Item.TopRight

    Material.elevation: 6
    Material.roundedScale: Material.ExtraLargeScale
    padding: 0

    header: Item {
        implicitHeight: 40

        RowLayout {
            anchors.fill: parent
            anchors.margins: 10

            Item {
                Layout.preferredWidth: closeButton.width
            }

            Label {
                text: control.title

                Layout.fillWidth: true
                horizontalAlignment: Label.AlignHCenter

                font.weight: Font.Bold
                font.pixelSize: 18
                elide: Label.ElideRight
            }

            ToolButton {
                id: closeButton
                icon.name: "close"
                onClicked: control.close()
            }
        }
    }
}
