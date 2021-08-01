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
    var email : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNotice.text = ""

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    

    @IBAction func btnLogin(_ sender: UIButton) {
        if checkEmpty(){
            let checkEmail = tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = tfPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)

            let loginModel = LoginModel()
            loginModel.loginResult(email: checkEmail!, password: password!)
            loginModel.delegate = self
            email = checkEmail!
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

extension LoginViewController: LoginModelProtocol {
    
    func resultOfLogin(nickname: String) {
        //print(nickname)
        if nickname == "loginFail" {
            lblNotice.text = "이메일 혹은 비밀번호가 일치하지 않습니다."
        }else if nickname == "loginError"{
            lblNotice.text = "에러가 발생했습니다. 시스템 관리자에게 문의해주세요."
        }else{
            Share.userCode = email
            Share.userNickName = nickname

            self.performSegue(withIdentifier: "sgLoginSuccess", sender: self)
        }
    }
}

