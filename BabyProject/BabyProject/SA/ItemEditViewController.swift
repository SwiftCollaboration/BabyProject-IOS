//
//  ItemEditViewController.swift
//  BabyProject
//
//  Created by TJ on 2021/08/03.
//

import UIKit
import STTextView // placeholder(textView) 기능

// DB Model
var itemEdit_itemCode = 0
var itemEdit_category = ""
var itemEdit_useage = 0
var itemEdit_itemTitle = ""
var itemEdit_itemContent = ""
var itemEdit_itemimage = ""
var itemEdit_itemprice = 0
var itemEdit_usernickname = "" // ShareVar
var itemEdit_address = ""
var itemEdit_tag = ""
var itemEdit_item_usercode = "" // ShareVar

// Pickerview Data
var itemEdit_selectedCategory = "" // 선택한 picker Data (selectedCategory)
var itemEdit_selectedAge = "" // 선택한 picker Data (selectedAge)
var itemEdit_selectedLocation = "" // 선택한 picker Data (selectedLocation)

var itemEdit_pickerList = [["의류/침구", "이유식", "목욕/위생", "스킨케어", "외출용품", "문구/잡화"],
                  ["생후 1년 미만", "생후 2년 미만", "만 3~5세"],
                  ["전체", "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]]

var itemEdit_itemImageArray: [UIImage] = []


var itemEdit_searchItem = "" // 검색어 입력

class ItemEditViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let picker = UIImagePickerController() // 갤러리용
    
    
    @IBOutlet weak var itemAddCollectionView: UICollectionView!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnAge: UIButton!
    @IBOutlet weak var btnSearchPrice: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    
    
    @IBOutlet weak var lblItemPrice: UILabel!
    @IBOutlet weak var tfItemTitle: UITextField!
    @IBOutlet weak var tfItemPrice: UITextField!
    @IBOutlet weak var tfTag: UITextField!
    @IBOutlet weak var tvItemContent: STTextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // extension으로 설정한 것을 실행
        picker.delegate = self
//        ItemEditViewController.delegate = self
//        ItemEditViewController.dataSource = self

        // 이미지추가 버튼
        btnAddImage.setTitle("\(itemImageArray.count)/10", for: .normal)
        btnAddImage.layer.cornerRadius = 10

        // 카테고리 버튼
        btnCategory.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        btnCategory.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)

        // 개월 수 버튼
        btnAge.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        btnAge.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)

        // 원가 찾기 버튼
        btnSearchPrice.layer.cornerRadius = 10
        
        // 제목 tf
        tfItemTitle.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        tfItemTitle.layer.addBorder([.bottom, .left, .right], color: UIColor.white, width: 1)
        tfItemTitle.addLeftPadding()
        
        // 원가입력 & 찾아보기 버튼 label
        lblItemPrice.layer.addBorder([.top, .bottom], color: UIColor(named: "SubColor")!, width: 1)
        
        // 원가 입력 tf
        tfItemPrice.layer.addBorder([.top, .bottom], color: UIColor(named: "SubColor")!, width: 1)
        tfItemPrice.layer.addBorder([.left, .right], color: UIColor.white, width: 1)
        tfItemPrice.addLeftPadding()
        
        // 태그 입력 tf
        tfTag.layer.addBorder([.top], color: UIColor(named: "SubColor")!, width: 1)
        tfTag.layer.addBorder([.left, .right, .bottom], color: UIColor.white, width: 1)
        tfTag.addLeftPadding()
        
        // 내용 입력 tv
        tvItemContent.layer.addBorder([.top, .bottom], color: UIColor(named: "SubColor")!, width: 1)
        tvItemContent.layer.addBorder([.left, .right], color: UIColor.white, width: 1)
        tvItemContent.textContainerInset = UIEdgeInsets(top: 15,left: 10,bottom: 0,right: 0)
        
        // Do any additional setup after loading the view.
    }// viewDidLoad
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // *** 위에 실행했던 View가 닫히고 다시 띄워질 때 ***
    override func viewWillAppear(_ animated: Bool) {
        itemAddCollectionView.reloadData()

        // 이미지추가 버튼 title tnwjd
        btnAddImage.setTitle("\(itemEdit_itemImageArray.count)/10", for: .normal)
    }
    
    // 이미지 추가 버튼 Action
    @IBAction func btnImageAddAction(_ sender: UIButton) {
        if itemImageArray.count == 10{
            let alert = UIAlertController(title: "알림", message: "더 이상 이미지를 추가할 수 없습니다!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }else{
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
    } // btnImageAddAction
    
    // 카테고리 선택 버튼
    @IBAction func btnCategoryAction(_ sender: UIButton) {
        let selectAlert = UIAlertController(title: "카테고리 선택", message: "상품에 맞는 카테고리를 선택하세요!\n\n\n\n\n\n", preferredStyle: .alert)
        // pickerView 추가
        let pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
        pickerView.tag = 0
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let leftAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        let rightAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            // 실행할 내용
            // 카테고리 선택 버튼 Text 변경
            self.btnCategory.setTitle("\(selectedCategory)", for: .normal)
            
            // DB Model용 변수
            category = selectedCategory
        })
        
        selectAlert.addAction(leftAction)
        selectAlert.addAction(rightAction)
        selectAlert.view.addSubview(pickerView)
        
        present(selectAlert, animated: true, completion: nil)
    } // btnCategoryAction
    
    // 개월 수 버튼 액션
    @IBAction func btnAgeAction(_ sender: UIButton) {
        let selectAlert = UIAlertController(title: "개월 수 선택", message: "개월 수를 선택하세요!\n\n\n\n\n\n", preferredStyle: .alert)
        // pickerView 추가
        let pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
        pickerView.tag = 1
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let leftAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        let rightAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            // 실행할 내용
            // 카테고리 선택 버튼 Text 변경
            self.btnAge.setTitle("\(itemEdit_selectedAge)", for: .normal)
            
            // DB Model용 변수
            switch itemEdit_selectedAge {
            case "12개월 미만":
                itemEdit_useage = 1
                break
            case "24개월 미만":
                itemEdit_useage = 2
                break
            case "만 3~5세":
                itemEdit_useage = 3
                break
            default:
                break
            }
        })
        
        selectAlert.addAction(leftAction)
        selectAlert.addAction(rightAction)
        selectAlert.view.addSubview(pickerView)
        
        present(selectAlert, animated: true, completion: nil)
    } //btnAgeAction
    
    // 거래 희망 지역 선택
    @IBAction func btnLocationAction(_ sender: UIButton) {
        let selectAlert = UIAlertController(title: "거래 희망 지역 선택", message: "거래 희망 지역을 선택하세요!\n\n\n\n\n\n", preferredStyle: .alert)
        // pickerView 추가
        let pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
        pickerView.tag = 2
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let leftAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        let rightAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            // 실행할 내용
            // 카테고리 선택 버튼 Text 변경
            self.btnLocation.setTitle("서울시 \(selectedLocation)", for: .normal)
        })
        
        selectAlert.addAction(leftAction)
        selectAlert.addAction(rightAction)
        selectAlert.view.addSubview(pickerView)
        
        present(selectAlert, animated: true, completion: nil)
    } // btnLocationAction
    
    
    
    // picekrView 관련 DataSource
    // picekrView의 컬럼 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // 출력할 데이터 갯수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var tagNum = 0
        switch pickerView.tag {
        case 0:
            tagNum = 0
            break
        case 1:
            tagNum = 1
        default:
            tagNum = 2
            break
        }
        return itemEdit_pickerList[tagNum].count
    }

    // picekrView 관련 Delegate
    // PickerView에 Title 입히기
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return itemEdit_pickerList[0][row]
            break
        case 1:
            return itemEdit_pickerList[1][row]
            break
        default:
            return itemEdit_pickerList[2][row]
            break
        }
        
    }

    // PickerView에 Data 선택
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            itemEdit_selectedCategory = "\(itemEdit_pickerList[0][row])"
            print("selectedCategory : \(itemEdit_selectedCategory)")
            break
        case 1:
            itemEdit_selectedAge = "\(itemEdit_pickerList[1][row])"
            print("selectedAge : \(itemEdit_selectedAge)")
            break
        default:
            itemEdit_selectedLocation = "\(itemEdit_pickerList[2][row])"
            print("selectedLocation : \(itemEdit_selectedLocation)")
            break
        }
        
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

