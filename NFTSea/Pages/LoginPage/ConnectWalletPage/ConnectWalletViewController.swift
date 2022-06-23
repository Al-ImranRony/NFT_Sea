//
//  ConnectWalletViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/15/22.
//

import Foundation
import UIKit


class ConnectWalletViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var cwTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = "Choose one of the available wallet providers to connect wallet."
        topLabel.textColor = .white
        topLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 16)
        topLabel.numberOfLines = 2
        
        cwTableView.register(WalletConnectTableViewCell.nib(), forCellReuseIdentifier: WalletConnectTableViewCell.identifier)
        cwTableView.register(DividOrTableViewCell.nib(), forCellReuseIdentifier: DividOrTableViewCell.identifier)
        cwTableView.delegate = self
        cwTableView.dataSource = self
        self.cwTableView.separatorStyle = .none
    }
    
    //TableView DDF functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let wcTableCell = cwTableView.dequeueReusableCell(withIdentifier: WalletConnectTableViewCell.identifier, for: indexPath) as! WalletConnectTableViewCell
            wcTableCell.wcButtonImageView.image = UIImage(named: "metamaskLogo")
            wcTableCell.wcButtonLabel.text = "MetaMask"
            
            wcTableCell.inputModalDelegate = self
            return wcTableCell
            
        } else if (indexPath.row == 1) {
            let wcTableCell = cwTableView.dequeueReusableCell(withIdentifier: WalletConnectTableViewCell.identifier, for: indexPath) as! WalletConnectTableViewCell
            wcTableCell.wcButtonImageView.image = UIImage(named: "coinbaseLogo")
            wcTableCell.wcButtonLabel.text = "Coinbase"
            
            wcTableCell.inputModalDelegate = self
            return wcTableCell

        } else if (indexPath.row == 2) {
            let wcTableCell = cwTableView.dequeueReusableCell(withIdentifier: WalletConnectTableViewCell.identifier, for: indexPath) as! WalletConnectTableViewCell
            wcTableCell.wcButtonImageView.image = UIImage(named: "trustLogo")
            wcTableCell.wcButtonLabel.text = "TrustWallet"
            
            wcTableCell.inputModalDelegate = self
            return wcTableCell

        } else if (indexPath.row == 3) {
            let wcTableCell = cwTableView.dequeueReusableCell(withIdentifier: WalletConnectTableViewCell.identifier, for: indexPath) as! WalletConnectTableViewCell
            wcTableCell.wcButtonImageView.image = UIImage(named: "formeticLogo")
            wcTableCell.wcButtonLabel.text = "Formetic"
            
            wcTableCell.inputModalDelegate = self
            return wcTableCell

        } else if (indexPath.row == 4) {
            let wcTableCell = cwTableView.dequeueReusableCell(withIdentifier: DividOrTableViewCell.identifier, for: indexPath) as! DividOrTableViewCell

            wcTableCell.selectionStyle = .none
            return wcTableCell

        } else {
            let wcTableCell = cwTableView.dequeueReusableCell(withIdentifier: WalletConnectTableViewCell.identifier, for: indexPath) as! WalletConnectTableViewCell
            wcTableCell.wcButtonLabel.text = "Other Wallet"
            
            wcTableCell.inputModalDelegate = self
            return wcTableCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

extension ConnectWalletViewController: InputModalDelegate {
    func showInputViewOnPress() {
        print("Button pressed...")

        let inputModalVC = storyBoard.instantiateViewController(withIdentifier: "InputModalViewController") as! InputModalViewController
        navigationController?.isNavigationBarHidden = true
        inputModalVC.modalPresentationStyle = .overCurrentContext
        navigationController?.present(inputModalVC, animated: true, completion: nil)
    }
    
    
}
