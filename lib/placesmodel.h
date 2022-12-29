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

#ifndef PLACESMODEL_H
#define PLACESMODEL_H

#include <QAbstractListModel>
#include <QDir>
#include <QStandardPaths>
#include <QUrl>
#include <QObject>
#include <QFileSystemWatcher>

class PlacesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameRole = Qt::UserRole + 1,
        PathRole,
        UrlRole,
        IconRole,
        IsRemovableRole,
        IsMountedRole
    };

    PlacesModel(QObject *parent = nullptr);
    ~PlacesModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void mount(int index);
    Q_INVOKABLE void unmount(int index);

    void update();

Q_SIGNALS:
    void placeMounted();
    void placeUnmounted();
    void countChanged();

private:
    QFileSystemWatcher *m_watcher;
    QList<QUrl> m_places;
    QList<QString> m_names;
    QList<QString> m_icons;
    QList<bool> m_removable;
    QList<bool> m_mounted;
    QList<QUrl> m_mountPoints;
};

#endif // PLACESMODEL_H