////UICollectionView의 모양, 기능 설정
//extension ItemAddViewController: UICollectionViewDataSource, UICollectionViewDelegate{
//
//    // cell의 갯수 return
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return itemEdit_itemImageArray.count
//    }
//
//    // cell 구성(색깔 등)
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        // Identifier가 itemImageAddcell에 해당하는 cell에
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemImageAddCollectionViewCell", for: indexPath) as! ItemImageAddCollectionViewCell
//        // as! UICollectionViewCell는 Type 변환
//
//
//        cell.itemAddImageView.image = itemImageArray[indexPath.row]
//        cell.backgroundColor = .lightGray // UIColor 생략하여 씀
//
//
//        return cell
//
//    }
//}


// Cell Layout 정의
extension ItemEditViewController: UICollectionViewDelegateFlowLayout{
    
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
        // 3등분하여 배치(1행당), 옆 간격이 1이므로 1를 빼줌
//        let width = collectionView.frame.width / 3 - 1
//        let size = CGSize(width: width, height: width) // 정사각형
        let size = CGSize(width: 100, height: 100)

        
        return size
    }
    
}


// 갤러리 접근
extension ItemEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    func openLibrary(){
//        self.picker.sourceType = .photoLibrary
//        self.present(picker, animated: true, completion: nil)
//    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        var newImage: UIImage?
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            itemImageArray.append(image)
            print("itemImageArray is \(itemImageArray)")
            // 이미지추가 버튼
            btnAddImage.setTitle("\(itemImageArray.count)/10", for: .normal)
            
            self.itemAddCollectionView.reloadData()
//            itemImageArray += image as! UIImage
        }
        
        self.picker.dismiss(animated: true, completion: nil)
    }
}
