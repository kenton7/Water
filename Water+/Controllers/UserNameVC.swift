//
//  UserNameVC.swift
//  WaterPlus
//
//  Created by Илья Кузнецов on 25.10.2020.
//  Copyright © 2020 Ilya Kuznetsov. All rights reserved.
//

import UIKit

class UserNameVC: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var outletNext: UIButton!
    @IBOutlet weak var uploadPhotoView: UIView!
    @IBOutlet weak var labelInViewWithPhoto: UILabel!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var buttonUploadPhotoOutlet: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imageView = UIImage()
    
    
    enum ImageSource {
            case photoLibrary
            case camera
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        textField.delegate = self
        uploadPhotoView.isHidden = true
        outletNext.isUserInteractionEnabled = false
        outletNext.alpha = 0.5
        buttonUploadPhotoOutlet.layer.cornerRadius = buttonUploadPhotoOutlet.frame.height / 2
        outletNext.layer.cornerRadius = outletNext.frame.height / 2
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 30/255, green: 144/255, blue: 255/255, alpha: 1).cgColor
        textField.borderStyle = .none
        textField.layer.addSublayer(bottomLine)

        greetingLabel.text = ""
        let greetingText = "Привет! Как тебя зовут?"
        var characterIndex = 0.0
        for oneLetter in greetingText {
            Timer.scheduledTimer(withTimeInterval: 0.05 * characterIndex, repeats: false) { (timer) in
                self.greetingLabel.text?.append(oneLetter)
        }
            characterIndex += 1
        }
        
        //вызываем наблюдателя для наблюдения за появлением клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //наблюдатель для наблюдения за скрытием клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func updateLabelWithUserName() {
        let userName = textField.text
        UserDefaults.standard.setValue(textField.text, forKey: "userName")
        if userName == nil {
            uploadPhotoView.isHidden = true
        } else {
            greetingLabel.text = "Приятно познакомиться, \(textField.text!)!"
            //greetingLabel.isHidden = true
            uploadPhotoView.isHidden = false
            UIView.animate(withDuration: 3, animations: {
                self.uploadPhotoView.frame.origin.y -= 20
            }, completion: nil)
            labelInViewWithPhoto.text = "Давай выберем фото?"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    //скрываем клаву и возвращаем элементы обратно
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        UIView.animate(withDuration: 2, animations: {
            self.uploadPhotoView.frame.origin.y = self.textField.frame.origin.y
            self.updateLabelWithUserName()
        }, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)

        if !text.isEmpty{
            outletNext?.isUserInteractionEnabled = true
            outletNext?.alpha = 1.0
        } else {
            outletNext?.isUserInteractionEnabled = false
            outletNext?.alpha = 0.5
        }
        return true
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func uploadPhoto(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                    selectImageFrom(.photoLibrary)
                    return
                }
                selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            switch source {
            case .camera:
                imagePicker.sourceType = .camera
            case .photoLibrary:
                imagePicker.sourceType = .photoLibrary
            }
            present(imagePicker, animated: true, completion: nil)
        }

    //MARK: - Saving Image here
        @IBAction func save(_ sender: AnyObject) {
            guard let selectedImage = imageViewOutlet.image else {
                print("Image not found!")
                return
            }
            UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }

        //MARK: - Add image to Library
        @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                // we got back an error!
                showAlertWith(title: "Save error", message: error.localizedDescription)
            } else {
                showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
            }
        }

        func showAlertWith(title: String, message: String){
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //updateLabelWithUserName()
        self.view.endEditing(true)
    }

}

extension UserNameVC: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageViewOutlet.image = selectedImage
        imageViewOutlet.layer.borderWidth = 1
            imageViewOutlet.layer.masksToBounds = false
            imageViewOutlet.layer.borderColor = UIColor.black.cgColor
            imageViewOutlet.layer.cornerRadius = imageViewOutlet.frame.height / 2
            imageViewOutlet.clipsToBounds = true
    }
}

