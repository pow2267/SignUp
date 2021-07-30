//
//  SignUpViewController.swift
//  SignUp
//
//  Created by kwon on 2021/07/25.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
      
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var introductionField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    lazy var imagePicker: UIImagePickerController = {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    // 이전 화면으로 돌아갈 때 UserInformation에 저장된 데이터 전부 삭제
    @IBAction func popToPrev() {
        UserInformation.shared.initData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpNextButton() {
        setUserInformation()
    }
    
    // text field의 값이 변경될 때마다 확인해 조건에 맞으면 next 버튼 활성화
    @IBAction func textFieldEditingChanged() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imageView에 gesture recognizer 추가
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
    }
    
    // text field 밖 터치 시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // UIGestureRecognizerDelegate 프로토콜의 기능 구현. imagePicker 보여주기
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.present(self.imagePicker, animated: true, completion: nil)
        return true
    }
    
    // UIImagePickerControllerDelegate 프로토콜의 기능 구현. 사용자가 선택한 이미지를 image view에 표현
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // UserInformation에 데이터 저장
    func setUserInformation() {
        UserInformation.shared.id = self.idField.text
        UserInformation.shared.password = self.passwordField.text
        UserInformation.shared.introduction = self.introductionField.text
        UserInformation.shared.image = self.imageView.image
    }
}
