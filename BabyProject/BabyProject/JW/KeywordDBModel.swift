//
//  SearchDBModel.swift
//  BabyProject
//
//  Created by 박재원 on 2021/07/30.
//

import Foundation

class KeywordDBModel: NSObject{
    
    /// Property
    var itemcode: Int?
    var useage: Int?
    var tag: String?
    
    /// Empty Constructor
    override init() {
    }
    
    /// Constructor
    init(itemcode: Int, useage: Int, tag: String) {
        self.itemcode = itemcode
        self.useage = useage
        self.tag = tag
    }
    
    
    
} // SearchDBModel
