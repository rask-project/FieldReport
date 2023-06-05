import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts
import QtCore

import "../controls" as Controls

Controls.ScrollablePage {
    id: page

    required property Settings styleSettings

    font.family: "Roboto"
    font.pixelSize: 16
    font.weight: Font.Normal

    title: qsTr("Settings")
    objectName: "SettingsPage"

    padding: 0
    topPadding: 15
    bottomPadding: 15

    Column {
        width: parent.width
        spacing: 10

        SwitchDelegate {
            id: themeSwitch

            width: parent.width
            text: qsTr("Dark Theme")
            font: page.font

            checked: page.styleSettings.theme === Material.Dark
            onCheckedChanged: page.styleSettings.theme = checked ? Material.Dark : Material.Light
        }

        ItemDelegate {
            id: themeColorItem

            width: parent.width
            font: page.font

            text: qsTr("Theme color")

            contentItem: RowLayout {
                Label {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    text: themeColorItem.text
                    font: themeColorItem.font
                    verticalAlignment: Label.AlignVCenter
                }

                ComboBox {
                    Layout.fillWidth: true

                    model: themeAccentColorModel
                    textRole: "name"
                    valueRole: "keyColor"
                    implicitHeight: 44

                    currentIndex: {
                        for (let i = 0; i < themeAccentColorModel.count; ++i) {
                            const color = themeAccentColorModel.get(i)
                            if (color.keyColor === page.styleSettings.accentColor)
                                return i
                        }
                        return -1
                    }

                    delegate: MenuItem {
                        required property string name
                        required property int keyColor
                        required property int index

                        width: ListView.view.width
                        text: name
                        Material.foreground: keyColor
                    }

                    onCurrentValueChanged: page.styleSettings.accentColor = currentValue
                }
            }
        }
    }

    resources: ListModel {
        id: themeAccentColorModel

        ListElement { name: qsTr("Red"); keyColor: Material.Red }
        ListElement { name: qsTr("Pink"); keyColor: Material.Pink }
        ListElement { name: qsTr("Purple"); keyColor: Material.Purple }
        ListElement { name: qsTr("DeepPurple"); keyColor: Material.DeepPurple }
        ListElement { name: qsTr("Indigo"); keyColor: Material.Indigo }
        ListElement { name: qsTr("Blue"); keyColor: Material.Blue }
        ListElement { name: qsTr("Cyan"); keyColor: Material.Cyan }
        ListElement { name: qsTr("Teal"); keyColor: Material.Teal }
        ListElement { name: qsTr("Green"); keyColor: Material.Green }
        ListElement { name: qsTr("Lime"); keyColor: Material.Lime }
        ListElement { name: qsTr("Amber"); keyColor: Material.Amber }
        ListElement { name: qsTr("Orange"); keyColor: Material.Orange }
        ListElement { name: qsTr("DeepOrange"); keyColor: Material.DeepOrange }
        ListElement { name: qsTr("BlueGrey"); keyColor: Material.BlueGrey }
    }
}
