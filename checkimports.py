#!/usr/bin/python3
# Version 2
import subprocess
import os
import sys
import argparse

# Default target is Ubuntu 20.04
# See https://zren.github.io/kde/versions/ for distro versions
DEF_QT_VERSION='5.12'
DEF_KF_VERSION='5.68'
DEF_PLASMA_VERSION='5.18'

def version(verStr):
	return map(int, verStr.split('.'))

class LibraryChecks:
	def __init__(self, name, minVer):
		self.name = name
		self.minVer = minVer
		self.major, self.minor = version(self.minVer)
		self.patternList = []
		print('[CheckImport] Target {} v{}.{}'.format(
			self.name,
			self.major,
			self.minor,
		))

	def checkPattern(self, targetVer, patternStr):
		major, minor = version(targetVer)
		if self.major == major and self.minor < minor:
			# print('[CheckImport] Checking {}'.format(patternStr))
			notComment = r'\s*[^/]{2}.*'
			self.patternList.append(notComment + patternStr)

	def performGrep(self):
		if len(self.patternList) == 0:
			return
		patternStr = '\\|'.join(self.patternList)
		cmd = 'grep --include=\\*.qml \'' + patternStr + '\' --recursive .'
		if sys.stdout.isatty():
			cmd += ' --color=always'
		# print(cmd)
		proc = subprocess.run(cmd, shell=True, capture_output=True)

		if proc.returncode == 0: # Found results
			print('[CheckImport] Target {} version is {} but found:'.format(self.name, self.minVer))
			print(proc.stdout.decode('utf-8'))
			sys.exit(1)
		elif proc.returncode == 1: # Found no results
			pass
		else: # Error proc.returncode == 2
			print(proc.stdout.decode('utf-8'))
			print(proc.stderr.decode('utf-8'))
			sys.exit(proc.returncode)


def checkImports(args):
	qtChecks = LibraryChecks('Qt', args.qtMinVer)
	# https://doc.qt.io/qt-6/qtquickcontrols-index.html#versions
	qtChecks.checkPattern('5.7', 'QtQuick.Controls 2.0')
	qtChecks.checkPattern('5.8', 'QtQuick.Controls 2.1')
	qtChecks.checkPattern('5.9', 'QtQuick.Controls 2.2')
	qtChecks.checkPattern('5.10', 'QtQuick.Controls 2.3')
	qtChecks.checkPattern('5.11', 'QtQuick.Controls 2.4')
	qtChecks.checkPattern('5.12', 'QtQuick.Controls 2.5')
	qtChecks.checkPattern('5.12', 'QtQuick.Controls 2.12')
	qtChecks.checkPattern('5.13', 'QtQuick.Controls 2.13')
	qtChecks.checkPattern('5.14', 'QtQuick.Controls 2.14')
	qtChecks.checkPattern('5.15', 'QtQuick.Controls 2.15')
	qtChecks.checkPattern('6.0', 'QtQuick.Controls 6.0')
	qtChecks.performGrep()


	kfChecks = LibraryChecks('KDEFramework', args.kfMinVer)
	### PlasmaComponents3
	# https://invent.kde.org/frameworks/plasma-framework/-/blame/master/src/declarativeimports/plasmacomponents3/qmldir
	kfChecks.checkPattern('5.33', 'org.kde.plasma.components 3.0') # https://invent.kde.org/frameworks/plasma-framework/-/commit/76af5399dd95409e857a055d20544873fac02ca1
	kfChecks.checkPattern('5.51', 'PlasmaComponents3.RoundButton') # https://invent.kde.org/frameworks/plasma-framework/-/commit/9f08668147d2e99f8b5069ff50d5c54e672a87af
	kfChecks.checkPattern('5.61', 'PlasmaComponents3.ScrollView') # https://invent.kde.org/frameworks/plasma-framework/-/commit/f04584d4235aae1904ade3060d9c68e8421f3d6c
	kfChecks.checkPattern('5.61', 'PlasmaComponents3.ToolTip')
	kfChecks.checkPattern('5.69', 'PlasmaComponents3.Page') # https://invent.kde.org/frameworks/plasma-framework/-/commit/8b5e093141625b97cfad9897e8825169d1d27165
	kfChecks.checkPattern('5.76', 'PlasmaComponents3.AbstractButton') # https://invent.kde.org/frameworks/plasma-framework/-/commit/13b0bb8364d26de37f0e93f76f414303078594a5
	kfChecks.checkPattern('5.76', 'PlasmaComponents3.Pane')
	kfChecks.checkPattern('5.81', 'PlasmaComponents3.PageIndicator') # https://invent.kde.org/frameworks/plasma-framework/-/commit/fb16e8eb20918b67a4a960584c54ed692e97d0fa
	kfChecks.checkPattern('5.82', 'PlasmaComponents3.SwipeView') # https://invent.kde.org/frameworks/plasma-framework/-/commit/103d8b539a1783a8ccc88b0781cd7965d324ed80
	### Kirigami
	# https://invent.kde.org/frameworks/kirigami/-/blame/master/src/kirigamiplugin.cpp
	kfChecks.checkPattern('5.37', 'Kirigami 1.0') # https://invent.kde.org/frameworks/plasma-framework/-/commit/76af5399dd95409e857a055d20544873fac02ca1
	kfChecks.checkPattern('5.37', 'Kirigami 2.0') # https://invent.kde.org/frameworks/plasma-framework/-/commit/76af5399dd95409e857a055d20544873fac02ca1
	kfChecks.checkPattern('5.42', 'Kirigami 2.3')
	kfChecks.checkPattern('5.42', 'Kirigami.FormLayout')


	kfChecks.performGrep()

	plasmaChecks = LibraryChecks('Plasma', args.plasmaMinVer)
	plasmaChecks.checkPattern('5.13', 'WeatherPlugin.Util') # https://invent.kde.org/plasma/kdeplasma-addons/-/commit/2997d253fa3bf7c43a36e16827d6b34d282467ee
	plasmaChecks.checkPattern('5.25', 'Wallpaper.ImageBackend') # https://invent.kde.org/plasma/plasma-workspace/-/commit/956fdd0b34a44304e6af9419e01745b18e1696f2
	plasmaChecks.checkPattern('5.26', 'Wallpaper.MediaProxy') # https://invent.kde.org/plasma/plasma-workspace/-/commit/8b641963420311777217905ec13368dd850c13b6
	plasmaChecks.checkPattern('5.99', 'Wallpaper.Image') # Removed in Plasma 5.25 https://invent.kde.org/plasma/plasma-workspace/-/commit/956fdd0b34a44304e6af9419e01745b18e1696f2
	plasmaChecks.checkPattern('5.99', 'WeatherPlugin.ServiceListModel') # Removed in Plasma 5.24 https://invent.kde.org/plasma/kdeplasma-addons/-/commit/2484b96f663aa3226271a4db1f7cef0948d3b605
	plasmaChecks.performGrep()


def main():
	parser = argparse.ArgumentParser(prog='checkimports', description='Scan QML code for imports that are too new.')
	parser.add_argument('--qt', dest='qtMinVer', default=DEF_QT_VERSION)
	parser.add_argument('--kf', dest='kfMinVer', default=DEF_KF_VERSION)
	parser.add_argument('--plasma', dest='plasmaMinVer', default=DEF_PLASMA_VERSION)
	args = parser.parse_args()
	checkImports(args)


if __name__ == '__main__':
	main()
