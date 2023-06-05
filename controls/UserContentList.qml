import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

ListView {
    id: control

    property int publisherSelected: 0

    signal deleteItem(index: int)
    signal modifiedItem(index: int)
    signal itemClicked(index: int)

    width: parent.width
    height: parent.height
    clip: true
    focus: true

    delegate: SwipeDelegate {
        id: swipeDelegate

        required property string name
        required property int index
        property bool edit: false

        width: control.width
        height: swipeDelegate.edit ? 80 : 50

        text: swipeDelegate.name
        icon.name: "account-circle"
        highlighted: control.currentIndex === swipeDelegate.index

        onClicked: control.itemClicked(swipeDelegate.index)

        contentItem: Item {
            IconLabel {
                visible: !swipeDelegate.edit

                anchors.fill: parent
                spacing: swipeDelegate.spacing
                mirrored: swipeDelegate.mirrored
                display: swipeDelegate.display
                alignment: swipeDelegate.display === IconLabel.IconOnly || swipeDelegate.display === IconLabel.TextUnderIcon ? Qt.AlignCenter : Qt.AlignLeft

                icon: swipeDelegate.icon
                text: swipeDelegate.text
                font: swipeDelegate.font
                color: swipeDelegate.enabled ? swipeDelegate.Material.foreground : swipeDelegate.Material.hintTextColor
            }

            RowLayout {
                enabled: swipeDelegate.edit
                visible: enabled

                spacing: 0
                anchors.fill: parent
                onVisibleChanged: if (visible) publisherNameTextField.forceActiveFocus()

                TextField {
                    id: publisherNameTextField

                    enabled: parent.enabled
                    visible: enabled

                    Layout.fillWidth: true
                    text: swipeDelegate.name
                    placeholderText: qsTr("Publisher name")
                    inputMethodHints: Qt.ImhNoPredictiveText
                }

                ToolButton {
                    visible: swipeDelegate.text.length > 0
                    icon.name: "cancel"
                    onClicked: {
                        swipeDelegate.edit = false
                        publisherNameTextField.text = swipeDelegate.name
                    }
                }

                ToolButton {
                    icon.name: "check"

                    onClicked: {
                        const item = control.model.get(swipeDelegate.index)
                        item.name = publisherNameTextField.text

                        swipeDelegate.edit = false
                        control.modifiedItem(swipeDelegate.index)
                    }
                }
            }
        }

        Connections {
            target: control

            function onFocusChanged() {
                if (control.focus)
                    return

                swipeDelegate.edit = false
                swipeDelegate.swipe.close()
            }
        }

        swipe.right: Row {
            width: 100
            height: swipeDelegate.height
            anchors.right: parent.right

            Rectangle {
                width: parent.width / 2
                height: parent.height

                color: Material.color(Material.Grey, Material.Shade100)

                IconLabel {
                    anchors.centerIn: parent
                    icon.name: "edit"
                }

                Ripple {
                    clip: true
                    clipRadius: parent.radius
                    width: parent.width
                    height: parent.height
                    pressed: SwipeDelegate.pressed
                    anchor: control
                    active: enabled && (SwipeDelegate.pressed)
                    color: swipeDelegate.flat && swipeDelegate.highlighted ? swipeDelegate.Material.highlightedRippleColor : swipeDelegate.Material.rippleColor
                }
                SwipeDelegate.onClicked: {
                    swipeDelegate.edit = true
                    swipe.close()
                }
            }

            Rectangle {
                width: parent.width / 2
                height: parent.height

                color: Material.color(Material.Red, Material.Shade100)

                IconLabel {
                    anchors.centerIn: parent
                    icon.name: "delete"
                }

                Ripple {
                    clip: true
                    clipRadius: parent.radius
                    width: parent.width
                    height: parent.height
                    pressed: SwipeDelegate.pressed
                    anchor: control
                    active: enabled && (SwipeDelegate.pressed)
                    color: swipeDelegate.flat && swipeDelegate.highlighted ? swipeDelegate.Material.highlightedRippleColor : swipeDelegate.Material.rippleColor
                }

                SwipeDelegate.onClicked: control.deleteItem(swipeDelegate.index)
            }
        }

        ListView.onRemove: SequentialAnimation {
            PropertyAction {
                target: swipeDelegate
                property: "ListView.delayRemove"
                value: true
            }
            NumberAnimation {
                target: swipeDelegate
                property: "height"
                to: 0
                easing.type: Easing.InOutQuad
            }
            PropertyAction {
                target: swipeDelegate
                property: "ListView.delayRemove"
                value: false
            }
        }
    }
}
