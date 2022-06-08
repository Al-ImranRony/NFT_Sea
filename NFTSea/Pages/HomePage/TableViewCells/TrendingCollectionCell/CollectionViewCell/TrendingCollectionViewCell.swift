//
//  TrendingCollectionViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/7/22.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionDPImageView: UIImageView!
    @IBOutlet weak var collectionCoverImageView: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var priceTagLabel: UILabel!
    
    static let identifier = "TrendingCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TrendingCollectionViewCell", bundle: nil)
    }
    
//    let profileImageView: UIImageView = {
//        let imgView = UIImageView()
//        imgView.backgroundColor = .red
//        imgView.layer.cornerRadius = imgView.layer.frame.width / 2
//        imgView.clipsToBounds = true
//        return imgView
//    }()

    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionDPImageView.layer.cornerRadius = collectionDPImageView.frame.size.width / 2;
//        collectionDPImageView.clipsToBounds = true
//        collectionDPImageView.layer.borderWidth = 3;
//        collectionDPImageView.layer.borderColor = [UIColor .white] as! CGColor
//        collectionDPImageView.frame.size.width = 52
//        collectionDPImageView.frame.size.height = 52
        
        
//        collectionDPImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configure(with model: Model) {
        self.collectionCoverImageView.image = UIImage(named: "Rectangle 9.png")
        self.collectionDPImageView.image = UIImage(named: model.itemImageName)
        self.collectionNameLabel.text = model.itemName
        self.priceTagLabel.text = model.priceTag
    }
    
    
    func handleConstraints() {
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
