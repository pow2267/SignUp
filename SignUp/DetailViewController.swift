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
    
    @IBAction func popToRoot() {
        UserInformation.shared.initData()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didDateOfBirthPickerValueChanged() {
        let date = self.dateOfBirthPicker.date
        self.dateOfBirthLabel.text = self.dateFormatter.string(from: date)
    }
    
    @IBAction func phoneFieldEditingChanged() {
        guard let phone = self.phoneField.text else { return }
        
        if phone.isEmpty {
            self.signUpButton.isEnabled = false
        } else {
            self.signUpButton.isEnabled = true
        }
    }
    
    @IBAction func touchUpSignUpButton() {
        setUserInformation()
        guard let viewControllers = self.navigationController?.viewControllers else { return }
        
        for viewController in viewControllers {
            if viewController is ViewController {
                self.navigationController?.popToViewController(viewController, animated: true)
            }
        }
    }
    
    @IBAction func touchUpPrevButton() {
        setUserInformation()
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        didDateOfBirthPickerValueChanged()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setUserInformation() {
        UserInformation.shared.phone = self.phoneField.text
        UserInformation.shared.dateOfBirth = self.dateOfBirthLabel.text
    }
}
