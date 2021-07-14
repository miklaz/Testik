//
//  BluetoothVC+Ext.swift
//  Testik
//
//  Created by Михаил Зайцев on 08.07.2021.
//

import CoreBluetooth

extension BluetoothVC: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .poweredOff:
                print("Is Powered Off.")
                statusLabel.text = "Bluetooth is turned off.\nPlease turn on Bluetooth!"
                statusLabel.textColor = .systemRed
                bluetoothSettingsButton.alpha = 1
            case .poweredOn:
                print("Is Powered On.")
                statusLabel.text = "Bluetooth is working!"
                statusLabel.textColor = .systemGreen
                bluetoothSettingsButton.alpha = 0
            case .unsupported:
                print("Is Unsupported.")
                statusLabel.text = "Bluetooth is not supported on your device.\n(or Bluetooth is not working))"
                statusLabel.textColor = .systemRed
                bluetoothSettingsButton.alpha = 1
            case .unauthorized:
                    print("Is Unauthorized.")
            case .unknown:
                print("Unknown")
                showAlert("Unknown error :(")
            case .resetting:
                print("Resetting")
            @unknown default:
                print("Error")
        }
    }

}
