// main.qml
import QtQuick 2.4
import QtQuick.Controls 1.0
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
	}
}
