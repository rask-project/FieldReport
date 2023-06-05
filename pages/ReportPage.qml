import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml

import "../controls" as Controls

Controls.Page {
    id: page

    title: page.locale.monthName(calendar.date.getUTCMonth()) + " " + calendar.date.getUTCFullYear()
    objectName: "ReportPage"

    padding: 10

    headerSubcontent: Controls.Calendar {
        id: calendar

        width: !!parent ? parent.width: 0

        date: new Date()
    }
}
