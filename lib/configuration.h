#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QColor>
#include <QVariant>
#include <QDir>
#include <QJsonArray>
#include <QJsonObject>
#include <QFileSystemWatcher>

class Q_DECL_EXPORT Configuration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor primaryColor READ primaryColor WRITE setPrimaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor WRITE setSecondaryColor NOTIFY secondaryColorChanged)
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)

public:
    static Configuration &self();

public Q_SLOTS:
    QColor primaryColor() const;
    void setPrimaryColor(const QColor &mPrimaryColor);

    QColor secondaryColor() const;
    void setSecondaryColor(const QColor &mSecondaryColor);

    QColor textColor() const;
    void setTextColor(const QColor &mTextColor);

    QString getSelectedSchemeName() const;
    void setSelectedSchemeName(const QString &schemeName);

    QString getSelectedSchemePath() const;
    void setSelectedSchemePath(const QString &schemePath);

    QVariantMap getSchemeList() const;
    QVariantMap getScheme(const QString &schemePath);

    bool isSchemeValid();
    void updateSchemeList();
    void fetchFromFolder(const QDir &dir);

    void setupSchemeWatcher();

    void setScheme(const QString &schemeName, const QString &schemePath);

    void updateSelectedScheme();

Q_SIGNALS:
    void primaryColorChanged();
    void secondaryColorChanged();
    void textColorChanged();
    
    void selectedSchemeNameChanged();
    void selectedSchemePathChanged();
    void schemeListChanged();

    void schemeChanged();

private:
    QString m_selectedSchemeName;
    QString m_selectedSchemePath;
    QVariantMap m_schemeList;
    QFileSystemWatcher m_schemeWatcher;
    QJsonArray m_jsonArray;
    QJsonObject m_finalObject;
};

#endif // CONFIGURATION_H