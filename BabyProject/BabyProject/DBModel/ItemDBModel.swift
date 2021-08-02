//
//  ItemDBModel.swift
//  BabyProject
//
//  Created by TJ on 2021/08/02.
//

import Foundation

// JAVA의 Bean과 같음
// Json 사용 시 class에 type을 주는 것이 좋음

class ItemDBModel: NSObject{ // NSObject :: 가장 큰 타입
    // 전부 다 nil 값 허용
    var category: Int?
    var useAge: Int?
    var itemTitle: String?
    var itemContent: String?
    var itemImage: String?
    var itemPrice: Int?
    var userNickname: String?
    var address: String?
    var tag: String?
    var uploadDate: Date?
    var dealCompleteDate: Date?
    var deleteDate: Date?
    var item_userCode: Int?
    
    // 생성자 생성
    // Empty constructor
    override init() {
        
    }
    
    init(category: Int, useAge: Int, itemTitle: String, itemContent: String, itemImage: String, itemPrice: Int, userNickname: String, address: String, tag: String,
         uploadDate: Date, dealCompleteDate: Date, deleteDate: Date, item_userCode: Int) {
        self.category = category
        self.useAge = useAge
        self.itemTitle = itemTitle
        self.itemContent = itemContent
        self.itemImage = itemImage
        self.itemPrice = itemPrice
        self.userNickname = userNickname
        self.address = address
        self.tag = tag
        self.uploadDate = uploadDate
        self.dealCompleteDate = dealCompleteDate
        self.deleteDate = deleteDate
        self.item_userCode = item_userCode
    }
    
}

