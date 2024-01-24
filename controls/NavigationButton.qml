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

        readonly property color backgroundHighlighted: Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.15)

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
        icon.color: !enabled ? Material.hintTextColor : Material.foreground

        display: RoundButton.TextUnderIcon
        highlighted: root.activated

        Material.roundedScale: Material.MediumScale

        contentItem: Column {
            spacing: control.spacing

            Ripple {
                id: ripple

                readonly property color backgroundHighlighted: Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.15)

                width: 64
                height: 32
                anchors.horizontalCenter: parent.horizontalCenter

                pressed: control.pressed
                anchor: control
                active: control.enabled && (control.highlighted || control.down || control.visualFocus || control.hovered)
                color: control.highlighted ? ripple.backgroundHighlighted : control.Material.rippleColor

                clipRadius: control.Material.FullScale
                clip: true

                IconLabel {
                    anchors.centerIn: parent
                    display: RoundButton.IconOnly
                    icon: control.icon
                }
            }

            Label {
                width: parent.width
                text: control.text
                color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
                elide: Label.ElideRight
                horizontalAlignment: Label.AlignHCenter

                font: {
                    family: control.font.family
                }
            }
        }
    }
}
