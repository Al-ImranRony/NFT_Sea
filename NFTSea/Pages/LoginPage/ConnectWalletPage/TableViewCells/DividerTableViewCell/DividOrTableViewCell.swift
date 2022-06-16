//
//  DividOrTableViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/16/22.
//

import UIKit

class DividOrTableViewCell: UITableViewCell {
    
    static let identifier = "DividOrTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DividOrTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
