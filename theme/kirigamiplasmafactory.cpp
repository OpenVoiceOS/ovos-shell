/*
    SPDX-FileCopyrightText: 2017 Marco Martin <mart@kde.org>
    SPDX-FileCopyrightText: 2020 Noah Davis <noahadvs@gmail.com>
    SPDX-License-Identifier: LGPL-2.0-or-later
*/

#include "kirigamiplasmafactory.h"
#include "ovostheme.h"

OpenVoiceStyleFactory::OpenVoiceStyleFactory(QObject *parent)
    : Kirigami::KirigamiPluginFactory(parent)
{
}

OpenVoiceStyleFactory::~OpenVoiceStyleFactory() = default;

Kirigami::PlatformTheme *OpenVoiceStyleFactory::createPlatformTheme(QObject *parent)
{
    return new OvosTheme(parent);
}
