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
        // review: viewWillAppear(_ animated: Bool)의 animated는 현재 ViewController가 화면에 나타나기 전에 animation과 함께 나타나는 지를 알려주는 정보에 해당합니다.
        // 임의로 true로 변경하여 전달하는 것보다는 해당 정보를 포함하여 super에 넘겨주는 것이 올바른 방법입니다.
        super.viewWillAppear(animated)
        
        // review: self.idField.text = UserInformation.shared.id 와 같이 간결하게 작성 가능합니다.
        // (두 값 모두 옵셔널이므로)
        self.idField.text = UserInformation.shared.id
        
//        guard let id = UserInformation.shared.id else {
//            self.idField.text = ""
//            return
//        }
//
//        self.idField.text = id
    }
}

