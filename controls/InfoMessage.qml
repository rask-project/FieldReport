import QtQuick
import QtQuick.Controls

Item {
    id: control

    implicitWidth: 200
    implicitHeight: 200

    required property string message
    required property int messageType

    readonly property var properties: {
        switch (control.messageType) {
        case InfoMessage.Info: return { "icon": "sentiment-neutral", "color": Material.accent, "opacity": 0.5 }
        case InfoMessage.Warning: return { "icon": "sentiment-dissatisfied", "color": Material.color(Material.Orange), "opacity": 0.8 }
        case InfoMessage.Error: return { "icon": "sentiment-very-dissatisfied", "color": Material.color(Material.Red), "opacity": 0.8 }
        }
    }

    enum MessageType {
        Info,
        Warning,
        Error
    }

    IconLabel {
        width: control.width
        height: control.height
        anchors.centerIn: parent

        text: control.message
        icon.name: control.properties.icon

        icon.width: 50
        icon.height: 50

        color: control.properties.color
        icon.color: control.properties.color

        font.pixelSize: 16
        display: IconLabel.TextUnderIcon
        opacity: control.properties.opacity
    }
}
