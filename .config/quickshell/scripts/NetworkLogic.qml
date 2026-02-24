// NetworkLogic.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    // --- DEBUGGING ---
    property bool debug: false

    // --- RAW STATE ---
    property bool wifiEnabled
    property bool wifiConnected
    property int wifiSignal
    property string wifiSSID

    property bool ethernetConnected

    // --- DERIVED ---
    property int wifiLevel              // 0–4 (UI-friendly)
    property string primaryConnection   // "ethernet" | "wifi" | "none"

    // --- UI OUTPUT ---
    property string iconName

    // --- DATA FOR MENUS ---
    property var knownNetworks: []
    property var availableNetworks: []

    // --- LOGIC ---
    //
    // full [nmcli] to get initial values
    //
    // then [nmcli monitor] to track changes
    //
    // Check nmcli radio wifi for the wifiEnabled bool.
    // Check nmcli -t -f TYPE,STATE device for the ethernetConnected bool and wifiConnected bool.
    // Check nmcli -t -f IN-USE,SSID,SIGNAL device wifi list --rescan no | grep '^\*' for wifiSSID and wifiSignal.

    Process {
        id: wifiEnabledProcess
        command: ["nmcli", "radio", "wifi"]
        running: false
        stdout: StdioCollector {
            id: wifiEnabledCollector
            onStreamFinished: {
                let val = wifiEnabledCollector.text.trim();
                wifiEnabled = (val === "enabled");
            }
        }
    }

    Process {
        id: deviceStateProcess
        command: ["nmcli", "-t", "-f", "TYPE,STATE", "device"]
        running: false
        stdout: StdioCollector {
            id: deviceStateCollector
            onStreamFinished: {
                ethernetConnected = false;
                wifiConnected = false;

                let lines = deviceStateCollector.text.trim().split("\n");
                for (let line of lines) {
                    let parts = line.split(":");
                    let type = parts[0];
                    let state = parts[1];

                    if (type === "ethernet" && state === "connected")
                        ethernetConnected = true;
                    if (type === "wifi" && state === "connected")
                        wifiConnected = true;
                }

                // only fetch Wi-Fi signal and SSID if wifiConnected
                if (wifiConnected) {
                    wifiSignalProcess.running = true;
                } else {
                    wifiSignal = 0;
                    wifiSSID = "";
                }
            }
        }
    }

    Process {
        id: wifiSignalProcess
        command: ["bash", "-c", "nmcli -t -f IN-USE,SSID,SIGNAL device wifi list --rescan no | grep '^\\*'"]
        running: false
        stdout: StdioCollector {
            id: wifiSignalCollector
            onStreamFinished: {
                let line = wifiSignalCollector.text.trim();
                if (line.length === 0) {
                    wifiSignal = 0;
                    wifiSSID = "";
                    return;
                }

                // line is "*:SSID:SIGNAL"
                let parts = line.split(":");
                wifiSSID = parts[1];
                wifiSignal = parseInt(parts[2]);
            }
        }
    }

    // --- REFRESH FUNCTION ---
    function refresh() {
        wifiEnabledProcess.running = false;
        wifiEnabledProcess.running = true;

        deviceStateProcess.running = false;
        deviceStateProcess.running = true;

        updatePrimaryConnection();
        updateWifiLevel();
        updateIcon();

        logState("debugNetworkStuff");
    }

    Process {
        id: toggleProcess
    }

    function toggleWifi() {
        let cmd = wifiEnabled ? "off" : "on";

        toggleProcess.command = ["nmcli", "radio", "wifi", cmd];
        toggleProcess.running = true;

        // refresh after change
        Qt.callLater(refresh);
    }

    function updateWifiLevel() {
        if (!wifiConnected) {
            wifiLevel = 0;
            return;
        }

        if (wifiSignal > 75)
            wifiLevel = 4;
        else if (wifiSignal > 50)
            wifiLevel = 3;
        else if (wifiSignal > 25)
            wifiLevel = 2;
        else
            wifiLevel = 1;
    }

    function updatePrimaryConnection() {
        if (ethernetConnected) {
            primaryConnection = "ethernet";
        } else if (wifiConnected) {
            primaryConnection = "wifi";
        } else if (wifiEnabled) {
            primaryConnection = "wifi-idle";
        } else {
            primaryConnection = "none";
        }
    }

    function updateIcon() {
        if (primaryConnection === "ethernet") {
            iconName = "eth1.svg";
            return;
        }

        if (!wifiEnabled) {
            iconName = "wifi0.svg";
            return;
        }

        if (!wifiConnected) {
            iconName = "wifi1.svg";
            return;
        }

        iconName = "wifi" + wifiLevel + ".svg";
    }

    // --- REACTIVE UPDATES ---

    onWifiSignalChanged: updateWifiLevel()
    onWifiConnectedChanged: {
        updateWifiLevel();
        updatePrimaryConnection();
    }

    onWifiEnabledChanged: updatePrimaryConnection()
    onEthernetConnectedChanged: updatePrimaryConnection()

    onPrimaryConnectionChanged: updateIcon()
    onWifiLevelChanged: updateIcon()

    Component.onCompleted: {
        refresh();
    }

    Timer {
        interval: 3000   // every 3s (tweak later)
        running: true
        repeat: true
        onTriggered: refresh()
    }

    // --- DEBUGGING ---
    function debugFakeState() {
        wifiEnabled = true;
        wifiConnected = true;
        wifiSignal = 64;
        ethernetConnected = false;

        logState("debugFakeState");
    }

    function debugNetworkStuff() {
        logState("debugNetworkStuff");
    }

    function logState(tag) {
        if (!debug)
            return;
        console.log("---- NetworkLogic:", tag);
        console.log("wifiEnabled:", wifiEnabled);
        console.log("wifiConnected:", wifiConnected);
        console.log("wifiSSID:", wifiSSID);
        console.log("wifiSignal:", wifiSignal);
        console.log("wifiLevel:", wifiLevel);
        console.log("ethernetConnected:", ethernetConnected);
        console.log("primaryConnection:", primaryConnection);
        console.log("iconName:", iconName);
        console.log("------------------------------");
    }
}

