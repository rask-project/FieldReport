import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

import App

T.Frame {
    id: control

    property string title
    property alias content: item.children
    property list<Item> actions: []

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 12
    verticalPadding: Material.frameVerticalPadding

    Material.elevation: 6
    Material.roundedScale: Material.LargeScale

    Behavior on height { NumberAnimation { duration: 250; easing.type: Easing.InOutBack } }

    background: Rectangle {
        radius: control.Material.roundedScale
        color: Style.contentBackground

        layer.enabled: !Material.noEffects && control.Material.elevation > 0
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }
    }

    contentItem: ColumnLayout {
        id: column
        width: parent.width - control.padding * 2
        spacing: 10

        GridLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 32

            Label {
                id: titlelabel

                visible: text.length > 0
                Layout.fillWidth: true

                text: control.title
                font.pixelSize: control.font.pixelSize * 1.3
                font.weight: Font.DemiBold
                elide: Label.ElideRight
            }

            Row {
                children: control.actions
            }
        }

        Item {
            id: item

            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
