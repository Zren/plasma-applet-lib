// main.qml
import QtQuick 2.4
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

PlasmaExtras.ScrollArea {
	id: scrollArea
	readonly property int viewportWidth: viewport ? viewport.width : width

	ColumnLayout {
		width: scrollArea.viewportWidth

		PlasmaExtras.Heading {
			text: i18n("PlasmaComponents2")
			color: theme.highlightColor
		}



		PlasmaExtras.Heading {
			text: i18n("Multiple Choice")
		}
		PlasmaComponents.CheckBox {
			text: i18n("CheckBox")
			checked: true
		}
		PlasmaComponents.CheckBox {
			text: i18n("CheckBox")
			checked: true
		}
		RowLayout {
			PlasmaComponents.Label {
				Layout.alignment: Qt.AlignRight | Qt.AlignTop
				text: i18n("Label:")
			}
			ColumnLayout {
				ExclusiveGroup { id: tabPositionGroup }
				PlasmaComponents.RadioButton {
					text: i18n("Top")
					checked: true
					exclusiveGroup: tabPositionGroup
				}
				PlasmaComponents.RadioButton {
					text: i18n("Bottom")
					exclusiveGroup: tabPositionGroup
				}
			}
		}
		RowLayout {
			PlasmaComponents.Label {
				Layout.alignment: Qt.AlignRight
				text: i18n("ComboBox:")
			}
			PlasmaComponents.ComboBox {
				textRole: "text"
				property string valueRole: "value"
				model: [
					{ value: "a", text: i18n("A") },
					{ value: "b", text: i18n("B") },
					{ value: "c", text: i18n("C") },
				]
				readonly property var currentValue: currentIndex >= 0 ? model[currentIndex][valueRole] : null
				readonly property string currentText: currentIndex >= 0 ? model[currentIndex][textRole] : ""
			}
		}



		PlasmaExtras.Heading {
			text: i18n("Numbers")
		}
		RowLayout {
			PlasmaComponents.Label {
				text: i18n("SpinBox:")
				Layout.alignment: Qt.AlignRight
			}
			SpinBox {
				minimumValue: 0
				maximumValue: 100
				value: 25
				stepSize: 1
			}
		}
		RowLayout {
			PlasmaComponents.Label {
				text: i18n("Slider:")
			}
			PlasmaComponents.Slider {
				id: slider
				Layout.fillWidth: true
				minimumValue: 0.0
				maximumValue: 1.0
				value: 0.25
				stepSize: 0.01
			}
			PlasmaComponents.Label {
				id: sliderValueLabel
				Layout.minimumWidth: textMetrics.width
				text: formatText(slider.value)
				function formatText(value) {
					return i18n("%1%", Math.round(value * 100))
				}
				TextMetrics {
					id: textMetrics
					font.family: sliderValueLabel.font.family
					font.pointSize: sliderValueLabel.font.pointSize
					text: sliderValueLabel.formatText(slider.maximumValue)
				}
			}
		}



		PlasmaExtras.Heading {
			text: i18n("Input")
		}
		RowLayout {
			PlasmaComponents.Label {
				Layout.alignment: Qt.AlignRight
				text: i18n("Label:")
			}
			PlasmaComponents.TextField {
				placeholderText: i18n("TextField")
			}
		}
		RowLayout {
			PlasmaComponents.Label {
				Layout.alignment: Qt.AlignRight | Qt.AlignTop
				text: i18n("Label:")
			}
			PlasmaComponents.TextArea {
				Layout.preferredHeight: 100 * units.devicePixelRatio
				Layout.fillWidth: true
				text: "Lorem ipsum\ndolor sit amet,\nconsectetur adipisicing elit"
			}
		}

		PlasmaExtras.Heading {
			text: i18n("Buttons")
		}
		PlasmaComponents.Button {
			iconSource: "view-refresh"
			text: i18n("Button")
		}
		PlasmaComponents.ToolButton {
			iconSource: "view-refresh-symbolic"
			text: i18n("ToolButton")
		}
	}
}
