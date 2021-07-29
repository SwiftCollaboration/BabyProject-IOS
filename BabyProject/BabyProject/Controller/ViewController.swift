//
//  ViewController.swift
//  BabyProject
//
//  Created by hyogang on 2021/07/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnMJ: UIButton!
    @IBOutlet weak var btnJW: UIButton!
    @IBOutlet weak var btnSA: UIButton!
    @IBOutlet weak var btnDH: UIButton!
    @IBOutlet weak var btnCH: UIButton!
    @IBOutlet weak var btnHK: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMJ.addTarget(self, action: #selector(goMJ), for: .touchUpInside)
        btnJW.addTarget(self, action: #selector(goJW), for: .touchUpInside)
        btnSA.addTarget(self, action: #selector(goSA), for: .touchUpInside)
        btnDH.addTarget(self, action: #selector(goDH), for: .touchUpInside)
        btnCH.addTarget(self, action: #selector(goCH), for: .touchUpInside)
        btnHK.addTarget(self, action: #selector(goHK), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func goHK() {
           let storyboard = UIStoryboard(name: "HK", bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "HKViewController") as! HKViewController
           destinationVC.modalPresentationStyle = .fullScreen
           present(destinationVC, animated: true, completion: nil)
       }
       @objc func goCH() {
           let storyboard = UIStoryboard(name: "CH", bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "CHViewController") as! CHViewController
           destinationVC.modalPresentationStyle = .fullScreen
           present(destinationVC, animated: true, completion: nil)
       }
       @objc func goJW() {
           let storyboard = UIStoryboard(name: "JW", bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "JWViewController") as! JWViewController
           destinationVC.modalPresentationStyle = .fullScreen
           present(destinationVC, animated: true, completion: nil)
       }
       @objc func goMJ() {
           let storyboard = UIStoryboard(name: "MJ", bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "MJViewController") as! MJViewController
           destinationVC.modalPresentationStyle = .fullScreen
           present(destinationVC, animated: true, completion: nil)
       }
       @objc func goSA() {
           let storyboard = UIStoryboard(name: "SA", bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "SAViewController") as! SAViewController
           destinationVC.modalPresentationStyle = .fullScreen
           present(destinationVC, animated: true, completion: nil)
       }
       @objc func goDH() {
           let storyboard = UIStoryboard(name: "DH", bundle: nil)
           let destinationVC = storyboard.instantiateViewController(withIdentifier: "DHViewController") as! DHViewController
           destinationVC.modalPresentationStyle = .fullScreen
           present(destinationVC, animated: true, completion: nil)
       }


}

