//
//  SignUpViewController.swift
//  SignUp
//
//  Created by kwon on 2021/07/25.
//

import UIKit

class SignUpViewController: UIViewController, UINavigationControllerDelegate {
      
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
        
        // review: 해당 조건도 위의 &&에 포함시키면 불필요한 if문의 depth가 하나 줄어서 가독성을 향상시킬 수 있을 것 같아요
        if !id.isEmpty && !password.isEmpty && !passwordCheck.isEmpty && !introduction.isEmpty && password == passwordCheck {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
        
//        if !id.isEmpty && !password.isEmpty && !passwordCheck.isEmpty && !introduction.isEmpty {
//           if password == passwordCheck {
//               self.nextButton.isEnabled = true
//           } else {
//               self.nextButton.isEnabled = false
//           }
//       } else {
//           self.nextButton.isEnabled = false
//       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // review: delegate 대신 target-action 패턴을 활용한 방법도 많이 사용되니 알아두시는 것을 추천드립니다~
        // UITapGestureRecognizer의 생성자 중에 target과 sender를 받는 생성자를 활용할 수도 있고, addTarget 메서드를 이용할 수도 있습니다.
        // target은 view.imageView면 안되고 무조건 self여야한다.
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
        
        self.imageView.addGestureRecognizer(tapGesture)
        // isUserInteractionEnabled이 false면 사용자의 터치를 무시함. 반드시 true로 바꿔줄 것
        self.imageView.isUserInteractionEnabled = true
        
        // imageView에 gesture recognizer 추가
//        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
//        tapGesture.delegate = self
//        imageView.addGestureRecognizer(tapGesture)
//        imageView.isUserInteractionEnabled = true
    }
    
    // text field 밖 터치 시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // tapGesture를 target-action 패턴으로 추가해주기 위해 추가한 함수
    // #selector에 사용할 수 있는 메소드는 Objective-C 메소드여야 하기 때문에 함수 앞에 @objc를 붙여줘야 함
    @objc func showImagePicker() {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // UserInformation에 데이터 저장
    func setUserInformation() {
        UserInformation.shared.id = self.idField.text
        UserInformation.shared.password = self.passwordField.text
        UserInformation.shared.introduction = self.introductionField.text
        UserInformation.shared.image = self.imageView.image
    }
}

// review: UIImagePickerControllerDelegate의 메소드임을 잘 나타내기 위해 extension을 활용하는 것은 어떨까요?
// 이렇게 하면 코드의 가독성도 좋아지고, 나중에 수정할 것이 생겼을 때 찾기 수월하답니다.
extension SignUpViewController: UIGestureRecognizerDelegate {
    
    // UIGestureRecognizerDelegate 프로토콜의 기능 구현. imagePicker 보여주기
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.present(self.imagePicker, animated: true, completion: nil)
        return true
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate {
    
    // UIImagePickerControllerDelegate 프로토콜의 기능 구현. 사용자가 선택한 이미지를 image view에 표현
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
