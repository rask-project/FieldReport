import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ColumnLayout {
    id: control

    required property date date
    signal selectedDate(date: date)

    DayOfWeekRow {
        Layout.fillWidth: true
        Layout.leftMargin: 10
        Layout.rightMargin: 10
        Layout.topMargin: 5
        Layout.bottomMargin: 5

        delegate: Label {
            required property string narrowName

            text: narrowName
            font.capitalization: Font.AllUppercase

            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
        }
    }

    GridView {
        id: shortCalendarGridView

        property int currentDayIndex: control.date.getUTCDay()
        property list<date> weekDates: {
            const dates = Array()
            for (let before = currentDayIndex; before >= 0; --before) {
                const date = new Date(control.date)
                date.setUTCDate(date.getUTCDate() - before)
                dates.push(date)
            }

            for (let after = 1; after <= 6 - currentDayIndex; ++after) {
                const date = new Date(control.date)
                date.setUTCDate(date.getUTCDate() + after)
                dates.push(date)
            }

            return dates
        }

        Layout.fillWidth: true
        Layout.preferredHeight: cellHeight * 1.2
        Layout.leftMargin: 10
        Layout.rightMargin: 10

        interactive: false
        cellWidth: width / 7
        cellHeight: 30

        model: shortCalendarGridView.weekDates

        delegate: Rectangle {
            id: dayItem

            readonly property bool currentMonth: modelData.getUTCMonth() === control.date.getUTCMonth()
            readonly property bool highlighted: index === shortCalendarGridView.currentDayIndex

            width: shortCalendarGridView.cellWidth
            height: shortCalendarGridView.cellHeight
            radius: width / 2
            color: dayItem.highlighted ? Qt.rgba(Material.accent.r, Material.accent.g, Material.accent.b, 0.3) : "transparent"
            opacity: modelData.getUTCMonth() === control.date.getUTCMonth() ? 1.0 : 0.3

            Label {
                anchors.centerIn: parent
                text: modelData.getUTCDate()
                font.weight: !dayItem.currentMonth ? Font.Light : dayItem.highlighted ? Font.DemiBold : Font.Normal
            }

            MouseArea {
                anchors.fill: parent

                onClicked: control.selectedDate(modelData)
            }
        }
    }
}
