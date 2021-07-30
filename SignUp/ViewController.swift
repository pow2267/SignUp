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
    
    // text field 밖 터치 시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // UserInformation에 저장된 정보가 있으면 id field에 채워줌
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let id = UserInformation.shared.id else {
            self.idField.text = ""
            return
        }
        
        self.idField.text = id
    }
}

