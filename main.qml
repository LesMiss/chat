import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

//import Encrypt 1.0

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    property string encMsg: ""

    Rectangle {
        id: rectangle
        y: 243
        height: 55
        color: "#111111"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        TextField {
            id: textFieldMessage
            height: 32
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: buttonSend.left
            placeholderTextColor: "#707070"
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            placeholderText: qsTr("Send message")
            onAccepted: mouseArea.clicked()
            background: Rectangle {
                id: back
                color: "#111111"
                anchors.fill: parent
            }
        }

        Rectangle {
            id: buttonSend
            x: 555
            y: -227
            width: 56
            height: 28
            color: "#438df7"
            radius: 6
            border.width: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20

            Text {
                id: text1
                color: "#ffffff"
                text: qsTr("Send")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
                font.family: "Courier"
                anchors.horizontalCenter: parent.horizontalCenter
            }

//            EncryptionClass {
//                id: encrypt
//            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent

                onClicked: {
                    encrypt.encryptMessage(textFieldMessage.text)
                    listModelMessages.append({

                                                 message: encMsg

                                             })
                    textFieldMessage.clear()
                }
            }
        }
    }

    Rectangle {
        id: rectangle1
        color: "#111111"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: rectangle2.top
        anchors.bottomMargin: 0

        ListView {
            id: listView
            anchors.fill: parent
            Layout.fillHeight: true
            Layout.fillWidth: true

            model: ListModel {
                id: listModelMessages
                ListElement {
                    message: "Hi man"
                }
            }

            delegate: ItemDelegate {
                text: message
            }
            ScrollBar.vertical: ScrollBar {}
        }
    }

    Rectangle {
        id: rectangle2
        y: 208
        height: 1
        color: "#1c1c1c"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: rectangle.top
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.rightMargin: 0
    }

    Connections {
        target: encrypt
        onValueChanged: encMsg = encryptMsg
    }
}
