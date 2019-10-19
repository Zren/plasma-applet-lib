# Plasma Widget Library (Zren)

This is a folder of various reuseable files for developing a Plasma Widget.

* `sh ./reinstall` to install the widget and restart `plasmashell` to test your widget in the panel.
* `sh ./build` to generate a zip file with the extension `.plasmoid` which you can upload to the [KDE Store](https://store.kde.org).
* `project.sublime-project` Normally you shouldn't commit your IDE project files, but I did so to give you an example of my various build commands.
	* You can hit `Ctrl+B` to test the widget with `plasmoidviewer`
	* Open `Ctrl+Shift+P` to open the command palette for other commands like:
		* `2x dpi` to test if your widget properly scales for HiDPI monitors.
		* `locale de` to test the German locale using `.../translate/plasmoidlocaletest`.
		* `reinstall` to install the widget and restart `plasmashell` to test your widget in the panel.
* `package/translate/` contains various scripts for tranlating a widget.
	* `sh ./merge` will find all `i18n("Messages")` in your widget, then generate a `template.pot` for you. You can then copy and raname the template file to `fr.po` to translate the `msgstr ""` in order to translate your widget into French. If you run `sh ./merge` again, it will also merge new messages added to the widget into `template.pot` and `fr.po`.
	* `sh ./build` will convert the `fr.po` files into the smaller binary `fr.mo` files. It places those in `package/contents/locale` which is where they need to be for Plasma to recognize the translations.
	* `sh ./plasmoidlocaletest` will run the `./build` script, then run `plasmoidviewer` with `LANGUAGE="fr_CA:fr"`, `LANG="fr_CA.UTF-8"`, and `LC_TIME="fr_CA.UTF-8"` so you can test the translations.
* `package/contents/ui/lib` contains a number of reuseable QML/JS files.
	* `Logger.qml` is useful if you want to log pretty JSON formatting, but only when debugging. Add a `Logger { id: logger; name: "widgetname"; }` in your `main.qml`. You can then use logger.logJSON('obj', obj) to always log the object. You can also use `logger.debugJSON('obj', obj)` to only show the log statement if you set `Logger { showDebug: true }` which can easily be commented out when preparing for release.
	* `ExecUtil.qml` is a `PlasmaCore.DataSource { engine: "executable" }` with a `exec(cmd, callback)` function added.
	* Config
		* `ConfigPage.qml` and `AppletVersion.qml` are used as the root item in a widget config tab. It's basically a fancy [`ColumnLayout`](https://doc.qt.io/qt-5/qml-qtquick-layouts-columnlayout.html) that displays the widget version that is in `metadata.desktop`.
		* `ConfigAdvanced.qml` reads `config/main.xml` to know all config values and their default values. It displays every config value and you can even modify a number of data types. It's useful for easily observing hidden config variables without setting up controls in the config page.
		* `ConfigSection.qml` is designed to work like a [`GroupBox`](https://doc.qt.io/qt-5/qml-qtquick-controls-groupbox.html) but guarantees the title is left aligned, rather than using the Breeze Qt widget theme which has titles center aligned.
		* Various form controls for editing config values. They are designed so the user does **not** need to click Apply. You can easily add a control with `ConfigColor { configKey: 'textColor' }`.
			* `ConfigColor.qml`
			* `ConfigComboBox.qml` You will need to populate the dropdown with:  
					ConfigComboBox {
						configKey: "appDescription"
						model: [
							{ value: "a", text: i18n("A") },
							{ value: "b", text: i18n("B") },
							{ value: "c", text: i18n("C") },
						]
					}
			* `ConfigIcon.qml` is similar to the App Menu's icon selector, but also contains a [TextField](https://doc.qt.io/qt-5/qml-qtquick-controls-textfield.html).
			* `ConfigSpinBox.qml` is used for Integers and Doubles (real numbers).
			* `ConfigStringList.qml` displays a list of strings in a [TextArea](https://doc.qt.io/qt-5/qml-qtquick-controls-textarea.html) which each line is an item.
	