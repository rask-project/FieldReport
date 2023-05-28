#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationDomain("io.github.marssola");
    QCoreApplication::setApplicationName("FieldReport");
    QCoreApplication::setApplicationVersion("1.0.0");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QIcon::setThemeSearchPaths({ ":/icons" });
    QIcon::setThemeName(QStringLiteral("material-round"));

    QObject::connect(
            &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
            []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.loadFromModule("App", "Main");

    return QGuiApplication::exec();
}
