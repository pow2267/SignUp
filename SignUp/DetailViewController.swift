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
    
    // review: 클로져를 활용하여 초기화해주셨네요. 잘 하셨습니다!
    // 한 눈에 들어와서 읽기 좋은 것 같습니다.
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
        
        // review: 첫 화면으로 돌아가기 위한 로직을 구현해주셨네요.
        // UINavigationController의 popToRootViewController(:animated:) 메서드를 사용하면 간결하게 작성 가능합니다.
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
        // review: override method를 작성 시에는 super의 호출이 필요한 지 꼼꼼히 살펴볼 필요가 있습니다.
        // 해당 메서드의 document를 보면 아래와 같은 내용을 확인할 수 있습니다.
        // "If you override this method without calling super (a common use pattern), you must also override the other methods for handling touch events, even if your implementations do nothing."
        // 따라서, super의 메서드 호출이 필요합니다.
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // UserInformation에 데이터 저장
    func setUserInformation() {
        UserInformation.shared.phone = self.phoneField.text
        UserInformation.shared.dateOfBirth = self.dateOfBirthLabel.text
    }
}
