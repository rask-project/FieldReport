import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

T.ToolButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    spacing: 3

    icon.width: 24
    icon.height: 24
    icon.color: !enabled ? Material.hintTextColor : checked || highlighted ? Material.accent : Material.foreground

    display: RoundButton.TextUnderIcon
    Material.roundedScale: Material.MediumScale

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: {
            family: control.font.family
        }

        color: !control.enabled ? control.Material.hintTextColor :
                control.checked || control.highlighted ? control.Material.accent : control.Material.foreground
    }

    background: Ripple {
        id: ripple

        readonly property bool square: control.contentItem.width <= control.contentItem.height

        implicitWidth: 64
        implicitHeight: control.Material.touchTarget

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        clip: !square
        width: square ? parent.height / 2 : parent.width
        height: square ? parent.height / 2 : parent.height
        pressed: control.pressed
        anchor: control
        active: control.enabled && (control.down || control.visualFocus || control.hovered)
        color: control.Material.rippleColor

        clipRadius: control.Material.roundedScale === control.Material.FullScale ? height / 2 : control.Material.roundedScale
    }
}
