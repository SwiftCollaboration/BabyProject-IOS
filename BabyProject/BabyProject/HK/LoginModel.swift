//
//  LoginModel.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/31.
//

import Foundation

protocol LoginModelProtocol{
    func itemDownloaded(items: NSMutableArray)
}

class LoginModel{

    func loginResult(email: String, password: String){

        var urlPath = "login.jsp"
        let urlAdd = "?email=\(email)&password=\(password)"
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
                print("Failed to download data")
            }else{
                print("Data is downloaded")
                self.checkResult(data!)
            }
        }
        task.resume()
    }

    func checkResult(_ data: Data){
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }

        var jsonElement = NSDictionary()
        let locations = NSMutableArray()

        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            if let result = jsonElement["result"] as? String{
                locations.add(result)
            }
        }
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.delegate.itemDownloaded(items: locations)
        })
    }
}
