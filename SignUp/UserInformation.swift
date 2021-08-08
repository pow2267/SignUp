//
//  UserInformation.swift
//  SignUp
//
//  Created by kwon on 2021/07/29.
//

import Foundation
import UIKit

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    // review: 싱글턴 클래스는 보통 내부에서 생성한 static let 프로퍼티를 제외하고 외부에서 생성하지 못하는 것이 원칙이므로,
    // 생성자를 private으로 선언하여 외부에서 생성되지 못하도록 막는 것이 일반적입니다.
    private init() {}
    
    var id: String?
    var password: String?
    var image: UIImage?
    var introduction: String?
    var phone: String?
    var dateOfBirth: String?
    
    func initData() {
        self.id = nil
        self.password = nil
        self.image = nil
        self.introduction = nil
        self.phone = nil
        self.dateOfBirth = nil
    }
}
