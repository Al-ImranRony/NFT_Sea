//
//  AllNFTsViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/22/22.
//

import UIKit
import SwiftyJSON


struct arguments {
    var contractAddress: String
    var tokenID: String
    var walletAddress: String
}

struct tokenDetails {
    var tokenName: String
    var tokenContractName: String
    var tokenID: String
    var tokenImageURL: String
}

struct Tokens {
    var blockHash: String
    var blockNumber: String
    var confirmations: String
    var contractAddress: String
    var cumulativeGasUsed: String
    var from: String
    var gas: String
    var gasPrice: String
    var gasUsed: String
    var hash: String
    var input: String
    var nonce: String
    var timeStamp: String
    var to: String
    var tokenDecimal: String
    var tokenID: String
    var tokenName: String
    var tokenSymbol: String
    var transactionIndex: String
    
    init(json:JSON) {
        self.blockHash = json["blockHash"].stringValue
        self.blockNumber = json["blockNumber"].stringValue
        self.confirmations = json["confirmations"].stringValue
        self.contractAddress = json["contractAddress"].stringValue
        self.cumulativeGasUsed = json["cumulativeGasUsed"].stringValue
        self.from = json["from"].stringValue
        self.gas = json["gas"].stringValue
        self.gasPrice = json["gasPrice"].stringValue
        self.gasUsed = json["gasUsed"].stringValue
        self.hash = json["hash"].stringValue
        self.input = json["input"].stringValue
        self.nonce = json["nonce"].stringValue
        self.timeStamp = json["timeStamp"].stringValue
        self.to = json["to"].stringValue
        self.tokenDecimal = json["tokenDecimal"].stringValue
        self.tokenID = json["tokenID"].stringValue
        self.tokenName = json["tokenName"].stringValue
        self.tokenSymbol = json["tokenSymbol"].stringValue
        self.transactionIndex = json["transactionIndex"].stringValue
    }
}


class AllNFTsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var allNFTsCollectionView: UICollectionView!
    
    var myNFTsModel = [ImportedNFTModel]()
    var tokenParams = arguments(contractAddress: "0x79abe43aE8c98eeFfb562875eFB72DDD7494a45d", tokenID: "20", walletAddress: "0x9ab5750dbBADb313BbB240a3a7E899488Feae73a")
    let etherscanAPIKey = "59E9ZTD951D66AIGIAR2B7DQ9NTXRJUAQ1"
    
    var tokens: [Tokens] = []
    var assets: [tokenDetails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCurrentUserTokens(tokenParams: tokenParams)

        allNFTsCollectionView.register(AllNFTsCollectionViewCell.nib(), forCellWithReuseIdentifier: AllNFTsCollectionViewCell.identifier)
        allNFTsCollectionView.delegate = self
        allNFTsCollectionView.dataSource = self
    }
    
    func loadCurrentUserTokens(tokenParams: arguments) {
        getTokenMetaData(param: tokenParams)
        getTokenImageFromOpensea(param: tokenParams)
    }
    
    func getTokenMetaData(param: arguments) -> Void {
        let apiUrl = "https://api-rinkeby.etherscan.io/api?module=account&action=tokennfttx&address=\(param.walletAddress)&startblock=0&endblock=999999999&sort=asc&apikey=\(etherscanAPIKey)"
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
                    let tokenArray = tokenResponse!["result"]
                    if let jsonArray = tokenArray.array {
                        tokens = jsonArray.map({Tokens(json: $0)})
                    }
                    
                    
                    for index in (0...tokens.count-1) {
                        assets.append(tokenDetails(tokenName: "", tokenContractName: tokens[index].tokenName, tokenID: tokens[index].tokenID, tokenImageURL: ""))
//                        print(assets)
                    }
                    DispatchQueue.main.async {
                        allNFTsCollectionView.reloadData()
                    }
//                    print(tokens)
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    func getTokenImageFromOpensea(param: arguments) {
        let apiUrl = "https://testnets-api.opensea.io/api/v1/assets?asset_contract_address=\(param.contractAddress)&order_direction=asc&offset=0&limit=20"
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
                    let assetData = tokenResponse!["assets"]
                    if let assetsArray = assetData.array {
                        tokens = assetsArray.map({Tokens(json: $0)})
                        print("opensea: ", assetsArray.count)
                        for index in (0...assetsArray.count-1) {
//                            print("array \(index):  \(assetsArray[index]["name"])")
                            assets.append(tokenDetails(tokenName: assetsArray[index]["name"].stringValue, tokenContractName: "", tokenID: assetsArray[index]["token_id"].stringValue, tokenImageURL: assetsArray[index]["image_thumbnail_url"].stringValue))
                        }
                        DispatchQueue.main.async {
                            allNFTsCollectionView.reloadData()
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    }
}

extension AllNFTsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllNFTsCollectionViewCell.identifier, for: indexPath) as! AllNFTsCollectionViewCell
        cell.configureMyNFTs(with: assets[indexPath.item])
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }

}


