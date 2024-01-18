#pragma once

#include <QColor>
#include <QObject>
#include <QQmlEngine>

class Style : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(bool isDark READ isDark WRITE setIsDark NOTIFY isDarkChanged)
    Q_PROPERTY(QColor backgroundDark READ backgroundDark CONSTANT FINAL)
    Q_PROPERTY(QColor backgroundLight READ backgroundLight CONSTANT FINAL)
    Q_PROPERTY(QColor contentBackground READ contentBackground NOTIFY contentBackgroundChanged)
public:
    explicit Style(QObject *parent = nullptr);

    QColor backgroundDark() const;
    QColor backgroundLight() const;

    bool isDark() const;
    void setIsDark(bool value);

    QColor contentBackground() const;

public slots:
    QColor backgroundColor(const QColor &color, bool isDark) const;

signals:
    void isDarkChanged();
    void contentBackgroundChanged();

private:
    const QColor m_backgroundDark { 33, 33, 33 };
    const QColor m_backgroundLight { 255, 255, 255 };
    bool m_isDark { false };
    QColor m_contentBackground { m_backgroundLight };
};
