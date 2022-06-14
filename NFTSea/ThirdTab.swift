//
//  ThirdTab.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/8/22.
//

import UIKit

class ThirdTab: UIViewController {
    override func viewDidLoad() {
        let view = UIView()
        view.backgroundColor = .white
        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "Janina ki dekhbo ekhane !"
        myLabel.textAlignment = .center
        myLabel.backgroundColor = .lightGray
        view.addSubview(myLabel)
        
        let margineGuide = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: margineGuide.topAnchor, constant: 100),
            myLabel.leadingAnchor.constraint(equalTo: margineGuide.leadingAnchor),
            myLabel.heightAnchor.constraint(equalToConstant: 40),
            myLabel.trailingAnchor.constraint(equalTo: margineGuide.trailingAnchor)
            ])
        
        self.view = view
    }
    
}
