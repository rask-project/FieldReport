import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import QtQuick.Templates as T

import App

Item {
    id: control

    required property date date
    property bool showShortCalendar: false

    onShowShortCalendarChanged: {
        if (control.showShortCalendar)
            control.implicitHeight = 90
        else
            control.implicitHeight = privateData.maxImplicitHeight
    }

    implicitHeight: monthCalendar.implicitHeight + 20
    clip: true

    QtObject {
        id: privateData

        property real maxImplicitHeight: 0
    }

    MonthCalendar {
        id: monthCalendar

        visible: !control.showShortCalendar
        width: parent.width

        date: control.date

        onSelectedDate: function (date) {
            control.date = date
        }
    }

    WeekCalendar {
        id: weekCalendar

        visible: control.showShortCalendar
        width: parent.width

        date: control.date
        onSelectedDate: function (date) {
            control.date = date
        }
    }

    Behavior on implicitHeight {
        NumberAnimation { duration: 50 }
    }

    Item {
        width: parent.width
        height: 10

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        Rectangle {
            width: 100
            height: parent.height * 0.3
            anchors.centerIn: parent
            z: 0

            color: Material.dividerColor
            radius: width / 2
        }
    }

    MouseArea {
        id: resizeArea

        property int startY: 0
        property real controlHeightOnStart: 0
        property bool decreasing: false
        property bool increasing: false

        width: parent.width
        height: 32
        anchors.bottom: parent.bottom
        z: 1

        onPressed: function (mouse) {
            resizeArea.startY = mouse.y
            resizeArea.controlHeightOnStart = control.implicitHeight
        }

        onPositionChanged: function (mouse) {
            if (mouse.buttons & Qt.LeftButton) {
                const deltaY = mouse.y - resizeArea.startY
                const newImplicitHeight = control.implicitHeight + deltaY
                if (newImplicitHeight >= privateData.maxImplicitHeight ||
                        newImplicitHeight <= 100)
                    return

                control.implicitHeight = newImplicitHeight
                resizeArea.startY = mouse.y
            }

            if (resizeArea.controlHeightOnStart > control.implicitHeight) {
                resizeArea.decreasing = true
                resizeArea.increasing = false
            } else {
                resizeArea.decreasing = false
                resizeArea.increasing = true
            }
        }

        onReleased: {
            resizeArea.startY = 0

            if (resizeArea.decreasing) {
                resizeArea.decreasing = false
                resizeArea.increasing = false
                control.showShortCalendar = true
            }

            if (resizeArea.increasing) {
                resizeArea.decreasing = false
                resizeArea.increasing = false
                control.showShortCalendar = false
            }
        }
    }

    Component.onCompleted: privateData.maxImplicitHeight = control.implicitHeight
}
