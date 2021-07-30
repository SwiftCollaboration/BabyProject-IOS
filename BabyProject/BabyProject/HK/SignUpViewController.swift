//
//  SignUpViewController.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/30.
//

import UIKit
import TextFieldEffects

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfEmail: HoshiTextField!
    @IBOutlet weak var tfPassword: HoshiTextField!
    @IBOutlet weak var tfNickname: HoshiTextField!
    @IBOutlet weak var tfPhone: HoshiTextField!
    @IBOutlet weak var tfBabyage: HoshiTextField!
    @IBOutlet weak var lblNotice: UILabel!
    
    lazy var tfInput: [HoshiTextField] = [tfEmail, tfPassword, tfNickname, tfPhone, tfBabyage]
    let textFieldArr = ["이메일", "비밀번호", "닉네임", "휴대폰 번호", "아기 나이"]
    var dbInputText: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblNotice.text = ""
//        tfEmail.becomeFirstResponder()
    }
    
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        if checkEmptyText(){
            if checkTextRule(){
                if dbInsertUser(){
                    let resultAlert = UIAlertController(title: "가입 완료", message: "가입을 축하드립니다...", preferredStyle: .alert)
                    let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                        self.performSegue(withIdentifier: "sgSignUpSuccess", sender: self)
                    })
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil)

                }else{
                    let resultAlert = UIAlertController(title: "실패", message: "에러가 발생했습니다.", preferredStyle: .alert)
                    let onAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    resultAlert.addAction(onAction)
                    present(resultAlert, animated: true, completion: nil)
                }
            }
        }
    }
    
    // text 공백 체크
    func checkEmptyText()-> Bool{
        dbInputText.removeAll()
        for i in 0..<tfInput.count{
            if tfInput[i].text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
                lblNotice.text = "\(textFieldArr[i])을 입력해주세요."
                tfInput[i].becomeFirstResponder()
                return false
            }else{
                let input = tfInput[i].text?.trimmingCharacters(in: .whitespacesAndNewlines)
                dbInputText.append(input!)
                print(dbInputText[i])
            }
        }
        return true
    }
    
    func checkTextRule() -> Bool {
        let checkSignUpInputText = CheckSignUpInputField()
        
        for i in 0..<dbInputText.count{
            switch i {
            case 0:
                if checkSignUpInputText.isValidEmail(email: dbInputText[i]){
                    continue
                }else{
                    lblNotice.text = "이메일 형식이 올바르지 않습니다."
                    tfInput[i].becomeFirstResponder()
                    return false
                }
            case 1:
                if checkSignUpInputText.isValidPassword(password: dbInputText[i]){
                    continue
                }else{
                    lblNotice.text = "비밀번호는 8-20자 이내의 문자와 숫자를 포함하여 입력해주세요."
                    tfInput[i].becomeFirstResponder()
                    return false
                }
            case 2:
                if checkSignUpInputText.isValidNickname(nickname: dbInputText[i]){
                    continue
                }else{
                    lblNotice.text = "닉네임은 2-6자 이내의 문자와 숫자만 입력해주세요."
                    tfInput[i].becomeFirstResponder()
                    return false
                }
            case 3:
                if checkSignUpInputText.isValidPhone(phone: dbInputText[i]){
                    continue
                }else{
                    lblNotice.text = "휴대폰 번호 형식이 올바르지 않습니다."
                    tfInput[i].becomeFirstResponder()
                    return false
                }
            default:
                continue
            }
        }
        return true
    }
    
    // DB : insert user
    func dbInsertUser() -> Bool {
        let insertUser = UserInsertModel()
        let result = insertUser.insertUser(email: dbInputText[0], password: dbInputText[1], nickname: dbInputText[2], phone: dbInputText[3], babyage: dbInputText[4])

        return result
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
