//
//  HomeViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/5/22.
//

import UIKit


struct Model  {
    let itemName: String
    let itemImageName: String
    let categoryName: String
    let priceTag: String
    
    init(itemName: String, itemImageName: String, categoryName: String, priceTag: String) {
        self.itemName = itemName
        self.itemImageName = itemImageName
        self.categoryName = categoryName
        self.priceTag = priceTag
    }
}

class HomeViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var table: UITableView!
    var assetModel = [Model]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UI - Search Bar portion
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.init(rawValue: 700.0))
        
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = " Collection, item or user"
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)

        let forTextField = searchBar.value(forKey: "searchField") as? UITextField
        forTextField?.borderStyle = .none
        forTextField?.backgroundColor = UIColor(red: 31/255, green: 27/255, blue: 49/255, alpha: 1.0)
        forTextField?.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        forTextField?.clipsToBounds = true
        forTextField?.layer.cornerRadius = 18
        forTextField?.layer.borderColor = CGColor(red: 135/255, green: 123/255, blue: 183/255, alpha: 1.0)
        forTextField?.layer.borderWidth = 0.5
        
        //TableView
        table.register(AssetTableViewCell.nib(), forCellReuseIdentifier: AssetTableViewCell.identifier)
        table.register(TrendingTableViewCell.nib(), forCellReuseIdentifier: TrendingTableViewCell.identifier)
        table.register(NewItemTableViewCell.nib(), forCellReuseIdentifier: NewItemTableViewCell.identifier)
        table.dataSource = self
        table.delegate =  self
        
        table.backgroundColor = UIColor(red: 31/255, green: 27/255, blue: 49/255, alpha: 1.0)
        
        assetModel.append(Model(itemName: "Flash", itemImageName: "flash 2", categoryName: "", priceTag: ""))
        assetModel.append(Model(itemName: "Menu", itemImageName: "menuIcon", categoryName: "", priceTag: ""))
        assetModel.append(Model(itemName: "Search", itemImageName: "search", categoryName: "", priceTag: ""))
        assetModel.append(Model(itemName: "Menu", itemImageName: "menuIcon", categoryName: "", priceTag: ""))
    }
    
    //TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let tableCell = table.dequeueReusableCell(withIdentifier: AssetTableViewCell.identifier, for: indexPath) as! AssetTableViewCell
            tableCell.configure(with: assetModel)
            return tableCell
        } else if (indexPath.section == 1) {
            let tableCell = table.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as! TrendingTableViewCell
            tableCell.configure(with: assetModel)
            return tableCell
        } else {
            let tableCell = table.dequeueReusableCell(withIdentifier: NewItemTableViewCell.identifier, for: indexPath) as! NewItemTableViewCell
            tableCell.configure(with: assetModel)
            return tableCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 180.0  //20(top)+ 110(img) + 8(padding) + 12(label) + 30(Bottom)
        } else if (indexPath.row == 1) {
            return 200.0
        } else {
            return 272.0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return tableCellSpacingHeight
//    }
    
}
