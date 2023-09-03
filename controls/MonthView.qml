import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Item {
    id: control

    required property date date
    signal selectedDate(date: date)

    MonthGrid {
        id: monthGrid

        width: parent.width
        height: parent.height

        month: control.date.getUTCMonth()
        year: control.date.getUTCFullYear()
        spacing: 2

        delegate: Label {
            id: dayItem

            required property var model
            readonly property bool currentMonth: dayItem.model.month === monthGrid.month
            readonly property bool highlighted:
                dayItem.model.day === control.date.getUTCDate() &&
                dayItem.model.month === control.date.getUTCMonth()

            height: 30
            text: dayItem.model.day
            opacity: dayItem.currentMonth ? 1.0 : 0.3
            font.weight: !dayItem.currentMonth ? Font.Light : dayItem.highlighted ? Font.DemiBold : Font.Normal

            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter

            background: Rectangle {
                id: itemBackground

                radius: width / 2
                color: dayItem.highlighted ? Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.3) : "transparent"
            }
        }

        onClicked: function (date) {
            control.selectedDate(date)
        }
    }
}
