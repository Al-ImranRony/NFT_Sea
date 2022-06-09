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
        createButton.adjustsImageWhenHighlighted = false
        addSubview(createButton)
        createButton.setImage(UIImage(named: "Floating_Button"), for: .normal)
        createButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .allTouchEvents)
        layoutIfNeeded()
    }
    
    @objc private func menuButtonAction(sender: UIButton) {
        tabBarControllerDelegate?.createButtonPressed()
    }
    
    private func getCreateButtonSize()-> CGSize {
        return CGSize(width: 48, height: 48)
    }
    
    private func setCreateButtonFrame() {
        var createButtonFrame = createButton.frame
        createButtonFrame.origin.y = 0 - getCreateButtonFlotedPartHeight()
        createButtonFrame.origin.x = (self.bounds.width / 2) - (createButton.frame.width / 2)
        createButton.frame = createButtonFrame
    }
    
    private func getCreateButtonFlotedPartHeight() ->  CGFloat {
        return 14
    }
    
}
