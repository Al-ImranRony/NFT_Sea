//
//  WalletConnectTableViewCell.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/16/22.
//

import UIKit

protocol InputModalDelegate {
    func showInputViewOnPress()
}

class WalletConnectTableViewCell: UITableViewCell {
    
    var inputModalDelegate: InputModalDelegate?
    
    @IBOutlet weak var wcButtonImageView: UIImageView!
    @IBOutlet weak var wcButtonLabel: UILabel!
    @IBOutlet weak var walletConnectButton: UIButton!
    
    static let identifier = "WalletConnectTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WalletConnectTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupButton () {
        walletConnectButton.layer.cornerRadius = 27
        walletConnectButton.setTitle("", for: .normal)
        walletConnectButton.layer.borderWidth = 0.5
        walletConnectButton.layer.borderColor = UIColor.white.cgColor
        walletConnectButton.layer.cornerRadius = 27
        self.selectionStyle = .none
    }
    
    @IBAction func didPressCWButton(_ sender: Any) {
        inputModalDelegate?.showInputViewOnPress()
    }
}

