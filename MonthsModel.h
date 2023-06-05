#pragma once

#include <QAbstractItemModel>
#include <QModelIndex>
#include <QQmlEngine>
#include <QVariant>

class MonthsModel : public QAbstractItemModel
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MonthsModel(QObject *parent = nullptr);
    ~MonthsModel() override;

    void setMonth(int month);
    void setYear(int year);

    QModelIndex index(int row, int column,
                      const QModelIndex &parent = QModelIndex()) const override;
    QModelIndex parent(const QModelIndex &child) const override;
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void fetchMore(const QModelIndex &parent) override;
    bool canFetchMore(const QModelIndex &parent) const override;

private:
    int m_month;
    int m_year;
};
