//
//  UserDBModel.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/31.
//

import Foundation

class UserDBModel: NSObject{
    
    var usercode : String?
    var email : String?
    var password : String?
    var nickname : String?
    var phone : String?
    var babyage : String?
    var rating : String?
    var signupdate : String?
    var signoutdate : String?
    
    override init() {
    }

    
    init(usercode: String, email: String, password: String, nickname: String, phone: String, babyage: String, rating: String, signupdate: String, signoutdate: String){
        self.usercode = usercode
        self.email = email
        self.password = password
        self.nickname = nickname
        self.phone = phone
        self.babyage = babyage
        self.rating = rating
        self.signupdate = signupdate
        self.signoutdate = signoutdate
    }

}
