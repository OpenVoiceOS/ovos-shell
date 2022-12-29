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