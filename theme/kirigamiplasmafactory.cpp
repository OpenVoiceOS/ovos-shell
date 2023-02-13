#include "kirigamiplasmafactory.h"
#include "ovostheme.h"
#include "ovosthemeunits.h"

OpenVoiceStyleFactory::OpenVoiceStyleFactory(QObject *parent)
    : Kirigami::KirigamiPluginFactory(parent)
{
}

OpenVoiceStyleFactory::~OpenVoiceStyleFactory() = default;

Kirigami::PlatformTheme *OpenVoiceStyleFactory::createPlatformTheme(QObject *parent)
{
    return new OvosTheme(parent);
}

Kirigami::Units *KirigamiPlasmaFactory::createUnits(QObject *parent)
{
    Q_ASSERT(parent);
    return new PlasmaDesktopUnits(parent);
}

#include "moc_kirigamiplasmafactory.cpp"