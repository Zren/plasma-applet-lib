// Version 8

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Dialogs as QtDialog
import QtQuick.Layouts

import "." as LibConfig

RowLayout {
	id: soundField
	property alias label: sfxEnabledCheckBox.text
	property alias sfxEnabledKey: sfxEnabledCheckBox.configKey
	property alias sfxPathKey: sfxPathField.configKey

	property alias sfxEnabled: sfxEnabledCheckBox.checked
	property alias sfxPath: sfxPathField.text
	property alias sfxDefaultPath: sfxPathField.defaultValue

	// Importing QtMultimedia apparently segfaults both OpenSUSE and Kubuntu.
	// https://github.com/Zren/plasma-applet-eventcalendar/issues/84
	// https://github.com/Zren/plasma-applet-eventcalendar/issues/167
	// property var sfxTest: Qt.createQmlObject("import QtMultimedia 5.4; Audio {}", soundField)
	property var sfxTest: null

	spacing: 0
	LibConfig.CheckBox {
		id: sfxEnabledCheckBox
	}
	QQC2.Button {
		id: playSoundButton
		icon.name: "media-playback-start-symbolic"
		enabled: sfxEnabled && !!sfxTest
		onClicked: {
			sfxTest.source = sfxPathField.text
			sfxTest.play()
		}
	}
	LibConfig.TextField {
		id: sfxPathField
		enabled: sfxEnabled
		Layout.fillWidth: true
	}
	QQC2.Button {
		id: browseButton
		icon.name: "folder-symbolic"
		enabled: sfxEnabled
		onClicked: dialogLoader.active = true
	}

	Loader {
		id: dialogLoader
		active: false
		sourceComponent: QtDialog.FileDialog {
			id: dialog
			visible: false
			modality: Qt.WindowModal
			title: i18n("Choose a sound effect")
			currentFolder: 'file:///usr/share/sounds/'
			nameFilters: [
				i18n("Sound files (%1)", "*.wav *.mp3 *.oga *.ogg"),
				i18n("All files (%1)", "*"),
			]
			onAccepted: {
				sfxPathField.text = selectedFile
				dialogLoader.active = false // visible=false is called before onAccepted
			}
			onRejected: {
				dialogLoader.active = false // visible=false is called before onRejected
			}

			// nameFilters must be set before opening the dialog.
			// If we create the dialog with visible=true, the nameFilters
			// will not be set before it opens.
			Component.onCompleted: visible = true
		}
	}
}
