//
//  CreateNFTViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/8/22.
//

import UIKit

class  CreateNFTViewController: UIViewController{
    
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .black
        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "Will create NFTs here !"
        myLabel.textColor = .white
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .lightGray
        
        view.addSubview(myLabel)
        
        let backButton  = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Go to Home", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .lightGray
        backButton.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        view.addSubview(backButton)
        
        let margineGuide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 200),
            myLabel.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
            myLabel.heightAnchor.constraint(equalToConstant: 200),
            myLabel.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
            ])
        
        
        self.view = view
    }
    
    @objc func backButtonPressed() {
        var alertView = UIAlertController(title: "Sure ?", message: "Arekbar vebe dekho BASHAY jaba kina !", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Jabo", style: .default, handler: { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertView, animated: true, completion: nil)
    }
}
