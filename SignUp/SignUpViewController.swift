//
//  SignUpViewController.swift
//  SignUp
//
//  Created by kwon on 2021/07/25.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func popToPrev() {
        self.navigationController?.popViewController(animated: true)
    }
}
