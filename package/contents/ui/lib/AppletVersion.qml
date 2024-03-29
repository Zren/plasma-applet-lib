// Version 2

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Label {
	property string version: "?"
	property string metadataFilepath: plasmoid.file("", "../metadata.desktop")

	text: i18n("<b>Version:</b> %1", version)

	PlasmaCore.DataSource {
		id: executable
		engine: "executable"
		connectedSources: []
		onNewData: {
			let exitCode = data["exit code"]
			let exitStatus = data["exit status"]
			let stdout = data["stdout"]
			let stderr = data["stderr"]
			exited(exitCode, exitStatus, stdout, stderr)
			disconnectSource(sourceName) // cmd finished
		}
		function exec(cmd) {
			connectSource(cmd)
		}
		signal exited(int exitCode, int exitStatus, string stdout, string stderr)
	}

	Connections {
		target: executable
		onExited: {
			version = stdout.replace('\n', ' ').trim()
		}
	}

	Component.onCompleted: {
		let cmd = 'kreadconfig5 --file "' + metadataFilepath + '" --group "Desktop Entry" --key "X-KDE-PluginInfo-Version"'
		executable.exec(cmd)
	}

}
