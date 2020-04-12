// main.qml
import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras

PlasmaExtras.ScrollArea {
	id: scrollArea
	readonly property int viewportWidth: viewport ? viewport.width : width

	ColumnLayout {
		width: scrollArea.viewportWidth

		PlasmaExtras.Heading {
			text: i18n("PlasmaComponents3")
			color: theme.highlightColor
		}


		PlasmaExtras.Heading {
			text: i18n("Multiple Choice")
		}
		PlasmaComponents3.CheckBox {
			text: i18n("CheckBox")
			checked: true
		}
		PlasmaComponents3.CheckBox {
			text: i18n("CheckBox")
			checked: true
		}
		RowLayout {
			PlasmaComponents3.Label {
				Layout.alignment: Qt.AlignRight | Qt.AlignTop
				text: i18n("Label:")
			}
			ColumnLayout {
				PlasmaComponents3.RadioButton {
					text: i18n("Top")
					checked: true
				}
				PlasmaComponents3.RadioButton {
					text: i18n("Bottom")
				}
			}
		}
		RowLayout {
			PlasmaComponents3.Label {
				Layout.alignment: Qt.AlignRight
				text: i18n("ComboBox:")
			}
			PlasmaComponents3.ComboBox {
				id: comboBox
				textRole: "text"
				// valueRole: "value" // valueRole and currentValue was added in Qt 5.14
				model: [
					{ value: "a", text: i18n("A") },
					{ value: "b", text: i18n("B") },
					{ value: "c", text: i18n("C") },
				]

				// Remove when PlasmaComponents3 depends on QtQuick.Controls 2.14
				property string valueRole: "value"
				readonly property var currentValue: currentIndex >= 0 ? model[currentIndex][valueRole] : null
			}
		}
		ColumnLayout {
			Layout.leftMargin: units.gridUnit * 2

			PlasmaComponents3.Label {
				text: i18n("currentText: %1", comboBox.currentText)
			}
			PlasmaComponents3.Label {
				text: i18n("currentValue: %1", comboBox.currentValue)
			}
		}
	}
}
