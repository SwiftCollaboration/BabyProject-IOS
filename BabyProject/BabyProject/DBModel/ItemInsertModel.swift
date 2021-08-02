//
//  ItemInsertModel.swift
//  BabyProject
//
//  Created by TJ on 2021/08/02.
//

import Foundation
import Alamofire

// Insert, Update, Delete할 때에는 protocol이 필요 X

class ItemInsertModel {
    var share = Share()
    var urlPath = "http://192.168.0.127:8080/bebeProject/ItemAddInsert_ios.jsp" // file 경로 지정
    
    // 잘 불러왔다면 true를 return
    func insertItems(category: String, useAge: String, itemTitle: String, itemContent: String, itemImage: String, itemPrice: Int, userNickname: String, address: String, tag: String, user_email: String) -> Bool{
        var result: Bool = true
        let urlAdd = "?category=\(category)&useAge=\(useAge)&itemTitle=\(itemTitle)&itemContent=\(itemContent)&itemImage=\(itemImage)&itemPrice=\(itemPrice)&userNickname=\(userNickname)&address=\(address)&tag=\(tag)&user_email=\(user_email)" // urlPath 뒤에 붙는 주소
        urlPath = urlPath + urlAdd
        print(urlPath)
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        // Session과 URL 연결
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        // Task를 정의, Json의 전체를 가져오기 위함,
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to insert data")
                result = false
            }else {
                print("Data is inserted")
                result = true
            }
        }
        task.resume() // task 실행
        return result // 입력이 잘되면 true, 안되면 false를 return
    }
    
}


