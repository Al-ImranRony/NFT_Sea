//
//  AllNFTsViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/22/22.
//

import UIKit

struct tokenDetails {
    var contractAddress: String
    var tokenID: Int
    var walletAddress: String
}

class AllNFTsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var allNFTsCollectionView: UICollectionView!
    
    var myNFTsModel = [ImportedNFTModel]()
    var token = tokenDetails(contractAddress: "0x79abe43aE8c98eeFfb562875eFB72DDD7494a45d", tokenID: 20, walletAddress: "0x9ab5750dbBADb313BbB240a3a7E899488Feae73a")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        allNFTsCollectionView.register(AllNFTsCollectionViewCell.nib(), forCellWithReuseIdentifier: AllNFTsCollectionViewCell.identifier)
        allNFTsCollectionView.delegate = self
        allNFTsCollectionView.dataSource = self
        
        myNFTsModelInit()
        
        getTokenBalance(completion: token)
    }
    
    func myNFTsModelInit() {
        myNFTsModel.append(ImportedNFTModel(itemImageName: "asset1", itemName: "MyNFTs1"))
        myNFTsModel.append(ImportedNFTModel(itemImageName: "asset2", itemName: "MyNFTs2"))
        myNFTsModel.append(ImportedNFTModel(itemImageName: "asset3", itemName: "MyNFTs3"))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 150)
    }
    
    func getTokenBalance(completion: (tokenDetails)) -> Void {
        let apiUrl = "https://api-rinkeby.etherscan.io/api?module=account&action=tokennfttx&address=0x9ab5750dbBADb313BbB240a3a7E899488Feae73a&startblock=0&endblock=999999999&sort=asc&apikey=59E9ZTD951D66AIGIAR2B7DQ9NTXRJUAQ1"
        let url = URL(string: apiUrl)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error ! Status: \(response)")
                return
            }
            
            if let data = data {
                let tokenResponse: [String: AnyObject]
                do {
                    tokenResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                    
                    print("Responses: ", data.description, tokenResponse)
                } catch {
                    print("Error has occured in api calling.")
                }
            }
        })
        task.resume()
    }
}

extension AllNFTsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myNFTsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AllNFTsCollectionViewCell.identifier, for: indexPath) as! AllNFTsCollectionViewCell
        cell.configureMyNFTs(with: myNFTsModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }

}


