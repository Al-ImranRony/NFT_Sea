//
//  CreateTabBar.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/8/22.
//

import UIKit

protocol CreateNFTTabBarDelegate {
    func createButtonPressed()
}


class CreateTabBar: UITabBar {
    
    private var shapeLayer: CALayer?
    //        private let centerHeight: CGFloat = 22
    //        private let gapValue: CGFloat = 42
    private var createButton = UIButton()
    var tabBarControllerDelegate: CreateNFTTabBarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCreateButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("initializer called")
        setupCreateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        let from = point
        let to = createButton.center
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 45.254834 ? createButton : super.hitTest(point, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
        setCreateButtonFrame()
    }
    
    private func setupCreateButton() {
        let middleButtonSize = getCreateButtonSize()
        let middleButtonWidth = middleButtonSize.width
        let middleButtonHeight = middleButtonSize.height
        createButton = UIButton(frame: CGRect(x: 0, y: 0, width: middleButtonWidth, height: middleButtonHeight))
        setCreateButtonFrame()

        addSubview(createButton)
        createButton.setImage(getCreateButtonIconImage(), for: .normal)
        createButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        createButton.layer.shadowColor = UIColor(red: 237/255, green: 79/255, blue: 151/255, alpha: 0.15).cgColor
        createButton.layer.shadowOffset = CGSize(width: 1, height: 5)
        createButton.layer.shadowOpacity = 3.5
        createButton.layer.shadowRadius = 5
        layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        tabBarControllerDelegate?.createButtonPressed()
    }
    
    private func getCreateButtonSize()-> CGSize {
        let deviceTypeTab = DeviceHandler.isIpad()
        if (deviceTypeTab) {
            return CGSize(width: 84, height: 84)
        } else if (!DeviceHandler.isNotchedDevice()) {
            return CGSize(width: 48, height: 48)
        } else {
            return CGSize(width: 44, height: 44)
        }
    }
    
    private func setCreateButtonFrame() {
        var createButtonFrame = createButton.frame
        createButtonFrame.origin.y = 0 - getCreateButtonFlotedPartHeight()
        createButtonFrame.origin.x = (self.bounds.width / 2) - (createButton.frame.width / 2)
        createButton.frame = createButtonFrame
    }
    
    private func getCreateButtonFlotedPartHeight() ->  CGFloat {
        if (DeviceHandler.isIpad()) {
            return 38
        } else if (!DeviceHandler.isNotchedDevice()) {
            return 14
        } else {
            return 7
        }
    }
    
    func getCreateButtonIconImage() -> UIImage {
        let deviceTypeTab = DeviceHandler.isIpad()
        if deviceTypeTab {
            return UIImage(named: "Floating_Button_Tab")!
        }else {
            return UIImage(named: "Floating_Button")!
        }
    }
    
}
