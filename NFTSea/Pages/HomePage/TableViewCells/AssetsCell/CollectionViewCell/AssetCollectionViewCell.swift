//
//  AssetCollectionViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/6/22.
//

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var assetLabel: UILabel!
    @IBOutlet var assetImageView: UIImageView!
    
    static let identifier = "AssetCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AssetCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Model) {
        self.assetLabel.text = model.itemName
        self.assetImageView.image = UIImage(named: model.itemImageName)
    }

}
