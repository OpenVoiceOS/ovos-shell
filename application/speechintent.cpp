/*
 * Copyright 2018 Kai Uwe Broulik <kde@broulik.de>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#include "speechintent.h"

SpeechIntent::SpeechIntent(QObject *parent) : QObject(parent)
{

}

SpeechIntent::~SpeechIntent() = default;

QString SpeechIntent::title() const
{
    return m_title;
}

void SpeechIntent::setTitle(const QString &title)
{
    if (m_title != title) {
        m_title = title;
        emit titleChanged(title);
    }
}

bool SpeechIntent::isSupported() const
{
  return false;
}

void SpeechIntent::start()
{

}
