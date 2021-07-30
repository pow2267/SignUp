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
