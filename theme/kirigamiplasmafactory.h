#ifndef KIRIGAMIPLASMAFACTORY_H
#define KIRIGAMIPLASMAFACTORY_H

#include <Kirigami/KirigamiPluginFactory>
#include <QObject>
#include <QPluginLoader>

class KirigamiPlasmaFactory : public Kirigami::KirigamiPluginFactory
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.ovos.KirigamiPluginFactory")
    Q_INTERFACES(Kirigami::KirigamiPluginFactory)

public:
    explicit KirigamiPlasmaFactory(QObject *parent = nullptr);
    ~KirigamiPlasmaFactory() override;

    Kirigami::PlatformTheme *createPlatformTheme(QObject *parent) override;
    Kirigami::Units *createUnits(QObject *parent) override;
};

#endif // KIRIGAMIPLASMAFACTORY_H
