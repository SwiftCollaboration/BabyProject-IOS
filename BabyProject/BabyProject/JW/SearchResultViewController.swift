//
//  SearchResultViewController.swift
//  BabyProject
//
//  Created by 박재원 on 2021/08/02.
//

import UIKit

class SearchResultViewController: UITableViewController {

    
    @IBOutlet var searchResultTableView: UITableView!
    var searchWord:String = ""
    
    /// Array
    var feedItem: NSArray = NSArray()
   
    /// Prepare
    func searchWord(searchWith: String) {
        searchWord = searchWith
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ResultView :\(searchWord)")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        let searchModel = SearchModel()
        searchModel.delegate = self
//        searchModel.getUrlPath(url: "http://192.168.35.46:8080/ios/searchresult_query.jsp?search=\(searchWord)")
        searchModel.downloadItems()
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        print("feed:\(feedItem)")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let height = CGFloat(150)
        
        return height
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return feedItem.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableCell", for: indexPath) as! SearchResultTableCell

        // Configure the cell...
        let item: SearchDBModel = feedItem[indexPath.row] as! SearchDBModel
        
        cell.cornerRadius = 15
        cell.searchImageView.image = UIImage(named: "\(item.itemimage ?? "basicImage.png")")
        cell.lblSearchTitle.text = item.itemtitle
        cell.lblSearchDate.text = item.uploaddate
        
        
        return cell
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

/// Protocol : DB * * * * * *
extension SearchResultViewController: SearchModelProtocol{
    func itemDownloaded(items: NSArray) {
        feedItem = items
        
        // * * * Data 받아온 시점 * * *
        self.searchResultTableView.reloadData()
    }
    
} // SearchViewController: KeywordModelProtocol
