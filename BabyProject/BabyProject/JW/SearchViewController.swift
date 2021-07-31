//
//  SearchViewController.swift
//  BabyProject
//
//  Created by 박재원 on 2021/07/30.
//

import UIKit
import SnapKit

/// CollectionView temp Data
private let topItems:[String] = [
    "브로콜리",
    "양파",
    "햇감자",
    "카레",
    "당근",
    "돼지고기"]

private let bottomItems:[String] = [
    "김치",
    "다진마늘",
    "모짜렐라치즈",
    "참기름",
    "소고기",
    "닭고기"]

class SearchViewController: UIViewController {

    /// Outlet
    // CollectionView
    @IBOutlet weak var collectionTopView: UICollectionView!
    @IBOutlet weak var collectionBottomView: UICollectionView!
    @IBOutlet weak var userSearchTableView: UITableView!
    @IBOutlet weak var backButtonItem: UIBarButtonItem!

    /// NSArray
    var feedItem: NSArray = NSArray()
    var tagArray:[(Int,String)] = []
    
    /// viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationbarView()               // Navigationbar Setting
        setupCollectionTopView()               // CollectionView (Top)
        setupCollectionBottomView()            // CollectionView (Bottom)
        collectionTopView.dataSource = self
        userSearchTableView.dataSource = self  // TableView : Extension
        userSearchTableView.delegate = self    // TableView : Extension
        
        
    } // viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        // Get Items from DB
        let keywordModel = KeywordModel()
        keywordModel.delegate = self
        keywordModel.downloadItems()
        
        
    } // viewWillAppear
    
    /// 화면구성 * * * * * * * * * * * * * * * * * * * * *
    
    /// Navigationbar Setting
    func setupNavigationbarView(){
        
        // 가운데 검색창
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 0))
        searchBar.placeholder = "검색어를 입력해주세요"
        
        
        self.navigationItem.titleView = searchBar
        
        // 우측 검색
        let searchOK = UIBarButtonItem(systemItem: .search, primaryAction: UIAction{ _ in
            // 검색화면으로 이동!
        })

        
        self.navigationItem.rightBarButtonItem = searchOK
        
        
        
    } // setupNavigationbarView
    
    /// TopCollectionView ( 상단 Collection View )
    // CollectionView 모양 구성 : flowLayout
    func setupCollectionTopView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 5, left: 16, bottom: 5, right: 16)
        
        collectionTopView.setCollectionViewLayout(flowLayout, animated: true)
        collectionTopView.delegate = self
        collectionTopView.dataSource = self
        collectionTopView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionBottomView.decelerationRate = .normal
        collectionTopView.register(CollectionTopViewCell.self, forCellWithReuseIdentifier: "topItemCell")
        
    } // setupCollectionTopView
    
    /// BottomCollectionView ( 하단 Collection View )
    // CollectionView 모양 구성 : flowLayout
    func setupCollectionBottomView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = 15
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = .init(top: 5, left: 16, bottom: 5, right: 16)
        
        collectionBottomView.setCollectionViewLayout(flowLayout, animated: true)
        collectionBottomView.delegate = self
        collectionBottomView.dataSource = self
        collectionBottomView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        collectionBottomView.decelerationRate = .normal
        collectionBottomView.register(CollectionBottomViewCell.self, forCellWithReuseIdentifier: "bottomItemCell")
    
    } // setupCollectionTopView
    /// * * * * * * * * * * * * * * * * * * *
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    /// TableView Setting
    
    
    func readtags() -> Array<(Int,String)> {
        print("Start func : readtags")
            var arr:[(Int,String)] = []
            var arraySorted:[(Int,String)] = []
            
            for i in 0..<feedItem.count{
                let item: KeywordDBModel = feedItem[i] as! KeywordDBModel
                let getSplits = item.tag?.split(separator: ",")
                
                for i in 0..<getSplits!.count{
                    let value = getSplits![i]
                    var count = 0
                    
                    for i in 0..<arr.count{
                        if value == arr[i].1{
                            count += 1
                            arr[i].0 += 1
                        }
                    }
                    switch count {
                    case 0:
                        arr.append((1,String(value)))
                    default:
                        break
                    }
                }
                arraySorted = arr.sorted(by: {$0.0 > $1.0})
                print(arraySorted)
            }
            return arraySorted
        }
    
    
    
    
    
    
    
} // SearchViewController


/// Extension : UICollection  * * * * * * * * * * * *

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    /// Cell 출력 갯수  * * * * * *
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionTopView:
            return readtags().count
        default:
            return bottomItems.count
            // 상단 Cell
        }
    } // collectionView

    
    /// Cell 내용 붙이기  * * * * * *
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case self.collectionTopView:
            // 상단 Cell
            let topCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topItemCell", for: indexPath) as! CollectionTopViewCell
            
            topCell.configure(name: self.tagArray[indexPath.row].1)
            return topCell
        default:
            // 하단 Cell
            let BottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bottomItemCell", for: indexPath) as! CollectionBottomViewCell
            BottomCell.configure(name: bottomItems[indexPath.row])
            return BottomCell
        } // switch
        
    } // collectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        
        case self.collectionTopView:
            // 상단 Cell
            return CollectionTopViewCell.fittingSize(availableHeight: 45, name: self.tagArray[indexPath.item].1)
        default:
            // 하단 Cell
            return CollectionBottomViewCell.fittingSize(availableHeight: 45, name: bottomItems[indexPath.item])
        }
    } // collectionView
    
    

    
    
    
    
    
    
} // SearchViewController


///  상단 Cell 구성  * * * * * * * * * * * *
///   - cell identifire : topItemCell
final class CollectionTopViewCell: UICollectionViewCell {
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = CollectionTopViewCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.3888371885, green: 0.63126719, blue: 0.8909832835, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
} //  CollectionTopViewCell


///  하단 Cell 구성 * * * * * * * * * * * *
///   - cell identifire : bottomItemCell
final class CollectionBottomViewCell: UICollectionViewCell {
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = CollectionBottomViewCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 18)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
} // CollectionBottomViewCell

extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userSearchCell", for: indexPath)
        
        let item: KeywordDBModel = feedItem[indexPath.row] as! KeywordDBModel
        
        cell.textLabel?.text = "\(item.tag!)"
        cell.imageView?.image = UIImage(named: "searchClock.png")
        
        return cell
    }
    
} // SearchViewController


/// Protocol : DB
extension SearchViewController: KeywordModelProtocol{
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.tagArray = readtags()
        print("Extension : feedItem : \(feedItem)")
        
        // * * * Data 받아온 시점 * * *
        self.userSearchTableView.reloadData()
        self.collectionTopView.reloadData()
    }
    
} // SearchViewController

