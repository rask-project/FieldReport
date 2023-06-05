#include "Android.h"

#include <QDebug>
#ifdef ANDROID
#    include <QCoreApplication>
#    include <QJniObject>

Q_DECLARE_JNI_TYPE(Window, "Landroid/view/Window;");
Q_DECLARE_JNI_TYPE(View, "Landroid/view/View;");

constexpr auto SYSTEM_UI_FLAG_LIGHT_STATUS_BAR = 0x00002000;

static QJniObject getAndroidWindow()
{
    QJniObject context = QNativeInterface::QAndroidApplication::context();
    QJniObject window = context.callMethod<QtJniTypes::Window>("getWindow");
    return window;
}
#endif

Android::Android(QObject *parent) : QObject { parent } { }

void Android::setStatusBarColor(const QColor &color)
{
#ifdef ANDROID
    getAndroidWindow().callMethod<void>("setStatusBarColor", "(I)V", color.rgba());
#endif
}
