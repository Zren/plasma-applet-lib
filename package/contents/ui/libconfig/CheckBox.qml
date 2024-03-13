// Version 5

import QtQuick 2.0
import QtQuick.Controls as QQC2

QQC2.CheckBox {
	id: configCheckBox

	property string configKey: ''
	checked: plasmoid.configuration[configKey]
	onClicked: plasmoid.configuration[configKey] = !plasmoid.configuration[configKey]
}
