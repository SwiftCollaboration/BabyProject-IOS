//
//  ItemDetailSellerViewController.swift
//  BabyProject
//
//  Created by TJ on 2021/08/03.
//

import UIKit

// DB Model
var detailSeller_itemCode = 1 // 삭제시 필요
var detailSeller_category = ""
var detailSeller_useage = ""
var detailSeller_itemtitle = ""
var detailSeller_itemcontent = ""
var detailSeller_itemimage = ""
var detailSeller_itemprice = 0
var detailSeller_usernickname = "" // ShareVar
var detailSeller_address = ""
var detailSeller_tag = ""
var detailSeller_dealCompleteDate: Date = Date()
var detailSeller_deleteDate: Date = Date()
var detailSeller_item_usercode = "" // ShareVar

class ItemDetailSellerViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategoryAgePrice: UILabel! // 통합 라벨
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblUseAge: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var btnTradeStatus: UIButton! // 거래중, 거래완료
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var btnItemEditDelete: UIButton!
    

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
        
        // 수정/삭제 버튼
        btnItemEditDelete.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    } // viewDidLoad
    
    
    // 수정/삭제 버튼 액션
    @IBAction func btnItemEditDeleteAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "수정 / 삭제", message: nil, preferredStyle: .actionSheet)
        let actionDefault = UIAlertAction(title: "수정", style: .default, handler: {ACTION in
            // 실행할 내용
            self.performSegue(withIdentifier: "sgItemEdit", sender: self)
        })
        let actionDestructive = UIAlertAction(title: "삭제", style: .destructive, handler: {ACTION in
            // 실행할 내용
            print("상품 삭제 실행")
            let deleteModel = ItemDeleteModel()
            let result = deleteModel.deleteItems(itemCode: detailSeller_itemCode)
            
            // 삭제(deleteDate)가 잘되었는 지 안되었는 지 확인
            if result{
                let resultAlert = UIAlertController(title: "완료", message: "삭제가 완료 되었습니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                    self.navigationController?.popViewController(animated: true)
                })
                resultAlert.addAction(onAction) // 실행할 액션을 추가
                // Alert 띄우기
                self.present(resultAlert, animated: true, completion: nil)
            }else{
                let resultAlert = UIAlertController(title: "실패", message: "에러가 발생 되었습니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                    self.navigationController?.popViewController(animated: true)
                })
                resultAlert.addAction(onAction) // 실행할 액션을 추가
                // Alert 띄우기
                self.present(resultAlert, animated: true, completion: nil)
            }
        })
        let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: {ACTION in
            // 실행할 내용
        })
                
        // Controller와 Action결합
        alert.addAction(actionDefault) //
        alert.addAction(actionDestructive) // 실행할 내용
        alert.addAction(actionCancel) //
                
        // 화면 띄우기
        present(alert, animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // ItemDetailSellerViewController
