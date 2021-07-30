//
//  ViewController.swift
//  SignUp
//
//  Created by kwon on 2021/07/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var idField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let id = UserInformation.shared.id else {
            self.idField.text = ""
            return
        }
        self.idField.text = id
    }
}

