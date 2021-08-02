//
//  CategoryViewController.swift
//  BabyProject
//
//  Created by 이찬호 on 2021/07/30.
//

import UIKit

var CategoryList = ["전체선택","의류/침구","이유식","목욕/위생","스킨케어","외출용품","완구/잡화"]
var ImageFileName = ["clock.png","clock.png","clock.png","clock.png","clock.png","clock.png","clock.png"]
var CategoryImage: [UIImage] = [UIImage(named: ImageFileName[0])!,UIImage(named: ImageFileName[1])!,UIImage(named: ImageFileName[2])!,UIImage(named: ImageFileName[3])!,UIImage(named: ImageFileName[4])!,UIImage(named: ImageFileName[5])!,UIImage(named: ImageFileName[6])!]


class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
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

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryList.count
    }
    
    //return형식이 UICollectionViewCell 타입이다
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        cell.backgroundColor = .lightGray //셀 배경색
        cell.lblCategory.text = CategoryList[indexPath.row]
        cell.imgViewCategory.image = CategoryImage[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgSendCategory"{
            let cell = sender as! CategoryCollectionViewCell
            let indexPath = self.categoryCollectionView.indexPath(for: cell)
            let mainView = segue.destination as! MainHomeTableViewController
            mainView.recieveItem = String(CategoryList[(indexPath?.row)!])
            print("클릭 확인 : \(String(CategoryList[indexPath!.row]))")
            print("리시브아이템도 : \(mainView.recieveItem)")
            
        }
    }
    
} //CategoryViewController

//Cell Layout 정의
extension CategoryViewController: UICollectionViewDelegateFlowLayout{
    
    // 위 아래 간격 주기(minimumLineSpacing)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // 옆 간격 (minimumitemSpacing)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //cell 사이즈 (옆 라인을 고려하여 설정 sizeforIte)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 3등분하영 배치, 옆 간격이 1이므로 1을 빼줌
        let width = collectionView.frame.width / 3 - 1
        let size = CGSize(width: width, height: width)
        return size
    }
}







