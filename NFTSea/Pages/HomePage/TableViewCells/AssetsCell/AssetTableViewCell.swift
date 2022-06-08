//
//  AssetTableViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/6/22.
//

import UIKit

class AssetTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var tableModel = [Model]()
    
    static let identifier = "AssetTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AssetTableViewCell", bundle: nil)
    }
    
    func configure(with model: [Model]) {
        self.tableModel = model
        collectionView.reloadData()
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(AssetCollectionViewCell.nib(), forCellWithReuseIdentifier: AssetCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          let bottomSpace: CGFloat = 10.0 // Let's assume the space you want is 10
          self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom:bottomSpace, right: 0))
     }
    
    
    // Collection view functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: AssetCollectionViewCell.identifier, for: indexPath) as! AssetCollectionViewCell
        collectionCell.configure(with: tableModel[indexPath.row])
        collectionCell.layer.cornerRadius = 6
        return collectionCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 122)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10.0
    }
    
}
