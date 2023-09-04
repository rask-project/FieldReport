import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

import "controls" as Controls
import "pages" as Pages
import App

ApplicationWindow {
    id: appWindow

    width: 393
    height: 836
    visible: true
    title: qsTr("Rask Field Report")

    Material.background: Material.theme === Material.Dark ? "#191919" : "#FFFBFE"

    header: Controls.HeaderBar {
        title: stackView.currentItem.title
        headerSubcontent: stackView.currentItem.headerSubcontent

        actions: [
            UserButton {
                id: userAccountButton
                icon.name: "account-circle"

                onClicked: userMenu.open()

                function updateUserAccount(index: int) {
                    if (index !== userContentList.currentIndex)
                        return
                    const user = userListModel.get(index)
                    const username = user.name.split(' ')[0]
                    userAccountButton.text = (username.length > 0) ? username : "undefined"
                }
            }
        ]
    }

    footer: Controls.NavigationBar {
        Controls.NavigationButton {
            page: "MainPage"
            button.icon.name: "home"
            button.text: qsTr("Home")
            activated: stackView.currentItem.objectName === page

            button.onClicked: stackView.openPage(page)
        }

        Controls.NavigationButton {
            page: "ReportPage"
            button.icon.name: "speaker-notes"
            button.text: qsTr("Report")
            activated: stackView.currentItem.objectName === page

            button.onClicked: stackView.openPage(page)
        }

        Controls.NavigationButton {
            page: "InterestedPage"
            button.icon.name: "people"
            button.text: qsTr("Interested")
            activated: stackView.currentItem.objectName === page

            button.onClicked: stackView.openPage(page)
        }

        Controls.NavigationButton {
            page: "SettingsPage"
            button.icon.name: "settings"
            button.text: qsTr("Settings")
            activated: stackView.currentItem.objectName === page

            button.onClicked: stackView.openPage(page, { "styleSettings": styleSettings })
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent
        initialItem: Pages.MainPage {}

        function openPage(page: string, properties: object) {
            if (stackView.currentItem.objectName === page)
                return

            const pg = stackView.find(function (item) {
                return item.objectName === page
            }, StackView.DontLoad)

            if (pg === null) {
                stackView.push(Qt.resolvedUrl(`pages/${page}.qml`), properties)
            } else {
                stackView.pop(pg)
            }
        }
    }

    UserMenu {
        id: userMenu

        title: qsTr("Publishers")
        width: 320
        height: 300
        parent: userAccountButton

        onVisibleChanged: if (visible) forceActiveFocus()

        Controls.InfoMessage {
            visible: userListModel.count === 0

            width: 200
            height: 200
            anchors.centerIn: parent

            message: qsTr("No registered\npublisher")
            messageType: Controls.InfoMessage.Info
        }

        Controls.UserContentList {
            id: userContentList

            model: userListModel

            onDeleteItem: function (index) {
                userListModel.remove(index)
            }

            onModifiedItem: function (index) {
                userAccountButton.updateUserAccount(index)
            }

            onCurrentIndexChanged: function () {
                userAccountButton.updateUserAccount(userContentList.currentIndex)
            }

            onItemClicked: function (index) {
                userContentList.currentIndex = index
                userMenu.close()
            }
        }

        footer: Item {
            implicitHeight: addPublisher.height * 1.2

            Button {
                id: addPublisher

                anchors.centerIn: parent
                icon.name: "add"
                text: qsTr("Add publisher")
                flat: true

                onClicked: {
                    userListModel.append({ "name": "" })
                    userContentList.forceLayout()
                    const newPublisher = userContentList.itemAtIndex(userListModel.count - 1)
                    newPublisher.edit = true
                }
            }
        }
    }

    ListModel {
        id: userListModel

        ListElement { name: "Mauro Marssola" }
    }

    Settings {
        id: styleSettings

        category: "Style"

        property int theme: Material.Light
        property int accentColor: Material.DeepPurple
    }

    Material.theme: styleSettings.theme
    Material.accent: styleSettings.accentColor

    Component.onCompleted: {
        const callbackStyle = function () {
            Style.isDark = styleSettings.theme === Material.Dark
        }
        styleSettings.themeChanged.connect(callbackStyle)
        callbackStyle()
    }
}
