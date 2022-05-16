/*
 * Copyright 2020 Aditya Mehra <Aix.m@outlook.com>
 * Copyright 2018 by Marco Martin <mart@kde.org>
 * Copyright 2018 David Edmundson <davidedmundson@kde.org>
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

#include <QQuickView>
#include <QCommandLineParser>
#include <QCommandLineOption>
#include <QQmlContext>
#include <QtQml>
#include <QDebug>
#include <QCursor>
#include <QtWebView/QtWebView>

#include <QApplication>
#include <KDBusService>

#include "appsettings.h"

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QStringList arguments;
    for (int a = 0; a < argc; ++a) {
        arguments << QString::fromLocal8Bit(argv[a]);
    }

    QCommandLineParser parser;

    auto dpiOption = QCommandLineOption(QStringLiteral("dpi"), QStringLiteral("dpi"), QStringLiteral("dpi"));
    auto maximizeOption = QCommandLineOption(QStringLiteral("maximize"), QStringLiteral("When set, start maximized."));
    auto helpOption = QCommandLineOption(QStringLiteral("help"), QStringLiteral("Show this help message"));
    parser.addOptions({dpiOption, maximizeOption, helpOption});
    parser.process(arguments);


    qputenv("QT_WAYLAND_FORCE_DPI", parser.value(dpiOption).toLatin1());

    QApplication app(argc, argv);
    QtWebView::initialize();
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    app.setApplicationName(QStringLiteral("OvosShell"));
    app.setOrganizationName(QStringLiteral("OpenVoiceOS"));
    app.setOrganizationDomain(QStringLiteral("OpenVoiceOS.com"));
    app.setWindowIcon(QIcon::fromTheme(QStringLiteral("mycroft")));
    
    // NOTE: Have to manually implement a --help option because the parser.addHelpOption() would
    //       be triggered at parser.process() time, but it requires the QApplication. But the
    //       'dpi' option for the GUI creates a chicken-and-the-egg issue.
    if (parser.isSet(helpOption)) {
        parser.showHelp();
        return 0;
    }

    QQuickView view;
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    bool maximize = parser.isSet(maximizeOption);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("deviceMaximized"), maximize);
    
    AppSettings *appSettings = new AppSettings(&view);
    engine.rootContext()->setContextProperty(QStringLiteral("applicationSettings"), appSettings);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

   
    return app.exec();
}
