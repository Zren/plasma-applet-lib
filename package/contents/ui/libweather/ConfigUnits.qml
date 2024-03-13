// Version 4

import QtQuick
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

import org.kde.plasma.private.weather as WeatherPlugin

KCM.SimpleKCM {
	property alias displayUnits: displayUnits
	DisplayUnits { id: displayUnits }

	// Bug: Switching from ConfigUnits to another page will set
	// WeatherPlugin.TemperatureUnitListModel to null. The
	// default weather widget segfaults.
	Component.onCompleted: {
		// console.log('onCompleted', 'populate')
		temperatureComboBox.populateWith(displayUnits.temperatureUnitId)
		pressureComboBox.populateWith(displayUnits.pressureUnitId)
		windSpeedComboBox.populateWith(displayUnits.windSpeedUnitId)
		visibilityComboBox.populateWith(displayUnits.visibilityUnitId)
	}

	Kirigami.FormLayout {

		ConfigUnitComboBox {
			id: temperatureComboBox
			configKey: 'temperatureUnitId'
			Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Temperature:")
			model: WeatherPlugin.TemperatureUnitListModel
			function serializeWith(nextValue) {
				displayUnits.setTemperatureUnitId(nextValue)
			}
		}

		ConfigUnitComboBox {
			id: pressureComboBox
			configKey: 'pressureUnitId'
			Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Pressure:")
			model: WeatherPlugin.PressureUnitListModel
			function serializeWith(nextValue) {
				displayUnits.setPressureUnitId(nextValue)
			}
		}

		ConfigUnitComboBox {
			id: windSpeedComboBox
			configKey: 'windSpeedUnitId'
			Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Wind speed:")
			model: WeatherPlugin.WindSpeedUnitListModel
			function serializeWith(nextValue) {
				displayUnits.setWindSpeedUnitId(nextValue)
			}
		}

		ConfigUnitComboBox {
			id: visibilityComboBox
			configKey: 'visibilityUnitId'
			Kirigami.FormData.label: i18ndc("plasma_applet_org.kde.plasma.weather", "@label:listbox", "Visibility:")
			model: WeatherPlugin.VisibilityUnitListModel
			function serializeWith(nextValue) {
				displayUnits.setVisibilityUnitId(nextValue)
			}
		}

	}
}
