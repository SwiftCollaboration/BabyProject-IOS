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
    "닭고기"]

private var userSearchItems:[String] = [
    "당근",
    "우유"]



class SearchViewController: UIViewController {

    /// Outlet
    // CollectionView
    @IBOutlet weak var collectionTopView: UICollectionView!
    @IBOutlet weak var collectionBottomView: UICollectionView!
    @IBOutlet weak var userSearchTableView: UITableView!
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupNavigationbarView()               // Navigationbar Setting
        setupCollectionTopView()               // CollectionView (Top)
        setupCollectionBottomView()            // CollectionView (Bottom)
        userSearchTableView.dataSource = self  // TableView
        userSearchTableView.delegate = self    // TableView
    } // viewDidLoad
    
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
    
    
    
    
    
    
    
} // SearchViewController


/// Extension : UICollection  * * * * * * * * * * * *

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    /// Cell 출력 갯수  * * * * * *
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.collectionTopView:
            return topItems.count
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
            topCell.configure(name: topItems[indexPath.row])
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
            return CollectionTopViewCell.fittingSize(availableHeight: 45, name: topItems[indexPath.item])
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
        return userSearchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userSearchCell", for: indexPath)
        
        cell.textLabel?.text = userSearchItems[indexPath.row]
        cell.imageView?.image = UIImage(named: "searchClock.png")
        
        
        
        return cell
    }
    
    
}