// networkStatus 0 - Off; 1 - On (not connected); 1 2 3 4 - signal strenght connected
// dont know what to do with ethernet since on cachyos I can be connected to eth + wifi at the same time
//
// Bar Icon i would like ethernet (if connected) to overrite any icon
//
// ControlCenter I would like to only focus on wifi
//
// upcoming NetworkMenu I will want to show this (row can have multiple rows of elements ...):
//
// 1st row: "menu name" toggle switch for wifi radio
//
// 2nd row: ethernet - if connected/available(?)
//
// 3rd row: Known Networks with each having ssid and the icon representing signal strenght and also icon background color if connected (if conneced its at the top)
//
// 4th row: Unknown Networks same thing but unknown
//
// not now but later later way later potencially i will want to add up/down network speed to bar

// function updatePrimaryConnection() {
//     if (ethernetConnected)
//         primaryConnection = "ethernet"
//     else if (wifiConnected)
//         primaryConnection = "wifi"
//     else if (wifiEnabled)
//         primaryConnection = "wifi-idle"
//     else
//         primaryConnection = "none"
// }

// function updateIcon() {
//     if (primaryConnection === "ethernet") {
//         iconName = "ethernet"
//         return
//     }

//     if (!wifiEnabled) {
//         iconName = "wifi-off"
//         return
//     }

//     if (!wifiConnected) {
//         iconName = "wifi-0"
//         return
//     }

//     iconName = "wifi-" + wifiLevel
// }

// function updateWifiLevel() {
//     if (!wifiConnected) {
//         wifiLevel = 0
//         return
//     }

//     if (wifiSignal > 75) wifiLevel = 4
//     else if (wifiSignal > 50) wifiLevel = 3
//     else if (wifiSignal > 25) wifiLevel = 2
//     else wifiLevel = 1
// }
