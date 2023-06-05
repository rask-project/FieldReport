import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

Item {
    id: root

    required property string page
    property alias button: control
    property bool activated: false

    Layout.fillWidth: true
    Layout.fillHeight: true

    T.ToolButton {
        id: control

        width: parent.width
        implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
        implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                 implicitContentHeight + topPadding + bottomPadding)

        anchors.centerIn: parent

        padding: 6
        spacing: 6

        icon.width: 24
        icon.height: 24
        icon.color: !enabled ? Material.hintTextColor : checked || highlighted ? Material.accent : Material.foreground

        display: RoundButton.TextUnderIcon
        highlighted: root.activated

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

            readonly property color backgroundHighlighted: Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.15)

            implicitWidth: 64
            implicitHeight: control.Material.touchTarget

            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: control.enabled && (control.highlighted || control.down || control.visualFocus || control.hovered)
            color: control.highlighted ? ripple.backgroundHighlighted : control.Material.rippleColor

            clipRadius: control.Material.roundedScale === control.Material.FullScale ? height / 2 : control.Material.roundedScale
        }
    }
}
