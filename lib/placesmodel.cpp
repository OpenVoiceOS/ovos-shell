/*
 * Copyright 2022 Aditya Mehra <aix.m@outlook.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#include "placesmodel.h"
#include <QDir>
#include <QStandardPaths>
#include <QUrl>
#include <QFileSystemWatcher>
#include <QProcess>
#include <QDBusInterface>
#include <QDBusReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QFile>

PlacesModel::PlacesModel(QObject *parent) : QAbstractListModel(parent)
{
    m_watcher = new QFileSystemWatcher(this);
    connect(m_watcher, &QFileSystemWatcher::directoryChanged, this, &PlacesModel::update);
    update();
}

PlacesModel::~PlacesModel()
{
    delete m_watcher;
}

int PlacesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_places.count();
}

QVariant PlacesModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_places.count())
        return QVariant();

    const QUrl &place = m_places[index.row()];
    const QString &name = m_names[index.row()];
    const QString &icon = m_icons[index.row()];
    const bool &removable = m_removable[index.row()];
    const bool &mounted = m_mounted[index.row()];

    switch (role) {
    case NameRole:
        return name;
    case PathRole:
        return place.path();
    case UrlRole:
        return place;
    case IconRole:
        return icon;
    case IsRemovableRole:
        return removable;
    case IsMountedRole:
        return mounted;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> PlacesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[PathRole] = "path";
    roles[UrlRole] = "url";
    roles[IconRole] = "icon";
    roles[IsRemovableRole] = "isRemovable";
    roles[IsMountedRole] = "isMounted";
    return roles;
}

void PlacesModel::mount(int index)
{
    if (index < 0 || index >= m_places.count())
        return;

    const QUrl &place = m_places[index];
    const QString &name = m_names[index];
    const QString &icon = m_icons[index];
    const bool &removable = m_removable[index];
    const bool &mounted = m_mounted[index];

    Q_UNUSED(name)
    Q_UNUSED(icon)
    
    if (removable && !mounted) {
        QStringList args;
        args << QStringLiteral("mount") << QStringLiteral("-b") << place.path();
        QProcess::execute(QStringLiteral("udisksctl"), args);
        Q_EMIT placeMounted();
    }
}

void PlacesModel::unmount(int index)
{
    if (index < 0 || index >= m_places.count())
        return;

    const QUrl &place = m_places[index];
    const QString &name = m_names[index];
    const QString &icon = m_icons[index];
    const bool &removable = m_removable[index];
    const bool &mounted = m_mounted[index];

    Q_UNUSED(name)
    Q_UNUSED(icon)

    if (removable && mounted) {
        QStringList args;
        args << QStringLiteral("unmount") << QStringLiteral("-b") << place.path();
        QProcess::execute(QStringLiteral("udisksctl"), args);
        Q_EMIT placeUnmounted();
    }
}

void PlacesModel::update()
{
    beginResetModel();
    m_places.clear();
    QProcess process;

    // Home directory
    m_places.append(QUrl::fromLocalFile(QDir::homePath()));
    m_names.append(QStringLiteral("Home"));
    m_icons.append(QStringLiteral("user-home"));
    m_removable.append(false);
    m_mounted.append(true);
    
    // Desktop directory
    if (QDir(QStandardPaths::writableLocation(QStandardPaths::DesktopLocation)).exists()) {
        m_places.append(QUrl::fromLocalFile(QStandardPaths::writableLocation(QStandardPaths::DesktopLocation)));
        m_names.append(QStringLiteral("Desktop"));
        m_icons.append(QStringLiteral("user-desktop"));
        m_removable.append(false);
        m_mounted.append(true);
    }

    // Documents directory
    if (QDir(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation)).exists()) {
        m_places.append(QUrl::fromLocalFile(QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation)));
        m_names.append(QStringLiteral("Documents"));
        m_icons.append(QStringLiteral("folder-documents"));
        m_removable.append(false);
        m_mounted.append(true);
    }


    // Downloads directory
    if (QDir(QStandardPaths::writableLocation(QStandardPaths::DownloadLocation)).exists()) {
        m_places.append(QUrl::fromLocalFile(QStandardPaths::writableLocation(QStandardPaths::DownloadLocation)));
        m_names.append(QStringLiteral("Downloads"));
        m_icons.append(QStringLiteral("folder-download"));
        m_removable.append(false);
        m_mounted.append(true);
    }

    // Music directory
    if (QDir(QStandardPaths::writableLocation(QStandardPaths::MusicLocation)).exists()) {
        m_places.append(QUrl::fromLocalFile(QStandardPaths::writableLocation(QStandardPaths::MusicLocation)));
        m_names.append(QStringLiteral("Music"));
        m_icons.append(QStringLiteral("folder-music"));
        m_removable.append(false);
        m_mounted.append(true);
    }

    // Pictures directory
    if (QDir(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)).exists()) {
        m_places.append(QUrl::fromLocalFile(QStandardPaths::writableLocation(QStandardPaths::PicturesLocation)));
        m_names.append(QStringLiteral("Pictures"));
        m_icons.append(QStringLiteral("folder-pictures"));
        m_removable.append(false);
        m_mounted.append(true);
    }

    // Videos directory
    if (QDir(QStandardPaths::writableLocation(QStandardPaths::MoviesLocation)).exists()) {
        m_places.append(QUrl::fromLocalFile(QStandardPaths::writableLocation(QStandardPaths::MoviesLocation)));
        m_names.append(QStringLiteral("Videos"));
        m_icons.append(QStringLiteral("folder-videos"));
        m_removable.append(false);
        m_mounted.append(true);
    }

    // Other Locations - Mounted / Unmounted / Removable Devices
    QStringList args;
    args << QStringLiteral("-c") << QStringLiteral("lsblk --json -O >/tmp/partsmodel.json");
    process.start(QStringLiteral("bash"), args);
    process.waitForFinished();

    QFile file(QStringLiteral("/tmp/partsmodel.json"));
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QByteArray data = file.readAll();
    file.close();
    
    QJsonDocument json = QJsonDocument::fromJson(data);
    QJsonObject root = json.object();
    QJsonArray block_devices_parent = root.value(QStringLiteral("blockdevices")).toArray();
        
    for (int k = 0; k < block_devices_parent.count(); k++) {
        QJsonArray block_devices = block_devices_parent[k].toObject().value(QStringLiteral("children")).toArray();

        for (int i = 0; i < block_devices.count(); i++) {
            QJsonObject block_device = block_devices[i].toObject();
            QString name = block_device.value(QStringLiteral("name")).toString();
            if (name.isEmpty())
                name = block_device.value(QStringLiteral("label")).toString();
            QString type = block_device.value(QStringLiteral("type")).toString();
            QString fstype = block_device.value(QStringLiteral("fstype")).toString();
            bool removable = block_device.value(QStringLiteral("rm")).toBool();
            QString mountpoint = block_device.value(QStringLiteral("mountpoint")).toString();
            bool mounted = !mountpoint.isEmpty();
            QString device_path = block_device.value(QStringLiteral("path")).toString();
            QStringList known_fs_types = QStringList() << QStringLiteral("ext2") << QStringLiteral("ext3") << QStringLiteral("ext4") << QStringLiteral("vfat") << QStringLiteral("ntfs") << QStringLiteral("exfat") << QStringLiteral("iso9660") << QStringLiteral("udf") << QStringLiteral("hfsplus") << QStringLiteral("hfs") << QStringLiteral("hfsx") << QStringLiteral("hfs+") << QStringLiteral("hfsx") << QStringLiteral("brtfs") << QStringLiteral("zfs") << QStringLiteral("xfs") << QStringLiteral("nilfs2");
            QString icon;
            if (known_fs_types.contains(fstype)) {
                if (removable) {
                    icon = QStringLiteral("drive-removable-media");
                } else {
                    icon = QStringLiteral("drive-harddisk");
                }
            } else {
                icon = QStringLiteral("drive-harddisk");
            }

            QStringList blacklist_fs_types = QStringList() << QStringLiteral("swap") << QStringLiteral("linux_raid_member") << QStringLiteral("crypto_LUKS") << QStringLiteral("LVM2_member") << QStringLiteral("/boot/efi");

            if (type == QStringLiteral("part") && fstype != QStringLiteral("null") && !blacklist_fs_types.contains(fstype)) {
                if (mounted) {
                    m_places.append(QUrl::fromLocalFile(mountpoint));
                } else {
                    m_places.append(QUrl::fromLocalFile(device_path));
                }
                m_names.append(name);
                m_icons.append(icon);
                m_removable.append(removable);
                m_mounted.append(mounted);
            }
        }
    }

    endResetModel();
    emit countChanged();
}