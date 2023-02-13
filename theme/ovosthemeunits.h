#ifndef OVOSTHEMEUNITS_H
#define OVOSTHEMEUNITS_H

#include <QObject>
#include <Kirigami/Units>
#include <KConfigWatcher>

class OvosThemeUnits : public Kirigami::Units
{
    Q_OBJECT

public:
    explicit OvosThemeUnits(QObject *parent = nullptr);

};

#endif
