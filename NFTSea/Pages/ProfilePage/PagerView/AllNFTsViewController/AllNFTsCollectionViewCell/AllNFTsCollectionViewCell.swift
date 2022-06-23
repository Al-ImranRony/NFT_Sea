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
    
    func configureMyNFTs(with model: ImportedNFTModel) {
        let image = UIImage(named: model.itemImageName)
        nftImageView.image = image
        nftImageView.layer.cornerRadius = 10
        nftNameLabel.text = model.itemName
        nftNameLabel.textColor = .white
    }

}
