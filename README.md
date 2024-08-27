OVOS Shell
======================

OpenVoiceOS Shell with [mycroft-gui-qt5](https://github.com/OpenVoiceOS/mycroft-gui-qt5) embedded view for EGLFS platforms.

> OVOS Shell is meant for devices **without a desktop environment**

## Features

- OVOS Notifications System
- OSD Service Overlays
- Custom OVOS Kirigami Platform Theme
- KDE Connect Integration

Provides:
- QML Module: OVOSPlugin 1.0

## Install

First clone the repo
```bash
git clone https://github.com/OpenVoiceOS/ovos-shell
cd ovos-shell
```

Then either install with the provided script
```bash
./dev_setup.sh
```

or Manually
```bash
echo "Building OVOS-Shell"
if [[ ! -d build-testing ]] ; then
  mkdir build-testing
fi
cd build-testing
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make -j4
sudo make install

echo "Installing Lottie-QML"
cd $TOP
if [[ ! -d lottie-qml ]] ; then
    git clone https://github.com/kbroulik/lottie-qml
    cd lottie-qml
    mkdir build
else
    cd lottie-qml
    git pull
fi

cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release   -DKDE_INSTALL_LIBDIR=lib -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
make
sudo make install
```
