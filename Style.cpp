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
