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
var detailBuyer_itemimage = "EAE4EF91-BA89-441E-9236-F7AA5E49FC86.jpeg"
var detailBuyer_itemprice = 0
var detailBuyer_usernickname = "aaa" // ShareVar
var detailBuyer_address = "서울시 서대문구"
var detailBuyer_tag = "1,2,3,4"
var detailBuyer_dealCompleteDate = ""
var detailBuyer_deleteDate = ""
var detailBuyer_user_email = "" // ShareVar

var detailBuyer_tagArray: [String] = detailBuyer_tag.components(separatedBy: ",")

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
    
    var feedItem: NSMutableArray = NSMutableArray() // 배열 생성, NSArray는 한번 생성되면 값을 바꿀 수 없음
    var itemCode = 1 // receiveItem으로 받아올 것
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queryModel = ItemDetailQueryModel() // 생성자 생성

        // extension으로 정의한 것을 실행
        queryModel.delegate = self
        queryModel.downloadItems(itemCode: itemCode)
        itemsToVariable() // 전역변수 DBModel 값 넣기
        
        self.tagCollectionView.dataSource = self
        self.tagCollectionView.delegate = self
        
        
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
        tvContent.textAlignment = NSTextAlignment.left
        
        // 거래 상태 버튼
        btnTradeStatus.layer.cornerRadius = 10
        
        // 채팅하기 버튼
        btnChat.layer.cornerRadius = 10
        
        //---------------------------------
        // Data 넣어주기
        //---------------------------------
        let url = URL(string: "http://localhost:8080/bebeProject/image/\(detailBuyer_itemimage)")
        let data = try? Data(contentsOf: url!)
        print("data is \(data)")
        imgView.image = UIImage(data: data!)
        
        if detailBuyer_dealCompleteDate != nil{
            btnTradeStatus.setTitle("판매 중", for: .normal)
        }
        
        lblNickname.text = "\(detailBuyer_usernickname)\t\t"
        lblTitle.text = "  \(detailBuyer_itemtitle)"
        lblCategory.text = "  \(detailBuyer_category)"
        lblUseAge.text = "  \(detailBuyer_useage)"
        lblCategoryAgePrice.text = "\(numberFormatter(number: detailBuyer_itemprice))원\t\t"
        lblLocation.text = "\(detailBuyer_address)"
        
        // Do any additional setup after loading the view.
    } // viewDidLoad
    
    // 화면이 내려가있다가 다시 팝업될 때 실행
    override func viewWillAppear(_ animated: Bool) {
        let queryModel = ItemDetailQueryModel() // 생성자 생성
        
        // extension으로 정의한 것을 실행
        queryModel.delegate = self
        queryModel.downloadItems(itemCode: itemCode)
        itemsToVariable() // 전역변수에 DBModel 값 넣기
    }
    
    // QueryModel로 불러온 데이터를 전역변수에 넣기
    func itemsToVariable(){
        print("feedItem is \(print(feedItem))")
        let item: ItemDBModel = feedItem as! ItemDBModel
        
        
        detailBuyer_category = item.category!
        detailBuyer_useage = item.useAge!
        detailBuyer_itemtitle = item.itemTitle!
        detailBuyer_itemcontent = item.itemContent!
        detailBuyer_itemimage = item.itemImage!
        detailBuyer_itemprice = item.itemPrice!
        detailBuyer_usernickname = item.userNickname!
        detailBuyer_address = item.address!
        detailBuyer_tag = item.tag!
        detailBuyer_dealCompleteDate = item.dealCompleteDate!
        detailBuyer_deleteDate = item.deleteDate!
        detailBuyer_user_email = item.user_email!
    }
    
    // 천단위 숫자 콤마 찍기
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    
    
    // 채팅하기 버튼
    @IBAction func btnChatAction(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // ItemDetailBuyerViewController


//UICollectionView의 모양, 기능 설정
extension ItemDetailBuyerViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    // cell의 갯수 return
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailBuyer_tagArray.count
    }
    
    // cell 구성(색깔 등)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Identifier가 myCell에 해당하는 cell에
        let cell = self.tagCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailBuyerCollectionViewCell", for: indexPath) as! ItemDetailBuyerCollectionViewCell
        // as! UICollectionViewCell는 Type 변환
        print(detailBuyer_tagArray)
        
        cell.lblTag.text = detailBuyer_tagArray[indexPath.row] // lblTag Data를 입력
        cell.lblTag.layer.cornerRadius = 5
        cell.lblTag.backgroundColor = UIColor(named: "SubColor")
        return cell
        
    }
}


// Cell Layout 정의
extension ItemDetailBuyerViewController: UICollectionViewDelegateFlowLayout{
    
    // 위 아래 간격 minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 옆 간격 minimumInteritemSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // cell 사이즈 (옆 라인을 고려하여 설정) sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = tagCollectionView.frame.width / 4 - 1
        let size = CGSize(width: width, height: tagCollectionView.frame.height)
        
        return size
    }
    
}


// ItemDBModel에 설정한 Protocol 사용
extension ItemDetailBuyerViewController: ItemDetailQueryModelProtocol{
    func itemDownloaded(items: NSMutableArray) {
        feedItem = items
        //print("feedItem is \(feedItem)")
    }
}
