#include "Style.h"

Style::Style(QObject *parent) : QObject { parent }
{
    connect(this, &Style::isDarkChanged, this, [this] {
        m_contentBackground = m_isDark ? m_backgroundDark : m_backgroundLight;
        emit contentBackgroundChanged();
    });
}

QColor Style::backgroundDark() const
{
    return m_backgroundDark;
}

QColor Style::backgroundLight() const
{
    return m_backgroundLight;
}

bool Style::isDark() const
{
    return m_isDark;
}

void Style::setIsDark(bool value)
{
    if (m_isDark == value) {
        return;
    }
    m_isDark = value;
    emit isDarkChanged();
}

QColor Style::contentBackground() const
{
    return m_contentBackground;
}

QColor Style::backgroundColor(const QColor &color, bool isDark) const
{
    auto r = color.red();
    auto g = color.green();
    auto b = color.blue();

    float factor = isDark ? 0.9F : 0.96F;
    unsigned short baseColor = isDark ? 0 : 255;

    if (isDark) {
        r = std::max<int>(baseColor, (baseColor - r) * factor + r);
        g = std::max<int>(baseColor, (baseColor - g) * factor + g);
        b = std::max<int>(baseColor, (baseColor - b) * factor + b);
    } else {
        r = std::min<int>(baseColor, (baseColor - r) * factor + r);
        g = std::min<int>(baseColor, (baseColor - g) * factor + g);
        b = std::min<int>(baseColor, (baseColor - b) * factor + b);
    }

    return QColor::fromRgb(r, g, b);
}
