import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

import App
import Native

ToolBar {
    id: control

    default property alias content: rowLayout.data
    implicitHeight: 92

    padding: 12
    topPadding: 10
    bottomPadding: 10

    GridLayout {
        id: rowLayout

        anchors.fill: parent

        flow: GridLayout.LeftToRight
        rows: 1
        columnSpacing: 5
    }

    Material.background: Style.contentBackground
    Material.foreground: Material.windowText
    Material.elevation: 1

    Material.onBackgroundChanged: Android.setNavigationBarColor(Material.background)
}
