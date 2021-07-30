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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        didDateOfBirthPickerValueChanged()
    }
}
