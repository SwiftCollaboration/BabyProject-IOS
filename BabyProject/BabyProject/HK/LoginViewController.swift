//
//  LoginViewController.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/30.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgLoginSuccess", sender: self)
    }
    
    
    @IBAction func btnFindPassword(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sgFindPassword", sender: self)
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
