//
//  SelectPictureViewController.swift
//  Restaurant
//
//  Created by Mert Dusunceli on 6/28/18.
//  Copyright © 2018 Mert Dusunceli. All rights reserved.
//

import UIKit
import FirebaseStorage

class SelectPictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ratingTextField: UITextField!
   
    var imagePicker : UIImagePickerController?
    var imageAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self

    }

    @IBAction func selectPhotoTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .photoLibrary
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        if imagePicker != nil {
            imagePicker!.sourceType = .camera
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageAdded = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        //delete this for production
        nameTextField.text = "test"
        ratingTextField.text = "test1"
        imageAdded = true
        
        if let name = nameTextField.text {
            if let rating = ratingTextField.text {
                if imageAdded && name != "" && rating != "" {
                    // upload picture to firebase
                    let imagesFolder = Storage.storage().reference().child("images")
                    if let image = imageView.image {
                        if let imageData = UIImageJPEGRepresentation(image, 0.1) {
                            
                            imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
                                if let error = error {
                                    self.presentAlert(alert: error.localizedDescription)
                                } else {
                                    // segue to next VC
                                }
                            }
                        }
                    }
                } else {
                    // Error, missing fields
                    self.presentAlert(alert: "You must provide a photo, a name and a rating")
                }
            }
        }
    }
    
    func presentAlert(alert: String) {
        let alertVC = UIAlertController(title: "Error", message: alert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
}





















