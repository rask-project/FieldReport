import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

import App

T.Frame {
    id: control

    default property list<Item> content

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 0
    verticalPadding: Material.frameVerticalPadding

    Material.elevation: 1
    Material.roundedScale: Material.LargeScale

    background: Rectangle {
        radius: control.Material.roundedScale
        color: Style.contentBackground

        layer.enabled: !Material.noEffects && control.Material.elevation > 0
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }
    }

    contentItem: Column {
        id: column

        width: parent.width
        children: control.content
    }
}
