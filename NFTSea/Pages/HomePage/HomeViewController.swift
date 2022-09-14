//
//  HomeViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/5/22.
//

import UIKit
import SwiftyJSON
import CoreMedia

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

class HomeViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var table: UITableView!
    var assetModel = [Model]()
//    var hotCollectionsAPI = APIHandler(apiURL: "")
    var hotCollections: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.titleLabel?.text = nil
        
        //UI - Search Bar portion
        searchBarSetup()
        
        //TableView
        table.register(AssetTableViewCell.nib(), forCellReuseIdentifier: AssetTableViewCell.identifier)
        table.register(TrendingTableViewCell.nib(), forCellReuseIdentifier: TrendingTableViewCell.identifier)
        table.register(NewItemTableViewCell.nib(), forCellReuseIdentifier: NewItemTableViewCell.identifier)
        table.dataSource = self
        table.delegate =  self
        
        table.separatorStyle = .none
        table.backgroundColor = UIColor(red: 31/255, green: 27/255, blue: 49/255, alpha: 1.0)
        
        modelInit()
        getRequestOnAPI()
        getHotCollectionsImageFromOpensea()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    func modelInit() {
        assetModel.append(Model(itemName: "asset1", itemImageName: "asset1", categoryName: "Collection1", priceTag: "0.8ETH"))
        assetModel.append(Model(itemName: "asset2", itemImageName: "asset2", categoryName: "Collection1", priceTag: "0.32987ETH"))
        assetModel.append(Model(itemName: "asset3", itemImageName: "asset3", categoryName: "Collection1", priceTag: "0.893276ETH"))
        assetModel.append(Model(itemName: "asset4", itemImageName: "asset4", categoryName: "Collection1", priceTag: "0.92374ETH"))
    }

    
    @IBAction func menuButtonPressed(_ sender: Any) {
        print("Menu dekhba ? Wait...")
    }

    public func searchBarSetup() {
        //TODO: font and weight for custom
        
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = "Collection, item or user"
        searchBar.setImage(UIImage(named: "search"), for: .search, state: .normal)
        searchBar.setPositionAdjustment(UIOffset(horizontal: 7, vertical: 0), for: .search)
        //SearchBar textField BG as a color image
        let searchTextFieldBGColor = UIColor(red: 31/255, green: 27/255, blue: 49/255, alpha: 1.0)
        let image = getImageWithColor(color: searchTextFieldBGColor, size: CGSize(width: searchBar.bounds.width, height: 44))
        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        let forTextField = searchBar.value(forKey: "searchField") as? UITextField
        forTextField?.borderStyle = .none
        var bounds: CGRect
        bounds = forTextField!.frame
        bounds.size.height = 44
        forTextField?.bounds = bounds
        forTextField?.textColor = UIColor(red: 178/255, green: 181/255, blue: 185/255, alpha: 1.0)
        forTextField?.font = UIFont(name: "SourceSansPro-Regular", size: 15)
        forTextField?.clipsToBounds = true
        forTextField?.layer.cornerRadius = 22
        forTextField?.layer.borderColor = CGColor(red: 135/255, green: 123/255, blue: 183/255, alpha: 1.0)
        forTextField?.layer.borderWidth = 0.5
    }
    
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func getRequestOnAPI() {
        let apiUrl = "https://top-nft-collections-and-sales.p.rapidapi.com/collections/30d?rapidapi-key=05fb8988e2msh67a2a9f248dfa1bp16e54bjsn316775b01d85"
        let url = URL(string: apiUrl)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { [self](data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error ! Status: \(response)")
                return
            }
            
            if let data = data {
                do {
                    let jsonData = try? JSON(data: data)
                    let jsonArray = jsonData?.arrayValue
                    
                    for index in (0...jsonArray!.count-1) {
                        hotCollections.append(jsonArray![index]["collection_name"].stringValue)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    func getHotCollectionsImageFromOpensea() {
        let collectionName = "okay-boys"
        let apiUrl = "https://testnets-api.opensea.io/api/v1/collection/\(collectionName)"
        let url = URL(string: apiUrl)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { [self](data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error ! Status: \(response)")
                return
            }
            
            if let data = data {
                do {
                    let tokenResponse = try? JSON(data: data)
                    let assetData = tokenResponse!["collection"]["image_url"]
                    print(assetData)
//                    if let assetsArray = assetData.array {
//                        tokens = assetsArray.map({Tokens(json: $0)})
//                        print("opensea: ", assetsArray.count)
//                        for index in (0...assetsArray.count-1) {
//                            print("array \(index):  \(assetsArray[index]["name"])")
//                            assets.append(tokenDetails(tokenName: assetsArray[index]["name"].stringValue, tokenContractName: "", tokenID: assetsArray[index]["token_id"].stringValue, tokenImageURL: assetsArray[index]["image_thumbnail_url"].stringValue))
//                        }
//                        DispatchQueue.main.async {
//                            allNFTsCollectionView.reloadData()
//                        }
//                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //TODO: accordance to row...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let tableCell = table.dequeueReusableCell(withIdentifier: AssetTableViewCell.identifier, for: indexPath) as! AssetTableViewCell
            tableCell.configure(with: assetModel)
            tableCell.selectionStyle = .none
            return tableCell
            
        } else if (indexPath.section == 1) {
            let tableCell = table.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as! TrendingTableViewCell
            tableCell.configure(with: assetModel)
            tableCell.selectionStyle = .none
            return tableCell
            
        } else {
            let tableCell = table.dequeueReusableCell(withIdentifier: NewItemTableViewCell.identifier, for: indexPath) as! NewItemTableViewCell
            tableCell.selectionStyle = .none
            tableCell.configure(with: assetModel)
            return tableCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 0) {
            return 180.0  //20(top)+ 110(img) + 8(padding) + 12(label) + 30(Bottom)
        } else if (indexPath.section == 1) {
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
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.section == 0) {
            return nil
        }
        return indexPath
    }
}
