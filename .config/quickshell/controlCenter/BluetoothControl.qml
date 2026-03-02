// BluetoothControl.qml
import QtQuick
import Quickshell.Bluetooth

ControlMenu {
    id: root

    mainName: "Bluetooth"
    sectionsModel: [
        {
            title: "My Devices",
            items: [
                { icon: "../assets/bt2.svg", name: "TRN BT20S PRO", state: true },
                { icon: "../assets/bt1.svg", name: "BT_Controller1", state: false }
            ]
        },
        {
            title: "Available Devices",
            items: [
                { icon: "../assets/bt1.svg", name: "Bluetooth_kb", state: false },
                { icon: "../assets/bt1.svg", name: "Bluetooth_speaker", state: false }
            ]
        }
    ]

}
