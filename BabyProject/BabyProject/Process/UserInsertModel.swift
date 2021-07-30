//
//  UserInsertModel.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/30.
//

import Foundation

class UserInsertModel{
    
    func insertUser(email: String, password: String, nickname: String, phone: String, babyage: String) -> Bool{
        
        var result : Bool = true
        
        var urlPath = "userInsert.jsp"
        let urlAdd = "?email=\(email)&password=\(password)&nickname=\(nickname)&phone=\(phone)&babyage=\(babyage)"
        urlPath += urlAdd
        
        let share = Share();
        urlPath = share.url(urlPath)
        print(urlPath)
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert data")
                result = false
            }else{
                print("Data is inserted")
                result = true
            }
        }
        task.resume()
        return result
    }
}
