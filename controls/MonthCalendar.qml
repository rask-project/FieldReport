import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ColumnLayout {
    id: control

    required property date date
    readonly property date previousMonth: {
        const previous = control.date
        previous.setUTCMonth(control.date.getUTCMonth() - 1)
        return previous
    }
    readonly property date nextMonth: {
        const next = control.date
        next.setUTCMonth(control.date.getUTCMonth() + 1)
        return next
    }

    signal selectedDate(date: date)

    onDateChanged: privateData.updateDates()

    width: parent.width
    spacing: 0

    QtObject {
        id: privateData

        function updateDates() {
            container.itemAt(0).date = control.previousMonth
            container.itemAt(2).date = control.nextMonth

            const current = container.itemAt(1)
            current.date = control.date
            current.selectedDate.connect(privateData.selectedDate)
        }

        function definePreviousMonth() {
            const date = new Date(control.date)
            date.setUTCMonth(previousMonthButton.month)
            if (previousMonthButton.month === 11)
                date.setUTCFullYear(date.getUTCFullYear() - 1)
            control.selectedDate(date)
        }

        function defineNextMonth() {
            const date = new Date(control.date)
            date.setUTCMonth(nextMonthButton.month)
            if (nextMonthButton.month === 0)
                date.setUTCFullYear(date.getUTCFullYear() + 1)
            control.selectedDate(date)
        }

        function selectedDate(date: date) {
            control.selectedDate(date)
            container.itemAt(1).date = date
        }
    }

    Row {
        Layout.alignment: Qt.AlignRight
        Layout.rightMargin: 5

        RoundButton {
            id: previousMonthButton

            readonly property int month: {
                const m = control.date.getUTCMonth()
                if (m === 0)
                    return 11
                return m - 1
            }

            implicitHeight: 48
            flat: true
            icon.name: "arrow-back-ios"
            text: Qt.locale().monthName(month, Locale.ShortFormat)

            onClicked: {
                privateData.definePreviousMonth()

                const item = container.takeItem(container.count - 1)
                container.setCurrentIndex(0)
                container.insertItem(0, item)

                privateData.updateDates()
            }
        }

        RoundButton {
            implicitHeight: 48

            flat: true
            icon.name: "today"

            onClicked: {
                control.selectedDate(new Date())
                container.setCurrentIndex(1)

                privateData.updateDates()
            }
        }

        RoundButton {
            id: nextMonthButton

            readonly property int month: {
                const m = control.date.getUTCMonth()
                if (m === 11)
                    return 0
                return m + 1
            }

            implicitHeight: 48

            flat: true
            icon.name: "arrow-forward-ios"
            text: Qt.locale().monthName(month, Locale.ShortFormat)
            LayoutMirroring.enabled: true

            onClicked: {
                privateData.defineNextMonth()

                const item = container.takeItem(0)
                container.addItem(item)
                container.setCurrentIndex(1)

                privateData.updateDates()
            }
        }
    }

    DayOfWeekRow {
        Layout.fillWidth: true
        Layout.leftMargin: 10
        Layout.rightMargin: 10

        delegate: Label {
            required property string narrowName

            text: narrowName
            font.capitalization: Font.AllUppercase

            horizontalAlignment: Label.AlignHCenter
            verticalAlignment: Label.AlignVCenter
        }
    }

    Container {
        id: container

        signal movedToLeft
        signal movedToRight

        Layout.fillWidth: true
        Layout.preferredHeight: 170
        Layout.margins: 10
        Layout.topMargin: 5
        Layout.bottomMargin: 5

        currentIndex: 1

        contentItem: ListView {
            id: listView

            model: container.contentModel
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal

            interactive: true
            focus: container.focus
            currentIndex: container.currentIndex
            clip: true

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: 0
            preferredHighlightEnd: 0
            highlightMoveDuration: 250
            maximumFlickVelocity: 4 * width

            onFlickEnded: {
                if (currentIndex === 0)
                    container.movedToLeft()

                if (currentIndex === 2)
                    container.movedToRight()
            }
        }

        onMovedToLeft: {
            privateData.definePreviousMonth()
            const third = container.takeItem(2)
            const first = container.itemAt(1)

            container.moveItem(1, 0)
            container.addItem(third)
            privateData.updateDates()
        }

        onMovedToRight: {
            privateData.defineNextMonth()

            container.moveItem(0, 2)
            privateData.updateDates()
        }

        MonthView {
            width: container.width
            height: container.height

            date: control.previousMonth
        }

        MonthView {
            width: container.width
            height: container.height

            date: control.date

            onSelectedDate: function (date) {
                control.selectedDate(date)
            }
        }

        MonthView {
            width: container.width
            height: container.height

            date: control.nextMonth
        }
    }
}
