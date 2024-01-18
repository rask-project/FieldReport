import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../controls" as Controls

Controls.Page {
    id: page

    title: page.locale.monthName(calendar.date.getUTCMonth()) + " " + calendar.date.getUTCFullYear()
    objectName: "ReportPage"

    padding: 15
    topPadding: 5
    bottomPadding: 5

    header: Controls.Calendar {
        id: calendar

        width: !!parent ? parent.width: 0
        date: new Date()
    }

    footer: TabBar {
        width: parent.width
        currentIndex: container.currentIndex

        TabButton {
            text: qsTr("Per hour")

            onClicked: container.currentIndex = 0
        }

        TabButton {
            text: qsTr("Detailed")

            onClicked: container.currentIndex = 1
        }
    }

    Container {
        id: container

        property bool interactive: true

        anchors.fill: parent
        currentIndex: 0

        contentItem: ListView {
            id: listView

            model: container.contentModel
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal

            interactive: flickable.interactive
            focus: container.focus
            currentIndex: container.currentIndex
            clip: true

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightMoveDuration: 250
            maximumFlickVelocity: 4 * width
        }

        Flickable {
            id: flickable

            property date currentDateTime: new Date()
            property int currentIndex: flickable.currentDateTime.getHours()
            readonly property int hourItemHeight: 60
            property int startY: flickable.contentY

            width: page.width - page.padding * 2
            height: page.height - page.padding * 2
            contentHeight: flickable.hourItemHeight * hourRepeater.model
            interactive: container.interactive

            onCurrentIndexChanged: flickable.scrollToPosition(flickable.currentIndex * 50)

            onMovementStarted: flickable.startY = flickable.contentY
            onContentYChanged: {
                if ((startY + 32) < contentY)
                    calendar.showShortCalendar = true
            }

            function scrollToPosition(y: real) {
                flickable.contentY = y
            }

            Timer {
                id: updateCurrentDateTime

                interval: 60 * 1000
                running: true
                repeat: true

                onTriggered: flickable.currentDateTime = new Date()
            }

            Column {
                id: column

                width: parent.width

                Repeater {
                    id: hourRepeater

                    model: 24

                    Rectangle {
                        id: hourRectangle
                        width: parent.width
                        height: flickable.hourItemHeight
                        z: 1

                        color: index % 2 ? Material.dividerColor : "transparent"
                        radius: 8

                        Label {
                            anchors.fill: parent
                            anchors.margins: 5

                            text: modelData + ":00"
                            font.weight: Font.DemiBold
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            z: 0

                            onClicked: (mouse) => mouseArea.selectMinutes(mouse)

                            function selectMinutes(mouse: MouseEvent) {
                                let minutes = 0
                                if (mouse.y >= 50) minutes = 50
                                else if (mouse.y >= 40) minutes = 40
                                else if (mouse.y >= 30) minutes = 30
                                else if (mouse.y >= 20) minutes = 20
                                else if (mouse.y >= 10) minutes = 10

                                const startDate = new Date()
                                startDate.setDate(calendar.date.getUTCDate())
                                startDate.setMonth(calendar.date.getUTCMonth())
                                startDate.setFullYear(calendar.date.getUTCFullYear())
                                startDate.setHours(index)
                                startDate.setMinutes(minutes)
                                startDate.setSeconds(0)

                                const endDate = new Date()
                                endDate.setDate(calendar.date.getUTCDate())
                                endDate.setMonth(calendar.date.getUTCMonth())
                                endDate.setFullYear(calendar.date.getUTCFullYear())
                                endDate.setHours(index + 1)
                                endDate.setMinutes(minutes)
                                endDate.setSeconds(0)

                                const component = Qt.createComponent("../controls/IntervalTimeRectangle.qml")
                                const data = {
                                    "x": 65,
                                    "z": 1000,
                                    "width": hourRectangle.width - 85,
                                    "startDate": startDate,
                                    "endDate": endDate
                                }

                                const obj = component.createObject(hoursItems, data)
                                obj.onResizeInProgress.connect(function (inProgress) { container.interactive = !inProgress })
                                obj.onClicked.connect(function () {
                                    console.log(obj)
                                })

                                const currentaDateChangedCallback = function () { obj.currentDateChanged(calendar.date) }
                                calendar.dateChanged.connect(currentaDateChangedCallback)
                                obj.Component.onDestruction.connect(function () {
                                    calendar.dateChanged.disconnect(currentaDateChangedCallback)
                                })
                            }
                        }
                    }
                }
            }

            Item {
                id: hoursItems

                width: parent.width
                height: flickable.contentHeight

                Rectangle {
                    x: 60
                    y: (flickable.currentDateTime.getHours() * 60) + flickable.currentDateTime.getMinutes()
                    width: parent.width - 75
                    height: 2
                    radius: 10

                    color: Qt.rgba(Material.foreground.r, Material.foreground.g, Material.foreground.b, 0.2)

                    Rectangle {
                        width: 10
                        height: width
                        anchors.top: parent.top
                        anchors.topMargin: -4
                        anchors.left: parent.left
                        anchors.leftMargin: -10
                        radius: width
                        color: parent.color
                    }

                    Rectangle {
                        width: 10
                        height: width
                        anchors.top: parent.top
                        anchors.topMargin: -4
                        anchors.right: parent.right
                        anchors.rightMargin: -10

                        radius: width
                        color: parent.color
                    }
                }
            }
        }

        Item {
            width: container.width
            height: container.height
            z: 10

            Controls.InfoMessage {
                anchors.centerIn: parent
                message: "Nothing to show"
                messageType: Controls.InfoMessage.Info
            }
        }
    }
}
