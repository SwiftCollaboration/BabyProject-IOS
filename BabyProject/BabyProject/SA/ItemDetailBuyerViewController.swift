//
//  ItemDetailBuyerViewController.swift
//  BabyProject
//
//  Created by TJ on 2021/08/03.
//

import UIKit

// DB Model
var detailBuyer_category = "문구/잡화"
var detailBuyer_useage = ""
var detailBuyer_itemtitle = "팝니다"
var detailBuyer_itemcontent = ""
var detailBuyer_itemimage = "F50EC70B-14D5-47F1-87BB-ED66D3FA5B42.jpeg"
var detailBuyer_itemprice = 0
var detailBuyer_usernickname = "aaa" // ShareVar
var detailBuyer_address = "서울시 서대문구"
var detailBuyer_tag = ""
var detailBuyer_dealCompleteDate = ""
var detailBuyer_deleteDate = ""
var detailBuyer_user_email = "" // ShareVar

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
        print(detailBuyer_dealCompleteDate)
        
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
        
        //---------------------------------
        // Data 넣어주기
        //---------------------------------
        let url = URL(string: "http://localhost:8080/bebeProject/image/\(detailBuyer_itemimage)")
        let data = try? Data(contentsOf: url!)
        imgView.image = UIImage(data: data!)
        
        if detailBuyer_dealCompleteDate != nil{
            btnTradeStatus.setTitle("판매 중", for: .normal)
        }
        
        lblNickname.text = "\(detailBuyer_usernickname)\t\t"
        lblTitle.text = "  \(detailBuyer_itemtitle)"
        lblCategory.text = "  \(detailBuyer_category)"
        lblUseAge.text = "  \(detailBuyer_useage)"
        lblCategoryAgePrice.text = "\(detailBuyer_itemprice)원\t\t"
        lblLocation.text = "\(detailBuyer_address)"
        
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
