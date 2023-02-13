#include "kirigamiplasmafactory.h"
#include "ovostheme.h"
#include "ovosthemeunits.h"

KirigamiPlasmaFactory::KirigamiPlasmaFactory(QObject *parent)
    : Kirigami::KirigamiPluginFactory(parent)
{
}

KirigamiPlasmaFactory::~KirigamiPlasmaFactory() = default;

Kirigami::PlatformTheme *KirigamiPlasmaFactory::createPlatformTheme(QObject *parent)
{
    return new OvosTheme(parent);
}

Kirigami::Units *KirigamiPlasmaFactory::createUnits(QObject *parent)
{
    Q_ASSERT(parent);
    return new OvosThemeUnits(parent);
}