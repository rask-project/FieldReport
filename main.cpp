#include <QFontDatabase>
#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

//#include <QDirIterator>

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationDomain("io.github.marssola");
    QCoreApplication::setApplicationName("FieldReport");
    QCoreApplication::setApplicationVersion("1.0.0");

    QGuiApplication app(argc, argv);
    QLocale::setDefault(QLocale::English);

    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Black.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Bold.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Light.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Medium.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Thin.ttf");
    QFontDatabase::addApplicationFont(":/fonts/Roboto/Roboto-Regular.ttf");

    QQmlApplicationEngine engine;

    QIcon::setThemeSearchPaths({ ":/icons" });
    QIcon::setThemeName(QStringLiteral("material-round"));

    /*
    QDirIterator it(":/", QStringList(), QDir::Files, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << it.next();
    }
    */

    QObject::connect(
            &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
            []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
    engine.loadFromModule("App", "Main");

    return QGuiApplication::exec();
}
