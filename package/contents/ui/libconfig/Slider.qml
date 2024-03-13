// Version 4

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts

QQC2.Slider {
	id: slider

	property string configKey: ''
	readonly property string configValue: configKey ? plasmoid.configuration[configKey] : ""

	value: configValue
	onValueChanged: serializeTimer.start()

	Timer { // throttle
		id: serializeTimer
		interval: 300
		onTriggered: {
			if (configKey) {
				plasmoid.configuration[configKey] = slider.value
			}
		}
	}
}
