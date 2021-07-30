//
//  DetailViewController.swift
//  SignUp
//
//  Created by kwon on 2021/07/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // root view로 돌아가기. UserInformation에 저장된 데이터 초기화
    @IBAction func popToRoot() {
        UserInformation.shared.initData()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // date picker의 값을 date label에 표현
    @IBAction func didDateOfBirthPickerValueChanged() {
        let date = self.dateOfBirthPicker.date
        self.dateOfBirthLabel.text = self.dateFormatter.string(from: date)
    }
    
    // phone text field 값이 변경될 때마다 확인해서 sign up 버튼 활성/비활성
    @IBAction func phoneFieldEditingChanged() {
        guard let phone = self.phoneField.text else { return }
        
        if phone.isEmpty {
            self.signUpButton.isEnabled = false
        } else {
            self.signUpButton.isEnabled = true
        }
    }
    
    // UserInformation에 데이터 저장 및 root view로 이동
    @IBAction func touchUpSignUpButton() {
        setUserInformation()
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            if viewController is ViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    // 현재 입력된 정보들을 UserInformation에 저장 및 이전 view로 이동
    @IBAction func touchUpPrevButton() {
        setUserInformation()
        self.navigationController?.popViewController(animated: true)
    }

    // 처음 view가 로드될 때 date label에도 오늘의 날짜 입력
    override func viewDidLoad() {
        super.viewDidLoad()
        didDateOfBirthPickerValueChanged()
    }
    
    // text field 밖 터치 시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // UserInformation에 데이터 저장
    func setUserInformation() {
        UserInformation.shared.phone = self.phoneField.text
        UserInformation.shared.dateOfBirth = self.dateOfBirthLabel.text
    }
}
