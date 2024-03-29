# Plasma Widget Library (Zren)

This is a folder of various reuseable files for developing a Plasma Widget.

I recommend [downloading the zip](https://github.com/Zren/plasma-applet-lib/archive/master.zip) over cloning this repo, as you might not need everything in this project. It will also give your repo a clean git history.

## Library Contents

* `sh ./install` to install the widget (and restart `plasmashell` if already installed) to test your widget in the panel.
* `sh ./build` to generate a zip file with the extension `.plasmoid` which you can upload to the [KDE Store](https://store.kde.org).
* `project.sublime-project` Normally you shouldn't commit your IDE project files, but I did so to give you an example of my various build commands.
	* You can hit `Ctrl+B` to test the widget with `plasmoidviewer`
	* Open `Ctrl+Shift+P` to open the command palette for other commands like:
		* `2x dpi` to test if your widget properly scales for HiDPI monitors.
		* `locale de` to test the German locale using `.../translate/plasmoidlocaletest`.
		* `install widget` to install the widget and restart `plasmashell` to test your widget in the panel.
* `package/translate/` contains various scripts for translating a widget.
	* `sh ./merge` will find all `i18n("Messages")` in your widget, then generate a `template.pot` for you. You can then copy and raname the template file to `fr.po` to translate the `msgstr ""` in order to translate your widget into French. If you run `sh ./merge` again, it will also merge new messages added to the widget into `template.pot` and `fr.po`.
	* `sh ./build` will convert the `fr.po` files into the smaller binary `fr.mo` files. It places those in `package/contents/locale` which is where they need to be for Plasma to recognize the translations.
	* `sh ./plasmoidlocaletest` will run the `./build` script, then run `plasmoidviewer` with `LANGUAGE="fr_CA:fr"`, `LANG="fr_CA.UTF-8"`, and `LC_TIME="fr_CA.UTF-8"` so you can test the translations.
* `package/contents/ui/lib` contains a number of reuseable QML/JS files.
	* `Logger.qml` is useful if you want to log pretty JSON formatting, but only when debugging. Add a `Logger { id: logger; name: "widgetname"; }` in your `main.qml`. You can then use logger.logJSON('obj', obj) to always log the object. You can also use `logger.debugJSON('obj', obj)` to only show the log statement if you set `Logger { showDebug: true }` which can easily be commented out when preparing for release.
	* `ExecUtil.qml` is a `PlasmaCore.DataSource { engine: "executable" }` with a `exec(cmd, callback)` function added.
* `package/contents/ui/libconfig` contains a number of reuseable QML form controls for editing config values. They are designed so the user does **not** need to click Apply. You can easily bind one of these controls to the config by setting the `configKey` property.
	* [libconfig/CheckBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/CheckBox.qml) for on/off booleans values.
	* [libconfig/ColorField.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/ColorField.qml) for use with a `String` or `Color` config data type. If you use use a `String` data type, you can treat an empty string as a certain color theme color. Eg:
	  ```qml
	  import "./libconfig" as LibConfig
	  LibConfig.ColorField {
	    configKey: 'labelColor'
	    defaultColor: PlasmaCore.ColorScope.textColor
	  }
	  ```
	* [libconfig/ComboBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/ComboBox.qml) is useful for creating enums using the `String` config data type. KConfig comes with a enum datatype as well, but you have to either use hardcoded integers (with comments), or [declare the enum](https://stackoverflow.com/a/48460159/947742) in your QML code and keep it in sync. String comparison is less efficient but is easier to program with.
	  ```qml
	  import "./libconfig" as LibConfig
	  LibConfig.ComboBox {
	  	configKey: "variableName"
	  	model: [
	  		{ value: "a", text: i18n("A") },
	  		{ value: "b", text: i18n("B") },
	  		{ value: "c", text: i18n("C") },
	  	]
	  }
	  ```
		* [FontFamily.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/FontFamily.qml) inherits `libconfig/ComboBox.qml` and is populated with all available fonts.
	* [libconfig/IconField.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/IconField.qml) based on the Application Launcher icon selector.
	* [libconfig/RadioButtonGroup.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/RadioButtonGroup.qml) takes a similar model as `libconfig/ComboBox.qml` but will display the options as [`RadioButton`](https://doc.qt.io/qt-5/qml-qtquick-controls2-radiobutton.html).
	* [libconfig/SpinBox.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/SpinBox.qml) for Integer or Real numbers.
	* [libconfig/TextAlign.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextAlign.qml) for use with an `Int` config data type. It has your typical 4 buttons for left/center/right/justify alignment. It serializes the `Text.AlignHCenter` enum.
		* [TextFormat.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextFormat.qml) is used to toggle bold, italic, underline, and embeds the text alignment. For use with 3 `Bool` config keys and 1 `Int` config key (used for the embeded `TextAlign.qml`).
	* [libconfig/TextArea.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextArea.qml) for a string with multiple lines of text.
		* [TextAreaStringList.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextAreaStringList.qml) overloads `TextArea.qml`'s `valueToText(value)` and `textToValue(text)` functions to treat a new line as the seperator in the `StringList`.
	* [libconfig/TextField.qml](https://github.com/Zren/plasma-applet-lib/blob/master/package/contents/ui/libconfig/TextField.qml) for a single line of text.
* `Changelog.md` is for listing your new features for users. The KDE Store has a changelog feature which you can paste your feature lists into.
* `mv ReadMe-widget.md ReadMe.md` you should always have a ReadMe for your project, overwrite this library readme with the one designed for your widget.


## Distro Dependencies

If you ship your widget on the KDE Store, you should try to support the latest LTS distros.

Ubuntu 20.04 only uses **Qt 5.12** and **KDE Framework 5.68**.

* ~~Ubuntu 18.04 LTS: [Qt 5.9](https://repology.org/project/qt/versions#ubuntu_18_04) / [Plasma 5.12](https://repology.org/project/plasma-desktop/versions#ubuntu_20_04) / [KDE Framework 5.44](https://repology.org/project/plasma-framework/versions#ubuntu_18_04)~~ **(Not supported since 21.04)**
* Debian 10 (2019-July): [Qt 5.11](https://repology.org/project/qt/versions#debian_10) / [Plasma 5.14](https://repology.org/project/plasma-desktop/versions#debian_10) / [KDE Framework 5.54](https://repology.org/project/plasma-framework/versions#debian_10)
* Ubuntu 20.04 LTS: [Qt 5.12](https://repology.org/project/qt/versions#ubuntu_20_04) (2018-Nov) / [Plasma 5.18](https://repology.org/project/plasma-desktop/versions#ubuntu_20_04) (2020-Feb) / [KDE Framework 5.68](https://repology.org/project/plasma-framework/versions#ubuntu_20_04) (2020-Mar)
* Debian 11 (2021-Aug): [Qt 5.15](https://repology.org/project/qt/versions#debian_11) / [Plasma 5.20](https://repology.org/project/plasma-desktop/versions#debian_11) / [KDE Framework 5.78](https://repology.org/project/plasma-framework/versions#debian_11)
* https://zren.github.io/kde/versions/ has more distros+versions and is kept up to date.
