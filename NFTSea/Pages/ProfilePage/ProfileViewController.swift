//
//  ProfileViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/19/22.
//

import UIKit
import Pageboy
import Tabman


class ProfileViewController: UIViewController {
    private var profileImageView = UIImageView()
    private var dpEditButton = UIButton()
    
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var publicAddressButton: UIButton!
    
    let pageVC = PagerViewController()
    @IBOutlet weak var pagerViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileImageView()
        setupDPEditButton()
        setupProfileNameLabel()
        setupPublicAddressButton()
        
        getPagerViewHeight()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        setProfileImageViewFrame()
//
//        self.view.layoutIfNeeded()
//    }
    
    private func setupProfileImageView() {
        let imageViewSize = getProfileImageViewSize()
        let imageViewWidth = imageViewSize.width
        let imageViewHeight = imageViewSize.height
        profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight))
        setProfileImageViewFrame()
        self.view.addSubview(profileImageView)
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.layer.borderColor = UIColor(red: 68/255, green: 75/255, blue: 229/255, alpha: 1.0).cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.image = getProfileImage()
    }
    
    private func getProfileImage() -> UIImage {
        let image = UIImage(named: "asset1")
//        image =
        return image!
    }
    
    private func getProfileImageViewSize() -> CGSize {
        return CGSize(width: 120, height: 120)
//        let deviceTypeTab = DeviceHandler.isIpad()
//        if (deviceTypeTab) {
//            return CGSize(width: 84, height: 84)
//        } else if (!DeviceHandler.isNotchedDevice()) {
//            return CGSize(width: 48, height: 48)
//        } else {
//            return CGSize(width: 44, height: 44)
//        }
    }
    
    private func setProfileImageViewFrame() {
        var viewFrame = profileImageView.frame
        viewFrame.origin.y = 0 + getProfileImageViewFlotedPartHeight()
        viewFrame.origin.x = (self.view.bounds.width / 2) - (profileImageView.frame.width / 2)
        profileImageView.frame = viewFrame
    }
    
    private func getProfileImageViewFlotedPartHeight() ->  CGFloat {
        return 110
//        if (DeviceHandler.isIpad()) {
//            return 38
//        } else if (!DeviceHandler.isNotchedDevice()) {
//            return 14
//        } else {
//            return 7
//        }
    }
    
    private func setupDPEditButton() {
        let editButtonSize = getEditButtonSize()
        dpEditButton = UIButton(frame: CGRect(x: 0, y: 0, width: editButtonSize.width, height: editButtonSize.height))
        setEditButtonFrame()
        self.view.addSubview(dpEditButton)
        dpEditButton.layer.masksToBounds = true
        dpEditButton.layer.cornerRadius = dpEditButton.frame.size.width / 2
        dpEditButton.setImage(UIImage(named: "dpEditIcon"), for: .normal)
        dpEditButton.addTarget(self, action: #selector(editButtonAction(sender:)), for: .touchUpInside)
    }
    
    @objc private func editButtonAction(sender: UIButton){
        print("Upload image...")
    }
    
    private func getEditButtonSize() -> CGSize {
        return CGSize(width: 24, height: 24)
    }
    
    private func setEditButtonFrame() {
        var editButtonFrame = dpEditButton.frame
        editButtonFrame.origin.y = profileImageView.frame.height + profileImageView.bounds.size.height - getEditButtonFlotedPartHeight()
        editButtonFrame.origin.x = profileImageView.frame.width + profileImageView.bounds.size.width
        dpEditButton.frame = editButtonFrame
    }
    
    private func getEditButtonFlotedPartHeight() ->  CGFloat {
        return 40
    }
    
    private func setupProfileNameLabel() {
        profileNameLabel.text = "currentUser.userName"
        profileNameLabel.textColor = .white
        profileNameLabel.font = UIFont(name: "SourceSansPro-SemiBold", size: 24)
    }
    
    public func setupPublicAddressButton() {
        publicAddressButton.setTitle("currentUser.uid-aasdlkkjadlkj", for: .normal)
        publicAddressButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.1)
        publicAddressButton.layer.cornerRadius = 15
    }
    
    @IBAction func didPressPubKeyButton(_ sender: Any) {
        print("Public address will be copied...")
    }
    
    func getPagerViewHeight() {
        if (DeviceHandler.isIpad()) {
            pagerViewHeightConstraint.constant = 500
        } else if (!DeviceHandler.isNotchedDevice()) {
            pagerViewHeightConstraint.constant = 410
        } else {
            pagerViewHeightConstraint.constant = 455
        }
    }
}




