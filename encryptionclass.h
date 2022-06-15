#ifndef ENCRYPTIONCLASS_H
#define ENCRYPTIONCLASS_H

#include <QObject>
#include <iostream>
using namespace std;

class EncryptionClass : public QObject
{
    Q_OBJECT
public:
    explicit EncryptionClass(QObject *parent = nullptr);

signals:
    void valueChanged(QString encryptMsg);

public slots:
    void encryptMessage(QString message);

};

#endif // ENCRYPTIONCLASS_H
