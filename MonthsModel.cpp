#include "MonthsModel.h"

MonthsModel::MonthsModel(QObject *parent) : QAbstractItemModel { parent }, m_month(0), m_year(0) { }

MonthsModel::~MonthsModel() = default;

void MonthsModel::setMonth(int month)
{
    if (m_month != month) {
        m_month = month;
        // Emitir sinal de dados alterados se necessário
        QModelIndex topLeft = index(0, 0);
        QModelIndex bottomRight = index(rowCount() - 1, columnCount() - 1);
        emit dataChanged(topLeft, bottomRight);
    }
}

void MonthsModel::setYear(int year)
{
    if (m_year != year) {
        m_year = year;
        // Emitir sinal de dados alterados se necessário
        QModelIndex topLeft = index(0, 0);
        QModelIndex bottomRight = index(rowCount() - 1, columnCount() - 1);
        emit dataChanged(topLeft, bottomRight);
    }
}

QModelIndex MonthsModel::index(int row, int column, const QModelIndex &parent) const
{
    // Implemente o mapeamento entre índices e dados do modelo
    // Aqui está um exemplo simples usando apenas uma coluna de dados
    if (!hasIndex(row, column, parent)) {
        return QModelIndex();
    }

    if (!parent.isValid()) {
        return createIndex(row, column);
    }

    return QModelIndex();
}

QModelIndex MonthsModel::parent(const QModelIndex &child) const
{
    Q_UNUSED(child);
    return QModelIndex();
}

int MonthsModel::rowCount(const QModelIndex &parent) const
{
    // Implemente a contagem de linhas baseada no mês e ano atual
    if (!parent.isValid()) {
        return 12;
    } // Assumindo 12 meses em um ano

    return 0;
}

int MonthsModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1; // Apenas uma coluna de dados neste exemplo
}

QVariant MonthsModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        return QVariant();
    }

    // Implemente o retorno de dados com base no índice e função solicitada (role)
    // Neste exemplo, estamos retornando o número do mês
    if (role == Qt::DisplayRole) {
        int month = index.row() + 1; // Adicionando 1 para representar os meses de 1 a 12
        return QString::number(month);
    }

    return QVariant();
}

void MonthsModel::fetchMore(const QModelIndex &parent)
{
    Q_UNUSED(parent);
    // Implemente a lógica de busca adicional, se necessário
}

bool MonthsModel::canFetchMore(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    // Implemente a lógica para determinar se há mais dados para buscar
    // Neste exemplo, assumimos que não há mais dados a buscar
    return false;
}
