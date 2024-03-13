// Version 3

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasma5support as Plasma5Support

Rectangle {
	id: weatherStationCredits
	Layout.fillWidth: true
	property int horzPadding: 4 * Kirigami.Units.devicePixelRatio
	property int vertPadding: 2 * Kirigami.Units.devicePixelRatio
	implicitWidth: horzPadding + weatherStationCreditsLabel.implicitWidth + horzPadding
	implicitHeight: vertPadding + weatherStationCreditsLabel.implicitHeight + vertPadding

	visible: creditsText

	color: {
		var c = Kirigami.Theme.textColor
		return Qt.rgba(c.r, c.g, c.b, 0.1)
	}
	border.color: {
		var c = Kirigami.Theme.textColor
		return Qt.rgba(c.r, c.g, c.b, 0.2)
	}
	border.width: 1 * Kirigami.Units.devicePixelRatio
	radius: 4 * Kirigami.Units.devicePixelRatio

	readonly property string creditsText: weatherDataSource.getData('Credit')
	readonly property string creditsUrl: weatherDataSource.getData('Credit Url')

	Plasma5Support.DataSource {
		id: weatherDataSource
		engine: "weather"
		readonly property string weatherSource: plasmoid.configuration.source
		connectedSources: weatherSource
		interval: 1000 * 60 * 60 * 24
		readonly property var currentData: data[weatherSource]

		function getData(key) {
			if (!currentData) {
				return ''
			}
			if (typeof currentData[key] === "undefined") {
				return ''
			}
			return currentData[key]
		}
	}

	QQC2.Label {
		id: weatherStationCreditsLabel
		anchors.left: parent.left
		anchors.leftMargin: parent.horzPadding
		anchors.top: parent.top
		anchors.topMargin: parent.vertPadding

		text: {
			var str = ''
			if (weatherStationCredits.creditsText) {
				str = weatherStationCredits.creditsText
				if (weatherStationCredits.creditsUrl) {
					str = '<a href="' + weatherStationCredits.creditsUrl + '">' + str + '</a>'
				}
			}
			return str
		}
		onLinkActivated: Qt.openUrlExternally(link)
		MouseArea {
			anchors.fill: parent
			acceptedButtons: Qt.NoButton // we don't want to eat clicks on the Text
			cursorShape: parent.hoveredLink ? Qt.PointingHandCursor : Qt.ArrowCursor
		}
	}
}
