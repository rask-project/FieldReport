import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

GridLayout {
    id: control

    property bool started: false
    property bool paused: false

    property bool ldcActivity: false

    width: parent.width
    columns: 2
    columnSpacing: 20

    states: [
        State {
            when: width > 500 && !control.started

            PropertyChanges { target: serviceTimerGrid; columns: 3 }
        },
        State {
            when: width > 500 || flow === GridLayout.TopToBottom

            PropertyChanges { target: playPauseButton; width: parent.width }
            PropertyChanges { target: stopButton; width: parent.width }
            PropertyChanges { target: serviceTimerGrid; columns: 1 }
        },
        State {
            when: width < 500

            PropertyChanges { target: playPauseButton; width: parent.width }
            PropertyChanges { target: stopButton; width: parent.width }
            PropertyChanges { target: control; columns: 1 }
        }
    ]

    GridLayout {
        id: serviceTimerGrid

        Layout.fillWidth: true
        Layout.minimumWidth: 200
        Layout.maximumWidth: 400
        Layout.alignment: Qt.AlignHCenter

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: playPauseButton.height

            Button {
                id: playPauseButton

                anchors.right: parent.right
                implicitWidth: 140

                icon.name: control.started && !control.paused ? "pause" : "play-arrow"
                text: (control.started && !control.paused) ? qsTr("Pause") : (control.paused) ? qsTr("Resume") : qsTr("Start")
                highlighted: true

                Material.accent: !control.started ? Material.Green : Material.Orange

                onClicked: {
                    if (!control.started) {
                        control.started = true
                        return
                    }

                    control.paused = !control.paused
                }
            }
        }

        Item {
            id: itemLabelTimer

            Layout.preferredWidth: 70
            Layout.preferredHeight: 32
            Layout.alignment: Qt.AlignHCenter

            Label {
                id: labelTimer

                anchors.fill: parent
                text: "00:00"
                font.pixelSize: 16
                font.weight: Font.Bold
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: stopButton.height

            Button {
                id: stopButton

                enabled: control.started

                implicitWidth: 120
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                icon.name: "stop"
                text: qsTr("Stop")
                highlighted: true

                Material.accent: Material.Red

                onClicked: {
                    control.started = false
                    control.paused = false
                }
            }
        }
    }

    ColumnLayout {
        id: activitiesColumn

        visible: control.started
        Layout.fillWidth: true

        opacity: visible ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.InOutBack } }

        SwitchDelegate {
            Layout.fillWidth: true

            text: qsTr("LDC")
            onCheckedChanged: control.ldcActivity = checked
        }

        RowLayout {
            visible: !control.ldcActivity
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true
                text: qsTr("Placements")
                font.pixelSize: 16
            }

            SpinBox {
                id: placementsSpinBox

                implicitHeight: 38
                stepSize: 1
                value: 0
                from: 0
            }
        }

        RowLayout {
            visible: !control.ldcActivity
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true
                text: qsTr("Videos")
                font.pixelSize: 16
            }

            SpinBox {
                id: videosSpinBox

                stepSize: 1
                implicitHeight: 38
                value: 0
                from: 0
            }
        }

        RowLayout {
            visible: !control.ldcActivity
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true
                text: qsTr("Return visits")
                font.pixelSize: 16
            }

            SpinBox {
                id: returnVisitsSpinBox

                stepSize: 1
                implicitHeight: 38
                value: 0
                from: 0
            }
        }

        RowLayout {
            visible: !control.ldcActivity
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true
                text: qsTr("Studies")
                font.pixelSize: 16
            }

            SpinBox {
                id: studiesSpinBox

                stepSize: 1
                implicitHeight: 38
                value: 0
                from: 0
            }
        }
    }
}
