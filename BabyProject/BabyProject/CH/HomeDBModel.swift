//
//  HomeDBModel.swift
//  BabyProject
//
//  Created by 이찬호 on 2021/07/31.
//

import Foundation

class HomeDBModel: NSObject{
    var itemtitle: String?
    var itemimage: String?
    var address: String?
    var babyage: String?
    var itemcode: String?
    
    // Empty constructor
    override init() {
        
    }
    
    init(itemtitle: String, itemimage: String, address: String, babyage: String, itemcode: String) {
        self.itemtitle = itemtitle
        self.itemimage = itemimage
        self.address = address
        self.babyage = babyage
        self.itemcode = itemcode
    }
}
