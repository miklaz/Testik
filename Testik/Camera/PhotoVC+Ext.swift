//
//  PhotoVC+Ext.swift
//  Testik
//
//  Created by Михаил Зайцев on 01.07.2021.
//

import UIKit
import AVFoundation

extension PhotoVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: - Methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Если нажали на кнопку Отмена, то UIImagePickerController надо закрыть
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Мы получили медиа от контроллера
        // Изображение надо достать из словаря info
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatarImageView.image = image
            photo = avatarImageView.image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            avatarImageView.image = image
            photo = avatarImageView.image
        }
        
        savePhotoButton.alpha = 1
        avatarImageView.backgroundColor = UIColor.init(named: ".default")
        
        // Закрываем UIImagePickerController
        picker.dismiss(animated: true)
    }
    
}
