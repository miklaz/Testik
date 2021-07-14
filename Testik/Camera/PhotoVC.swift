//
//  PhotoVC.swift
//  Testik
//
//  Created by Михаил Зайцев on 01.07.2021.
//

import UIKit
import AVFoundation

class PhotoVC: UIViewController {

    // MARK: - Const, Var & Outlets
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var savePhotoButton: UIButton!
    
    var photo: UIImage?
    
    // MARK: - VС Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        savePhotoButton.alpha = 0
    }
    
    // MARK: - Methods
    // Обработка результата сохранения фото
    @objc func image(_ image: UIImage,
        didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("ERROR: \(error)")
        }
    }
    
    func photoSelect(type: UIImagePickerController.SourceType) {
        // Проверка, поддерживает ли устройство камеру
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return showAlert("Your device does not have a camera!")}
        // Создаём контроллер и настраиваем его
        let imagePickerController = UIImagePickerController()
        // Источник изображений
        imagePickerController.sourceType = type
        // Изображение можно редактировать
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
                
        // Показываем контроллер
        present(imagePickerController, animated: true)
    }
    
    func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    // MARK: - IBActions
    @IBAction func takePicture(_ sender: UIButton) {    //  Выбор откуда взять фото
        self.photoSelect(type: .camera)
    }
    
    @IBAction func save(_ sender: AnyObject) {      //  Cохранение фото пользователя в Photo Library
        UIImageWriteToSavedPhotosAlbum(photo!, self,
                #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        showAlert("Photo saved!")
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
