//
//  AllNFTsCollectionViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/22/22.
//

import UIKit

class AllNFTsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nftImageView: UIImageView!
    @IBOutlet weak var nftNameLabel: UILabel!
    
    var myNFTsModel = [ImportedNFTModel]()
    
    static let identifier = "AllNFTsCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AllNFTsCollectionViewCell", bundle: nil)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureMyNFTs(with model: tokenDetails) {
        let imageUrl = URL(string: model.tokenImageURL)
        if (imageUrl != nil) {
            let imageData = try? Data(contentsOf: imageUrl!)
            DispatchQueue.main.async { [self] in
                nftImageView.image = UIImage(data: imageData!)
            }
        } else {
            print("Error loading image")
        }
        nftImageView.layer.cornerRadius = 10
        nftNameLabel.text = "\(model.tokenContractName) #\(model.tokenID)"
        nftNameLabel.textColor = .white
    }

}
