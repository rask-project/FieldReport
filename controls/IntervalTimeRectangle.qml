import QtQuick
import QtQuick.Controls.Material

Rectangle {
    id: control

    required property date startDate
    required property date endDate
    readonly property string text: qsTr(`${privateData.convertDecimalToHours(y / 60)} to ${privateData.convertDecimalToHours((y + height) / 60)}`)

    signal resizeInProgress(inProgress: bool)
    signal clicked

    color: Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.3)
    border.color: Material.shade(Material.accent, Material.Shade300)
    radius: 8

    function currentDateChanged(date: date) {
        const dateEqual = (date.getUTCDate() === control.startDate.getUTCDate())
        const monthEqual = (date.getUTCMonth() === control.startDate.getUTCMonth())
        const yearEqual = (date.getUTCFullYear() === control.startDate.getUTCFullYear())
        control.visible = dateEqual && monthEqual && yearEqual
    }

    QtObject {
        id: privateData

        function roundToNearestFive(number) {
            return Math.round(number / 5) * 5;
        }

        function defineItemSize() {
            const milliDiff = control.endDate.getTime() - control.startDate.getTime()
            const diff = milliDiff / (1000 * 60)
            control.height = diff
            control.y = (control.startDate.getHours() * 60) + control.startDate.getMinutes()
        }

        function convertDecimalToHours(decimal) {
            const hours = Math.floor(decimal)
            let minutes = Math.round((decimal % 1) * 60)

            if (minutes < 10)
                minutes = "0" + minutes
            return hours + ":" + minutes
        }

        function updateTimeAfterSizeAndPositionChange() {
            const startTimeString = privateData.convertDecimalToHours(control.y / 60).split(':')
            control.startDate.setHours(startTimeString[0])
            control.startDate.setMinutes(startTimeString[1])

            const endTimeString = privateData.convertDecimalToHours((control.y + control.height) / 60).split(':')
            control.endDate.setHours(endTimeString[0])
            control.endDate.setMinutes(endTimeString[1])
        }
    }

    Label {
        id: hourLabel

        width: parent.width
        height: parent.height
        text: control.text
        padding: 10

        font.pixelSize: 12
        font.weight: Font.DemiBold
        elide: Label.ElideRight

        states: [
            State {
                when: hourLabel.height <= 25

                PropertyChanges {
                    target: hourLabel
                    verticalAlignment: Label.AlignVCenter
                    padding: 0
                    leftPadding: 10
                    font.pixelSize: 10
                }
            }
        ]
    }

    ToolButton {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: control.height <= 20 ? -3 : 0
        z: 2

        implicitHeight: 24
        implicitWidth: 24
        icon.name: "close"

        onClicked: control.destroy()
    }

    Rectangle {
        id: topResize

        width: 30
        height: 10
        z: 2

        anchors.top: parent.top
        anchors.topMargin: - height / 2
        anchors.left: parent.left
        anchors.leftMargin: control.width / 2 - width

        radius: width / 2
        color: Material.shade(Material.accent, Material.Shade300)

        MouseArea {
            width: 60
            height: 30
            anchors.centerIn: parent

            onPressed: control.resizeInProgress(true)
            onPositionChanged: updateSize(mouseY)
            onReleased: {
                control.resizeInProgress(false)
                privateData.updateTimeAfterSizeAndPositionChange()
            }

            function updateSize (mouseY: int) {
                const roundedY = privateData.roundToNearestFive(control.y + mouseY)
                const newHeight = control.height - privateData.roundToNearestFive(mouseY)
                if (newHeight < 15)
                    return
                control.y = roundedY
                control.height = newHeight
            }
        }
    }

    Rectangle {
        id: bottomResize

        width: 30
        height: 10
        z: 2

        anchors.bottom: parent.bottom
        anchors.bottomMargin: - height / 2
        anchors.left: parent.left
        anchors.leftMargin: control.width / 2 + width

        radius: width / 2
        color: Material.shade(Material.accent, Material.Shade300)

        MouseArea {
            anchors.fill: parent

            onPressed: control.resizeInProgress(true)
            onPositionChanged: updateSize(mouseY)
            onReleased: {
                control.resizeInProgress(false)
                privateData.updateTimeAfterSizeAndPositionChange()
            }

            function updateSize(mouseY: int) {
                const newHeight = privateData.roundToNearestFive(control.height + mouseY)
                if (newHeight < 15) return
                control.height = newHeight
            }
        }
    }

    MouseArea {
        id: rectangleMouseArea

        property bool resize: false

        z: 1
        anchors.fill: parent

        onClicked: control.clicked()
    }

    Behavior on height { NumberAnimation { duration: 10; } }
    Behavior on y { NumberAnimation { duration: 10; } }

    Component.onCompleted: privateData.defineItemSize()
}
