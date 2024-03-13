// Version 4

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

QQC2.Label {
	Layout.fillWidth: true
	wrapMode: Text.Wrap
	linkColor: Kirigami.Theme.highlightColor
	onLinkActivated: Qt.openUrlExternally(link)
	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
		cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
	}
}
