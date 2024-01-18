#include "Android.h"

#include <QDebug>
#ifdef ANDROID
#    include <QCoreApplication>
#    include <QJniObject>

Q_DECLARE_JNI_TYPE(Window, "Landroid/view/Window;");
Q_DECLARE_JNI_TYPE(View, "Landroid/view/View;");
Q_DECLARE_JNI_TYPE(WindowInsetsController, "Landroid/view/WindowInsetsController;");
Q_DECLARE_JNI_TYPE(WindowInsetsType, "Landroid/view/WindowInsets/Type;")

constexpr auto FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS = 0x80000000;
constexpr auto APPEARANCE_LIGHT_STATUS_BARS = 0x00000008;

static QJniObject getAndroidWindow()
{
    QJniObject context = QNativeInterface::QAndroidApplication::context();
    QJniObject window = context.callMethod<QtJniTypes::Window>("getWindow");
    return window;
}
#endif

Android::Android(QObject *parent) : QObject { parent } {}

void Android::setStatusBarColor(const QColor &color)
{
#ifdef ANDROID
    auto window = getAndroidWindow();
    bool lighten = color.lightness() > 127;
    auto insetsController =
            window.callMethod<QtJniTypes::WindowInsetsController>("getInsetsController");

    insetsController.callMethod<void>("setSystemBarsAppearance", "(II)V",
                                      lighten ? APPEARANCE_LIGHT_STATUS_BARS : 0,
                                      APPEARANCE_LIGHT_STATUS_BARS);
    window.callMethod<void>("setStatusBarColor", "(I)V", color.rgba());

    QNativeInterface::QAndroidApplication::runOnAndroidMainThread([&color]() {
        auto window = getAndroidWindow();
        window.callMethod<void>("addFlags", "(I)V", FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
    });
#endif
}

void Android::setNavigationBarColor(const QColor &color)
{
#ifdef ANDROID
    auto window = getAndroidWindow();
    window.callMethod<void>("setNavigationBarColor", "(I)V", color.rgba());
#endif
}
