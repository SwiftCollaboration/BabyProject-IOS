//
//  SearchDBModel.swift
//  BabyProject
//
//  Created by 박재원 on 2021/08/02.
//

import Foundation

class SearchDBModel: NSObject{
    
    /// Property
    var itemcode: String?
    var category: String?
    var useage: String?
    var itemtitle: String?
    var itemcontent: String?
    var itemimage: String?
    var itemprice: String?
    var usernickname: String?
    var address: String?
    var tag: String?
    var uploaddate: String?
    var dealcompletedate: String?
    var deletedate: String?
    
    /// Empty Constructor
    override init() {
    }
    
    /// Constructor
    init(itemcode: String, category: String, useage: String, itemtitle: String, itemcontent: String, itemimage: String, itemprice: String, usernickname: String, address: String, tag: String, uploaddate: String, dealcompletedate: String, deletedate: String) {
        
        self.itemcode = itemcode
        self.category = category
        self.useage = useage
        self.itemtitle = itemtitle
        self.itemcontent = itemcontent
        self.itemimage = itemimage
        self.itemprice = itemprice
        self.usernickname = usernickname
        self.address = address
        self.tag = tag
        self.uploaddate = uploaddate
        self.dealcompletedate = dealcompletedate
        self.deletedate = deletedate
     
    }
    
    
    
} // SearchDBModel
