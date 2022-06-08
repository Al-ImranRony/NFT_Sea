//
//  TrendingTableViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/7/22.
//

import UIKit

class TrendingTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    var trendingCollectionModel = [Model]()
    
    static let identifier = "TrendingTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TrendingTableViewCell", bundle: nil)
    }
    
    func configure(with model: [Model]) {
        self.trendingCollectionModel = model
        trendingCollectionView.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trendingCollectionView.register(TrendingCollectionViewCell.nib(), forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingCollectionModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
        collectionCell.configure(with: trendingCollectionModel[indexPath.row])
        collectionCell.layer.cornerRadius = 6
        return collectionCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
//        return CGSize(width: 160, height: 130)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
}
