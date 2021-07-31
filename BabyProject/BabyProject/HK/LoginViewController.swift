//
//  LoginViewController.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/30.
//

import UIKit
import TextFieldEffects

class LoginViewController: UIViewController {

    @IBOutlet weak var tfEmail: HoshiTextField!
    @IBOutlet weak var tfPassword: HoshiTextField!
    @IBOutlet weak var lblNotice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNotice.text = ""

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogin(_ sender: UIButton) {
        if checkEmpty(){
            
            let email = tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let loginModel = LoginModel()
            let result = loginModel.loginResult(email: email!, password: password!)
            //self.performSegue(withIdentifier: "sgLoginSuccess", sender: self)
        }
    }
    
    
    @IBAction func btnFindPassword(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgFindPassword", sender: self)
    }
    
    func checkEmpty() -> Bool {
        let email = tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email?.count == 0 {
            lblNotice.text = "이메일을 입력해주세요."
            tfEmail.becomeFirstResponder()
            return false
        }
        if password?.count == 0 {
            lblNotice.text = "비밀번호를 입력해주세요."
            tfPassword.becomeFirstResponder()
            return false
        }
        return true
    }
    
    
    
    // touch시 keyboard 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

extension LoginViewController: LoginModelProtocol{
    func itemDownloaded(items: NSMutableArray) {
        var userinfo = items
    }
}

