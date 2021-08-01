//
//  HKViewController.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/29.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

class HKViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "System Bold", size: 20), size: 20)]
    }
    
    
    @IBAction func btnKakao(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                UserApi.shared.me() {(user, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("me() success.")
                        
                        print(user!.id!)
                        print(user!.kakaoAccount!.email!)
                        print(user!.kakaoAccount!.profile!.nickname!)
                    }
                }

                //do something
                _ = oauthToken
            }
        }
        
        self.performSegue(withIdentifier: "sgLoginAPI", sender: self)
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgLogin", sender: self)
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgSignUp", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
