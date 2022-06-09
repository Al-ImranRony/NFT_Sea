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

    override func awakeFromNib() {
        super.awakeFromNib()
        
       setupFloatingDP()
    }
    
    public func configure(with model: Model) {
        self.collectionCoverImageView.image = UIImage(named: "Rectangle 9.png")
        self.collectionDPImageView.image = UIImage(named: model.itemImageName)
        self.collectionNameLabel.text = model.itemName
        self.priceTagLabel.text = model.priceTag
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setFloatingDPFrame()
    }
    
    func handleConstraints() {
        
    }
    
    private func setFloatingDPFrame() {
        var createButtonFrame = collectionDPImageView.frame
        createButtonFrame.origin.y = 0 - getFlotedPartHeight()
        createButtonFrame.origin.x = (self.bounds.width / 2) - (collectionDPImageView.frame.width / 2)
        collectionDPImageView.frame = createButtonFrame
        
        collectionDPImageView.layer.cornerRadius = collectionDPImageView.frame.size.width / 2;
        let borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        collectionDPImageView.layer.borderWidth = 3;
        collectionDPImageView.layer.borderColor = borderColor.cgColor
    }
    
    private func getFlotedPartHeight() ->  CGFloat {
        return -14
    }
    
    private func setupFloatingDP() {
        let dpSize = getfloatingDPSize()
        let dpSizeWidth = dpSize.width
        let dpSizeHeight = dpSize.height
        collectionDPImageView.frame = CGRect(x: 0, y: 0, width: dpSizeWidth, height: dpSizeHeight)
        setFloatingDPFrame()
        addSubview(collectionDPImageView)
//        collectionDPImageView.image =
        layoutIfNeeded()
    }
    
    private func getfloatingDPSize() -> CGSize {
        return CGSize(width: 52, height: 52)
    }

}
