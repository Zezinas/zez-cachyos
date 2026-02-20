import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."
import "."

Scope {
    property var anchorButton: null
    property var anchorWindow: null
    property bool open: false

    PopupWindow {
        id: root

        visible: open

        property rect cachedRect: Qt.rect(0, 0, 0, 0)

        anchor.window: anchorWindow ? anchorWindow : null
        anchor.rect: cachedRect

        color: "transparent"

        implicitWidth: base.implicitWidth
        implicitHeight: base.implicitHeight

        Rectangle {
            id: base
            color: Theme.bgFig02
            radius: Theme.appleMenuRadius

            border.color: Theme.plusDarker
            border.width: Theme.appleMenuOutline

            implicitWidth: column.implicitWidth + Theme.appleMenuPadding * 2
            implicitHeight: column.implicitHeight + Theme.appleMenuPadding * 2

            ColumnLayout {
                id: column
                anchors.margins: Theme.appleMenuPadding
                anchors.fill: parent

                spacing: 0

                property int maxTextWidth: 0

                MenuItem {
                    text: "About This PC"
                }
                Separator {}
                MenuItem {
                    text: "Software Updates..."
                }
                MenuItem {
                    text: "Terminal"
                }
                Separator {}
                MenuItem {
                    text: "Sleep"
                }
                MenuItem {
                    text: "Restart"
                }
                MenuItem {
                    text: "Shut Down"
                }
                Separator {}
                MenuItem {
                    text: "Lock Screen"
                }

                Component.onCompleted: {
                    Qt.callLater(() => {
                        // var items = column.children.filter(function(c) { return c instanceof QtObject ? false : c.metaObject.className === "QQuickRectangle"; })
                        // Alternatively, just select MenuItems
                        var menuItems = column.children.filter(function (c) {
                            return c.hasOwnProperty("implicitTextWidth");
                        });

                        // compute max text width
                        maxTextWidth = Math.max.apply(null, menuItems.map(function (item) {
                            return item.implicitTextWidth;
                        }));

                        console.log("Calculated maxTextWidth:", maxTextWidth);

                        // Apply overrideWidth to all menuItems
                        menuItems.forEach(function (item) {
                            item.overrideWidth = maxTextWidth;
                        });
                    });
                }
            }
        }
    }

    onAnchorButtonChanged: {
        if (anchorButton && root) {
            root.cachedRect = Qt.rect(0, anchorButton.height, anchorButton.width, 0);
        }
    }
}
