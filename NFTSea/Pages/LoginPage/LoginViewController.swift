//
//  LoginViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/14/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var connectWalletButton: UIButton!
    
    override func viewDidLoad() {

        connectWalletButton.layer.cornerRadius = 24
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        connectWalletButton.titleLabel?.text = ""
    }
    
    @IBAction func didPressConnectButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let connectWalletVC = storyboard.instantiateViewController(withIdentifier: "connectWalletVC") as! ConnectWalletViewController
        navigationController?.present(connectWalletVC, animated: true, completion: nil)
    }
    
    
    
}
