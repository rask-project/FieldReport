import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

import Native
import App

ToolBar {
    id: control

    required property string title

    property list<Item> actions: []
    property Item headerSubcontent: null

    implicitHeight: columLayout.implicitHeight + topInset + bottomInset + topPadding + bottomPadding
    padding: 10
    bottomPadding: !!control.headerSubcontent ? 0 : 16

    Material.elevation: 6

    Column {
        id: columLayout

        width: parent.width
        spacing: 5

        RowLayout {
            width: parent.width
            height: 60

            Label {
                Layout.fillWidth: true
                Layout.margins: 10

                text: control.title
                elide: Label.ElideRight
                wrapMode: Label.WordWrap
                font.pixelSize: 24
                font.weight: Font.Medium
                font.capitalization: Font.Capitalize
            }

            Row {
                children: control.actions
            }
        }

        Item {
            id: headerSubcontentItem
            visible: !!control.headerSubcontent
            width: parent.width
            height: visible ? control.headerSubcontent.implicitHeight : 0

            children: control.headerSubcontent
            onChildrenChanged: if (control.headerSubcontent != null) control.headerSubcontent.parent = headerSubcontentItem
        }
    }

    Material.background: Style.contentBackground
    Material.foreground: Material.windowText

    Material.onBackgroundChanged: Android.setStatusBarColor(Material.background)
}
