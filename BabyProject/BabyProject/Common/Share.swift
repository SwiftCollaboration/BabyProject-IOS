//
//  Share.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/29.
//

import Foundation

struct Share {
    static var userCode = ""
    static var userNickName = ""
    
    //******* IP 쓴 채로 push 안하도록 주의!! <<<<<<<<<< 보안!!!!!!!
    func url(_ fileName: String) -> String{
        let url = "http://<#macIP#>:8080/bebeProject/\(fileName)"
        return url
    }
    
    func imgUrl(_ fileName: String) -> String{
        let url = "http://<#macIP#>:8080/bebeProject/image/\(fileName)"
        return url
    }
}
