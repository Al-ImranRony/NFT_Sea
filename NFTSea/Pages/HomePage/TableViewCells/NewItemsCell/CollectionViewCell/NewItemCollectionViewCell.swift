//
//  NewItemCollectionViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/7/22.
//

import UIKit

class NewItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceTagLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    static let identifier = "NewItemCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewItemCollectionViewCell", bundle: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with model: Model) {
        self.itemImageView.image = UIImage(named: model.itemImageName)
        self.itemNameLabel.text = model.itemName
        self.priceTagLabel.text = "0.002ETH"
//        self.ownerNameLabel.text = model.categoryName
    }

}
