#include "encryptionclass.h"

#include <osrng.h>
#include <string.h>

#include <rsa.h>
using namespace CryptoPP;

EncryptionClass::EncryptionClass(QObject *parent)
    : QObject{parent}
{

}

void EncryptionClass::encryptMessage(QString message)
{
    cout << "1. - " << message.toStdString()<< endl;

    ////////////////////////////////////////////////
    // Generate keys
    AutoSeededRandomPool rng;

    InvertibleRSAFunction params;
    params.GenerateRandomWithKeySize(rng, 3072);

    RSA::PrivateKey privateKey(params);
    RSA::PublicKey publicKey(params);

    string cipher, recovered;

    ////////////////////////////////////////////////
    // Encryption
    RSAES_OAEP_SHA_Encryptor e(publicKey);

    StringSource ss1(message.toStdString(), true,
        new PK_EncryptorFilter(rng, e,
            new StringSink(cipher)
       ) // PK_EncryptorFilter
    ); // StringSource

    ////////////////////////////////////////////////
    // Decryption
    RSAES_OAEP_SHA_Decryptor d(privateKey);

    StringSource ss2(cipher, true,
        new PK_DecryptorFilter(rng, d,
            new StringSink(recovered)


       ) // PK_DecryptorFilter
    ); // StringSource

    cout  << "2. - " << cipher << endl;
    cout  << "3. - " << message.toStdString() << endl;

    QString qstr = QString::fromStdString(cipher);
    valueChanged(qstr);
}
