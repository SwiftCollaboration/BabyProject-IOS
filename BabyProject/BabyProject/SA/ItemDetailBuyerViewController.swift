//
//  ItemDetailBuyerViewController.swift
//  BabyProject
//
//  Created by TJ on 2021/08/03.
//

import UIKit

// DB Model
var detailBuyer_category = ""
var detailBuyer_useage = ""
var detailBuyer_itemtitle = ""
var detailBuyer_itemcontent = ""
var detailBuyer_itemimage = ""
var detailBuyer_itemprice = 0
var detailBuyer_usernickname = "" // ShareVar
var detailBuyer_address = ""
var detailBuyer_tag = ""
var detailBuyer_dealCompleteDate: Date = Date()
var detailBuyer_deleteDate: Date = Date()
var detailBuyer_item_usercode = "" // ShareVar

class ItemDetailBuyerViewController: UIViewController {
    @IBOutlet weak var btnTradeStatus: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategoryAgePrice: UILabel! // 통합 라벨
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblUseAge: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnChat: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 닉네임 라벨
        lblNickname.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        lblNickname.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)
        
        // 제목 라벨
        lblTitle.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        lblTitle.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)
        
        // lblCategoryAgePrice 라벨
        lblCategoryAgePrice.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        lblCategoryAgePrice.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)
        
        // tagCollectionView
        tagCollectionView.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        tagCollectionView.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)
        
        // tvContent (TextView)
        tvContent.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        tvContent.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)
        
        // 거래 상태 버튼
        btnTradeStatus.layer.cornerRadius = 10
        
        // 채팅하기 버튼
        btnChat.layer.cornerRadius = 10
        

        // Do any additional setup after loading the view.
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
