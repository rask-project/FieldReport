import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QtQuick.Controls.Material.impl

import "../controls" as Controls
import App

Controls.ScrollablePage {
    id: page

    title: qsTr("My Report")
    objectName: "MainPage"

    padding: 15
    topPadding: 24

    Column {
        anchors.fill: parent
        spacing: page.padding * 2

        Controls.Card {
            id: fieldServiceTimerCard

            width: parent.width
            height: fieldServiceTimer.height + implicitHeight

            title: qsTr("Activity")
            content: Controls.FieldServiceTimer {
                id: fieldServiceTimer

                flow: width < 320 ? GridLayout.TopToBottom : GridLayout.LeftToRight
            }
        }

        Controls.Card {
            id: reportCard

            width: parent.width
            height: reportComponent.height + implicitHeight + padding * 2

            title: qsTr("Month Report")
            actions: [
                ToolButton {
                    icon.name: "share"
                    highlighted: true
                },
                ToolButton {
                    icon.name: "launch"
                    highlighted: true
                    onClicked: stackView.openPage("ReportPage")
                }
            ]
            content: Controls.ReportComponent {
                id: reportComponent

                model: ListModel {
                    ListElement {
                        field: qsTr("Placements")
                        value: "0"
                    }

                    ListElement {
                        field: qsTr("Videos")
                        value: "0"
                    }

                    ListElement {
                        field: qsTr("Hours")
                        value: "00:00"
                    }

                    ListElement {
                        field: qsTr("Return visits")
                        value: "0"
                    }

                    ListElement {
                        field: qsTr("Estudos")
                        value: "0"
                    }

                    ListElement {
                        field: qsTr("LDC Hours")
                        value: "00:00"
                    }
                }
            }
        }
    }
}
