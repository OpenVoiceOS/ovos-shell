#ifndef OVOSTHEME_H
#define OVOSTHEME_H

#ifdef KirigamiLegacy
#include <Kirigami2/KirigamiPluginFactory>
#include <Kirigami2/PlatformTheme>
#else
#include <Kirigami/KirigamiPluginFactory>
#include <Kirigami/PlatformTheme>
#endif

#include <QObject>
#include <QFileSystemWatcher>

class OvosTheme : public Kirigami::PlatformTheme
{
    Q_OBJECT
    QPalette lightPalette;

public:
    explicit OvosTheme(QObject *parent = nullptr);
    void syncColors();
    void syncWindow();
    void readConfig();
    void syncConfigChanges();
    void setupFileWatch();

protected:
    bool event(QEvent *event) override;

private:
    QColor m_primaryColor;
    QColor m_secondaryColor;
    QColor m_textColor;
    QPointer<QWindow> m_window;

    QFileSystemWatcher *m_fileWatcher;
};

#endif
