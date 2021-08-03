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
    static var urlPath = "http://192.168.0.127:8080/bebeProject/ItemAddInsert_ios.jsp" // file 경로 지정
    
    struct ItemInsertPost{
        static let data = ItemInsertPost()
        
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]//HTTP 헤더
        
        // POST할 데이터
        func insertItem(category: String, useAge: String, itemTitle: String, itemContent: String, itemImage: [UIImage], itemPrice: Int, userNickname: String, address: String, tag: String, user_email: String) -> Bool{
            var result: Bool = true
            
            // 이미지를 제외한 Data
            let body: Parameters = [
                "category": category,
                "useAge": useAge,
                "itemTitle": itemTitle,
                "itemContent": itemContent,
                "itemPrice": itemPrice,
                "userNickname": userNickname,
                "address": address,
                "tag": tag,
                "user_email": user_email
            ]
            
            // multipart upload
            AF.upload(multipartFormData: { (multipart) in
                if let imageData = itemImage.jpegData(compressionQuality: 1) {
                    // 이미지 Data 설정
                    multipart.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
                }
                for (key, value) in body {
                    // 이미지를 제외한 Data 설정
                    multipart.append("\(value)".data(using: .utf8, allowLossyConversion: false)!, withName: "\(key)")
                }
            }, to: urlPath // 전달할 url 주소
            ,method: .post // 전달 방식
            ,headers: headers).responseJSON(completionHandler: {(response) in // 헤더와 응답처리
                print(response)
                
                if let err = response.error{ // 응답 에러
                    print(err)
                    result = false
                }else{
                    print("item Insert Success") // 응답 성공
                    
                    let json = response.data
                    
                    if (json != nil){
                        print(json)
                    }
                    result = true
                }
            })
            
            return result
        }
    }
}
    
    
//    // 잘 불러왔다면 true를 return
//    func insertItems(category: String, useAge: String, itemTitle: String, itemContent: String, itemImage: String, itemPrice: Int, userNickname: String, address: String, tag: String, user_email: String) -> Bool{
//        var result: Bool = true
//        let urlAdd = "?category=\(category)&useAge=\(useAge)&itemTitle=\(itemTitle)&itemContent=\(itemContent)&itemImage=\(itemImage)&itemPrice=\(itemPrice)&userNickname=\(userNickname)&address=\(address)&tag=\(tag)&user_email=\(user_email)" // urlPath 뒤에 붙는 주소
//        urlPath = urlPath + urlAdd
//        print(urlPath)
//
//        // 한글 url encoding
//        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//
//        let url: URL = URL(string: urlPath)!
//        // Session과 URL 연결
//        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
//        // Task를 정의, Json의 전체를 가져오기 위함,
//        let task = defaultSession.dataTask(with: url){(data, response, error) in
//            if error != nil {
//                print("Failed to insert data")
//                result = false
//            }else {
//                print("Data is inserted")
//                result = true
//            }
//        }
//        task.resume() // task 실행
//        return result // 입력이 잘되면 true, 안되면 false를 return
//    }
//
//}
//
//
