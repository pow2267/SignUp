//
//  SignUpViewController.swift
//  SignUp
//
//  Created by kwon on 2021/07/25.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var introductionField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpNextButton() {
        setUserInformation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.present(self.imagePicker, animated: true, completion: nil)
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        guard let id = self.idField.text else { return }
        guard let password = self.passwordField.text else { return }
        guard let passwordCheck = self.passwordCheckField.text else { return }
        guard let introduction = self.introductionField.text else { return }
        guard self.imageView.image != nil else { return }
        
        if !id.isEmpty && !password.isEmpty && !passwordCheck.isEmpty && !introduction.isEmpty {
            if password == passwordCheck {
                self.nextButton.isEnabled = true
            } else {
                self.nextButton.isEnabled = false
            }
        } else {
            self.nextButton.isEnabled = false
        }
    }
    
    func setUserInformation() {
        UserInformation.shared.id = self.idField.text
        UserInformation.shared.password = self.passwordField.text
        UserInformation.shared.introduction = self.introductionField.text
        UserInformation.shared.image = self.imageView.image
    }
}
