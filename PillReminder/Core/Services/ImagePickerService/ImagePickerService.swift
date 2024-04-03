//
//  ImagePickerService.swift
//  PillReminder
//
//  Created by Александр Ветряков on 28.12.2023.
//

import UIKit

class ImagePickerService: NSObject {
    var imageCallback: ((UIImage) -> ())?
    var videoCallback: ((URL?) -> ())?
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        return picker
    }()
    
    func presentCameraPicker() {
        if let presenter = UIApplication.topViewController() {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                imagePicker.sourceType = .camera
                imagePicker.cameraDevice = .front
                imagePicker.delegate = self
                presenter.present(imagePicker, animated: true, completion: nil)
            } else {
               print("Camera is not available on this device")
            }
        }
    }
    
    func presentPhotosPicker() {
        if let presenter = UIApplication.topViewController() {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            presenter.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func presentVideoAndPhotoPicker() {
        if let presenter = UIApplication.topViewController() {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            presenter.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension ImagePickerService: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageCallback?(image)
        } else if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            self.videoCallback?(videoURL)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let upSideDownImage = image.updateImageOrientionUpSide() {
            self.imageCallback?(upSideDownImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
