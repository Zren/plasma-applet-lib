import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import QtQuick.Window

import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

import "../libconfig" as LibConfig


LibConfig.FormKCM {

	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("CheckBox")
	}

	LibConfig.CheckBox {
		configKey: 'testBool'
		Kirigami.FormData.label: i18n("Stuff")
		text: i18n("Enabled")
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("ColorField (Color)")
	}
	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("Color")
		configKey: 'testColor'
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("ColorField (StrColor)")
	}
	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("no default")
		configKey: 'testStringColor'
	}
	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("default hardcoded")
		configKey: 'testStringColor'
		defaultColor: '#336699'
	}
	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("default Kirigami textColor")
		configKey: 'testStringColor'
		defaultColor: Kirigami.Theme.textColor
	}
	LibConfig.ColorField {
		Kirigami.FormData.label: i18n("default Plasma textColor")
		configKey: 'testStringColor'
		defaultColor: PlasmaCore.Theme.textColor
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("RadioButtonGroup")
	}

	LibConfig.RadioButtonGroup {
		Kirigami.FormData.label: i18n("QQC2.RadioButton")
		QQC2.RadioButton {
			text: i18n("A")
		}
		QQC2.RadioButton {
			text: i18n("B")
		}
		QQC2.RadioButton {
			text: i18n("C")
		}
	}
	LibConfig.RadioButtonGroup {
		Kirigami.FormData.label: i18n("StrEnum model")
		configKey: "testStringEnum"
		model: [
			{ value: "a", text: i18n("A") },
			{ value: "b", text: i18n("B") },
			{ value: "c", text: i18n("C") },
		]
	}
	LibConfig.RadioButtonGroup {
		Kirigami.FormData.label: i18n("enabled + visible")
		configKey: "testStringEnum"
		model: [
			{ value: "a", text: i18n("A"), enabled: false },
			{ value: "b", text: i18n("B"), visible: false },
			{ value: "c", text: i18n("C") },
		]
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("ComboBox")
	}
	LibConfig.ComboBox {
		Kirigami.FormData.label: i18n("Enum")
		configKey: "testEnum"
		model: [
			{ value: 0, text: i18n("A") },
			{ value: 1, text: i18n("B") },
			{ value: 2, text: i18n("C") },
		]
	}
	LibConfig.ComboBox {
		Kirigami.FormData.label: i18n("Enum editable")
		configKey: "testEnum"
		editable: true
		model: [
			{ value: 0, text: i18n("A") },
			{ value: 1, text: i18n("B") },
			{ value: 2, text: i18n("C") },
		]
	}
	LibConfig.ComboBox {
		Kirigami.FormData.label: i18n("StringEnum")
		configKey: "testStringEnum"
		model: [
			{ value: "a", text: i18n("A") },
			{ value: "b", text: i18n("B") },
			{ value: "c", text: i18n("C") },
		]
	}
	LibConfig.ComboBox {
		Kirigami.FormData.label: i18n("StrEnum populate")
		configKey: "testStringEnum"
		populated: false
		onPopulate: {
			model = [
				{ value: "a", text: i18n("A") },
				{ value: "b", text: i18n("B") },
				{ value: "c", text: i18n("C") },
			]
			populated = true
		}
	}
	LibConfig.ComboBox {
		Kirigami.FormData.label: i18n("StrEnum editable")
		configKey: "testStringEnum"
		editable: true
		model: [
			{ value: "a", text: i18n("A") },
			{ value: "b", text: i18n("B") },
			{ value: "c", text: i18n("C") },
		]
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Fonts")
	}
	LibConfig.FontFamily {
		configKey: 'testFontFamily'
		Kirigami.FormData.label: i18n("FontFamily")
	}
	LibConfig.TextAlign {
		configKey: 'testTextAlign'
		Kirigami.FormData.label: i18n("TextAlign")
	}
	LibConfig.VertAlign {
		configKey: 'testVertAlign'
		Kirigami.FormData.label: i18n("VertAlign")
	}
	LibConfig.TextFormat {
		boldConfigKey: 'testTextBold'
		italicConfigKey: 'testTextItalic'
		underlineConfigKey: 'testTextUnderline'
		alignConfigKey: 'testTextAlign'
		vertAlignConfigKey: 'testVertAlign'
		Kirigami.FormData.label: i18n("TextFormat (All)")
	}
	LibConfig.TextFormat {
		boldConfigKey: 'testTextBold'
		italicConfigKey: 'testTextItalic'
		underlineConfigKey: 'testTextUnderline'
		alignConfigKey: 'testTextAlign'
		// vertAlignConfigKey: 'testVertAlign'
		Kirigami.FormData.label: i18n("TextFormat (BIU+Horz)")
	}
	LibConfig.TextFormat {
		boldConfigKey: 'testTextBold'
		italicConfigKey: 'testTextItalic'
		underlineConfigKey: 'testTextUnderline'
		// alignConfigKey: 'testTextAlign'
		vertAlignConfigKey: 'testVertAlign'
		Kirigami.FormData.label: i18n("TextFormat (BIU+Vert)")
	}
	LibConfig.TextFormat {
		boldConfigKey: 'testTextBold'
		italicConfigKey: 'testTextItalic'
		underlineConfigKey: 'testTextUnderline'
		Kirigami.FormData.label: i18n("TextFormat (BIU)")
	}
	LibConfig.TextFormat {
		alignConfigKey: 'testTextAlign'
		Kirigami.FormData.label: i18n("TextFormat (Horz)")
	}
	LibConfig.TextFormat {
		vertAlignConfigKey: 'testVertAlign'
		Kirigami.FormData.label: i18n("TextFormat (Vert)")
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("IconField")
	}
	LibConfig.IconField {
		configKey: 'testIcon'
		Kirigami.FormData.label: i18n("Default / Medium")
	}
	LibConfig.IconField {
		configKey: 'testIcon'
		Kirigami.FormData.label: i18n("Large")
		previewIconSize: Kirigami.Units.iconSizes.large
	}
	LibConfig.IconField {
		configKey: 'testIcon'
		Kirigami.FormData.label: i18n("Embed CheckBox")
		previewIconSize: Kirigami.Units.iconSizes.large
		QQC2.CheckBox {
			text: i18n("CheckBox")
		}
	}
	LibConfig.IconField {
		configKey: 'testIcon'
		Kirigami.FormData.label: i18n("Huge")
		previewIconSize: Kirigami.Units.iconSizes.huge
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Slider (Integer)")
	}
	LibConfig.Slider {
		configKey: 'testInt'
		Kirigami.FormData.label: i18n("Slider")
		from: 0
		to: 100
	}
	LibConfig.Slider {
		configKey: 'testInt'
		Kirigami.FormData.label: i18n("negative")
		from: -100
		to: 100
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("Slider (Integer)")
	}
	LibConfig.Slider {
		configKey: 'testDouble'
		Kirigami.FormData.label: i18n("Slider")
		from: 0
		to: 100
	}
	LibConfig.Slider {
		configKey: 'testDouble'
		Kirigami.FormData.label: i18n("negative")
		from: -100
		to: 100
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("SoundField")
	}
	LibConfig.SoundField {
		Kirigami.FormData.label: i18n("Sfx")
		sfxEnabledKey: 'testSfxEnabled'
		sfxPathKey: 'testSfxPath'
	}
	LibConfig.SoundField {
		Kirigami.FormData.label: i18n("Sfx default")
		sfxEnabledKey: 'testSfxEnabled'
		sfxPathKey: 'testSfxPath'
		sfxDefaultPath: '/usr/share/sounds/freedesktop/stereo/dialog-information.oga'
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("NotificationField")
	}
	LibConfig.NotificationField {
		Kirigami.FormData.label: i18n("Notification")
		notificationEnabledKey: 'testNotificationEnabled'
		sfxEnabledKey: 'testSfxEnabled'
		sfxPathKey: 'testSfxPath'
	}
	LibConfig.NotificationField {
		Kirigami.FormData.label: i18n("Notification default")
		notificationEnabledKey: 'testNotificationEnabled'
		sfxEnabledKey: 'testSfxEnabled'
		sfxPathKey: 'testSfxPath'
		sfxDefaultPath: '/usr/share/sounds/freedesktop/stereo/dialog-information.oga'
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("SpinBox (Integer)")
	}

	RowLayout {
		Kirigami.FormData.label: i18n("Integer")
		LibConfig.SpinBox {
			configKey: 'testInt'
		}
		QQC2.Label {
			text: 'Value ' + parent.children[0].value
		}
	}
	RowLayout {
		Kirigami.FormData.label: i18n("suffix px")
		LibConfig.SpinBox {
			configKey: 'testInt'
			suffix: 'px'
		}
		QQC2.Label {
			text: 'Value ' + parent.children[0].value
		}
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("SpinBox (Double)")
	}

	RowLayout {
		Kirigami.FormData.label: i18n("Real")
		LibConfig.SpinBox {
			configKey: 'testDouble'
			decimals: 2
		}
		QQC2.Label {
			text: 'Value ' + parent.children[0].value
		}
	}
	RowLayout {
		Kirigami.FormData.label: i18n("prefix")
		LibConfig.SpinBox {
			configKey: 'testDouble'
			decimals: 2
			prefix: '$'
		}
		QQC2.Label {
			text: 'Value ' + parent.children[0].value
		}
	}
	RowLayout {
		Kirigami.FormData.label: i18n("prefix + suffix")
		LibConfig.SpinBox {
			configKey: 'testDouble'
			decimals: 2
			prefix: '$'
			suffix: ' CAD'
		}
		QQC2.Label {
			text: 'Value ' + parent.children[0].value
		}
	}
	RowLayout {
		Kirigami.FormData.label: i18n("min/max +-100")
		LibConfig.SpinBox {
			configKey: 'testDouble'
			decimals: 2
			minimumValue: -100
			maximumValue: 100
		}
		QQC2.Label {
			text: 'Value ' + parent.children[0].value
		}
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("TextField")
	}
	LibConfig.TextField {
		Kirigami.FormData.label: i18n("String")
		configKey: 'testString'
	}
	LibConfig.TextField {
		Kirigami.FormData.label: i18n("placeholder")
		configKey: 'testString'
		placeholderText: i18n("Placeholder")
	}
	LibConfig.TextField {
		Kirigami.FormData.label: i18n("defaultValue")
		configKey: 'testString'
		defaultValue: 'Default Text'
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("TextArea (String)")
	}
	LibConfig.TextArea {
		configKey: 'testMultilineString'
		Kirigami.FormData.label: i18n("TextArea")
	}
	LibConfig.TextArea {
		configKey: 'testMultilineString'
		Kirigami.FormData.label: i18n("WrapAnywhere + placeholder")
		wrapMode: TextEdit.WrapAnywhere
		placeholderText: i18n("placeholder text")
	}


	//-------------------------------------------------------
	LibConfig.Heading {
		text: i18n("TextArea (StringList)")
	}
	LibConfig.TextAreaStringList {
		configKey: 'testStringList'
		Kirigami.FormData.label: i18n("TextAreaList")
	}
	LibConfig.TextAreaStringList {
		configKey: 'testStringList'
		Kirigami.FormData.label: i18n("WrapAnywhere + placeholder")
		wrapMode: TextEdit.WrapAnywhere
		placeholderText: i18n("entry 1\nentry 2")
	}

}
