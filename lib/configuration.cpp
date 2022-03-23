#include "configuration.h"
#include <KConfigGroup>
#include <KSharedConfig>
#include <KUser>
#include <QColor>


Configuration &Configuration::self()
{
    static Configuration c;
    return c;
}

QColor Configuration::primaryColor() const
{
    static KSharedConfigPtr config = KSharedConfig::openConfig(QLatin1String("OvosTheme"));
    static KConfigGroup grp(config, QLatin1String("ColorScheme"));

    if (grp.isValid()) {
        return grp.readEntry(QLatin1String("primaryColor"), "#313131");
    }

    return "#313131";
}

void Configuration::setPrimaryColor(const QColor &mPrimaryColor)
{
    static KSharedConfigPtr config = KSharedConfig::openConfig(QLatin1String("OvosTheme"));
    static KConfigGroup grp(config, QLatin1String("ColorScheme"));

    if (primaryColor() == mPrimaryColor)
        return;

    grp.writeEntry(QLatin1String("primaryColor"), mPrimaryColor.name(QColor::HexArgb));
    grp.sync();
    emit primaryColorChanged();
}

QColor Configuration::secondaryColor() const
{
    static KSharedConfigPtr config = KSharedConfig::openConfig(QLatin1String("OvosTheme"));
    static KConfigGroup grp(config, QLatin1String("ColorScheme"));

    if (grp.isValid()) {
        return grp.readEntry(QLatin1String("primaryColor"), "#F70D1A");
    }

    return "#F70D1A";
}

void Configuration::setSecondaryColor(const QColor &mSecondaryColor)
{
    static KSharedConfigPtr config = KSharedConfig::openConfig(QLatin1String("OvosTheme"));
    static KConfigGroup grp(config, QLatin1String("ColorScheme"));

    if (secondaryColor() == mSecondaryColor)
        return;

    grp.writeEntry(QLatin1String("secondaryColor"), mSecondaryColor.name(QColor::HexArgb));
    grp.sync();
    emit secondaryColorChanged();
}

QColor Configuration::textColor() const
{
    static KSharedConfigPtr config = KSharedConfig::openConfig(QLatin1String("OvosTheme"));
    static KConfigGroup grp(config, QLatin1String("ColorScheme"));

    if (grp.isValid()) {
        return grp.readEntry(QLatin1String("textColor"), "#F1F1F1");
    }

    return "#F1F1F1";
}

void Configuration::setTextColor(const QColor &mTextColor)
{
    static KSharedConfigPtr config = KSharedConfig::openConfig(QLatin1String("OvosTheme"));
    static KConfigGroup grp(config, QLatin1String("ColorScheme"));

    if (textColor() == mTextColor)
        return;

    grp.writeEntry(QLatin1String("textColor"), mTextColor.name(QColor::HexArgb));
    grp.sync();
    emit textColorChanged();
}
