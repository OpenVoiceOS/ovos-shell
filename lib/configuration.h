#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>
#include <QColor>

class Q_DECL_EXPORT Configuration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor primaryColor READ primaryColor WRITE setPrimaryColor NOTIFY primaryColorChanged)
    Q_PROPERTY(QColor secondaryColor READ secondaryColor WRITE setSecondaryColor NOTIFY secondaryColorChanged)
    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)

public:
    QColor primaryColor() const;
    void setPrimaryColor(const QColor &mPrimaryColor);

    QColor secondaryColor() const;
    void setSecondaryColor(const QColor &mSecondaryColor);

    QColor textColor() const;
    void setTextColor(const QColor &mTextColor);

    static Configuration &self();

Q_SIGNALS:
    void primaryColorChanged();
    void secondaryColorChanged();
    void textColorChanged();
};

#endif // CONFIGURATION_H

