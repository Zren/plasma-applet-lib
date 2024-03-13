// Version 3
// Based On: https://invent.kde.org/plasma/kdeplasma-addons/-/blame/master/applets/weather/package/contents/ui/config/WeatherStationPickerDialog.qml

/*
 * SPDX-FileCopyrightText: 2018 Friedrich W. H. Kossebau <kossebau@kde.org>
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

import QtQuick
import QtQuick.Window
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami


Window {
	id: dialog

	LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
	LayoutMirroring.childrenInherit: true

	flags: Qt.Dialog
	modality: Qt.WindowModal

	width: Kirigami.Units.gridUnit * 25
	height: Kirigami.Units.gridUnit * 20

	title: i18ndc("plasma_applet_org.kde.plasma.weather", "@title:window", "Select Weather Station")
	color: syspal.window

	property alias providers: stationPicker.providers
	property alias source: stationPicker.source

	signal accepted

	function close() {
		dialog.visible = false;
	}


	SystemPalette {
		id: syspal
	}

	QQC2.Action {
		id: acceptAction

		shortcut: "Return"
		enabled: !!source
		onTriggered: {
			accepted();
			dialog.close();
		}
	}

	QQC2.Action {
		id: cancelAction

		shortcut: "Escape"
		onTriggered: {
			dialog.close();
		}
	}

	ColumnLayout {
		id: mainColumn
		anchors {
			fill: parent
			margins: mainColumn.spacing * Screen.devicePixelRatio //margins are hardcoded in QStyle we should match that here
		}
		// TODO: not yet perfect
		Layout.minimumWidth: Math.max(stationPicker.Layout.minimumWidth, buttonsRow.implicitWidth) + 2*anchors.margins
		Layout.minimumHeight: stationPicker.Layout.minimumHeight + buttonsRow.implicitHeight + 2*anchors.margins

		WeatherStationPicker {
			id: stationPicker

			Layout.fillWidth: true
			Layout.fillHeight: true
		}

		RowLayout {
			id: buttonsRow

			Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

			QQC2.Button {
				enabled: !!source
				icon.name: "dialog-ok"
				text: i18ndc("plasma_applet_org.kde.plasma.weather", "@action:button", "Select")
				onClicked: {
					acceptAction.trigger();
				}
			}
			QQC2.Button {
				icon.name: "dialog-cancel"
				text: i18ndc("plasma_applet_org.kde.plasma.weather", "@action:button", "Cancel")
				onClicked: {
					cancelAction.trigger();
				}
			}
		}
	}
}
