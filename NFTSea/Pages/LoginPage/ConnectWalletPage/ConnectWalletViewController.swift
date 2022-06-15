//
//  ConnectWalletViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/15/22.
//

import Foundation
import UIKit


class ConnectWalletViewController: UIViewController {
    
    @IBOutlet weak var metamaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        metamaskButton.layer.cornerRadius = 27
        
    }
    
    
    @IBAction func didPressMetamask(_ sender: Any) {
        print("Send sign message...")
        
        
        
    }
    
}
