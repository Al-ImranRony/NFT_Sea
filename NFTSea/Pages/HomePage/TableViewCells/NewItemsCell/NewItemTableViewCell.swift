//
//  NewItemTableViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/7/22.
//

import UIKit

class NewItemTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var seeAllButton: UIButton!
    @IBOutlet weak var newItemCollectionView: UICollectionView!
    
    var newItemModel = [Model]()
    
    static let identifier = "NewItemTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewItemTableViewCell", bundle: nil)
    }
    
    func configure(with model: [Model]) {
        self.newItemModel = model
        newItemCollectionView.reloadData()
    }

    @IBAction func didPressRightIndicator(_ sender: Any) {
        print("Recent Items will be shown...")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        newItemCollectionView.register(NewItemCollectionViewCell.nib(), forCellWithReuseIdentifier: NewItemCollectionViewCell.identifier)
        newItemCollectionView.delegate = self
        newItemCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newItemModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewItemCollectionViewCell.identifier, for: indexPath) as! NewItemCollectionViewCell
        collectionCell.configure(with: newItemModel[indexPath.row])
        collectionCell.layer.cornerRadius = 6
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Name :", newItemModel[indexPath.row].itemName)
        print("Price :", newItemModel[indexPath.row].priceTag)
        print("Owner :", newItemModel[indexPath.row].categoryName)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexpath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

}
