//
//  HomeTabBarViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/8/22.
//

import UIKit


protocol HomeTabBarVCDelegate {
    func homeTabBarCalled()
}

class HomeTabBarViewController: UITabBarController {
    
    let customTab = CreateTabBar()
    let centerTabBar = CreateTabBar()
    
    var isAlreadyLoaded = false
    var isTabBarSizeUpdated = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarItems()
        
        self.selectedIndex = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Tab bar: view will apear called")
        
        if isAlreadyLoaded { return }
        
        delegate = self
        configureTabBarItems()
        isAlreadyLoaded = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.frame.size.height = 94
        tabBar.frame.origin.y = view.frame.height - tabBar.frame.size.height
        
        tabBar.isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()

        let bgImageView = UIImageView(image: UIImage(named: "tabBackground"))
        bgImageView.frame = tabBar.bounds
        tabBar.addSubview(bgImageView)
        tabBar.sendSubviewToBack(bgImageView)
        
        tabBar.itemPositioning = .fill
        tabBar.itemSpacing = UIScreen.main.bounds.width/6
    }
    
    private func configureTabBarItems() {
        customTab.tabBarControllerDelegate = self
        self.setValue(customTab, forKey: "tabBar")
        var textAttributes  :  [NSAttributedString.Key : NSObject] = [:]
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        if let font = UIFont(name: "Source Sans Pro", size: 14) {
            textAttributes = [
                NSAttributedString.Key.font : font,
                NSAttributedString.Key.kern : 0.1 as NSObject,
                NSAttributedString.Key.paragraphStyle : paragraphStyle,
            ]
        }
        
//        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 122/255, green: 54/255, blue: 247/255, alpha: 1)
//        tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "home")
        let navHomeVC = UINavigationController(rootViewController: homeVC)
        navHomeVC.isNavigationBarHidden = true
//        navHomeVC.tabBarItem.image = UIImage(named: "homeTabIcon")
//        navHomeVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        var customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeTabIcon"), selectedImage: UIImage(named: "selectedHomeTabIcon"))
        navHomeVC.tabBarItem = customTabBarItem
//        navHomeVC.tabBarItem.image = UIImage(named: "selectedHomeTabIcon")
//        navHomeVC.tabBarItem.title = "Home"
        let selectedColor   = UIColor(red: 122/255, green: 54/255, blue: 247/255, alpha: 1.0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)

        navHomeVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        navHomeVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        navHomeVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        
        let myNFTsVC = MYNFTsViewController()
        let navMyNFTsVC = UINavigationController(rootViewController: myNFTsVC)
        navMyNFTsVC.tabBarItem.image = UIImage(named: "myNFTsTabIcon")
        //navThirdTabVC.tabBarItem.selectedImage = UIImage(named: "MyLogosTabIconSelected")
//        navMyNFTsVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        navMyNFTsVC.isNavigationBarHidden = true
        navMyNFTsVC.tabBarItem.title = "NFTs"
        navMyNFTsVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        navMyNFTsVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        navMyNFTsVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        
        let createNFTVC = CreateNFTViewController()
        let navcreateNFTVC = UINavigationController(rootViewController: createNFTVC)
        navcreateNFTVC.tabBarItem.image = UIImage(named: "createIcon")
//        navcreateNFTVC.tabBarItem.imageInsets = getCreateButtonIconInsets()
//        navcreateNFTVC.isNavigationBarHidden = true
//        navcreateNFTVC.tabBarItem.title = " "
//        navcreateNFTVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
//        navcreateNFTVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        
        
        let thirdTabVC = ThirdTab()
        let navThirdTabVC = UINavigationController(rootViewController: thirdTabVC)
        navThirdTabVC.isNavigationBarHidden = true
        navThirdTabVC.tabBarItem.image = UIImage(named: "starIcon")
        //navThirdTabVC.tabBarItem.selectedImage = UIImage(named: "MyLogosTabIconSelected")
//        navThirdTabVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        navThirdTabVC.tabBarItem.title = "ThirdTab"
        navThirdTabVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        navThirdTabVC.isNavigationBarHidden = true
        navThirdTabVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        
        let profileVC = Profile()
        let navProfileVC = UINavigationController(rootViewController: UIViewController())
        navProfileVC.tabBarItem.title = "Profile"
        navProfileVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        navProfileVC.tabBarItem.image = UIImage(named: "profileTabIcon")
//        navProfileVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        navProfileVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        navProfileVC.isNavigationBarHidden = true
        
        viewControllers = [navHomeVC, navMyNFTsVC, navcreateNFTVC, navThirdTabVC, navProfileVC]
        tabBar.isTranslucent = false
        
    }
    
    private func getTabBarItemImageInsets()-> UIEdgeInsets {
        return UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 0)
    }
    
    private func getCreateButtonIconInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        let deviceType = DeviceHandler.getDeviceType()
//        switch deviceType {
//        case DeviceModel2XIpad9:
//            if #available(iOS 11.0, *) {
//
//                return UIEdgeInsets(top: -8, left: 10, bottom: 8,  right: -10)
//            } else {
//
//                return UIEdgeInsets(top: 0, left: 0, bottom: 0,  right: 0)
//            }
//        case DeviceModel2XIpad10:
//            if #available(iOS 11.0, *) {
//
//
//                return UIEdgeInsets(top: -10, left: 8, bottom: 10, right: -8)
//            } else {
//
//
//                return UIEdgeInsets(top: 0, left: 0, bottom: 0,  right: 0)
//            }
//        case DeviceModel2XIpad11:
//            return UIEdgeInsets(top: -8, left: 12, bottom: 8, right: -12)
//        case DeviceModel2XIpad12:
//            if #available(iOS 11.0, *) {
//
//                return UIEdgeInsets(top: -8, left: 12, bottom: 8, right: -12)
//            } else {
//                return UIEdgeInsets(top: 10, left: 0, bottom: -10,  right: 0)
//            }
//        default:
//            return UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
//        }
    }
    
    private func getTextBottomSpace() -> UIOffset {
        return UIOffset(horizontal: 0, vertical: -3)
//        let deviceType = DeviceHandler.getDeviceType()
//        switch deviceType {
//        case DeviceModel2XIpad9, DeviceModel2XIpad10, DeviceModel2XIpad11, DeviceModel2XIpad12:
//            if #available(iOS 13.0, *) {
//                return UIOffset(horizontal: 0, vertical: -4)
//            } else {
//                return UIOffset(horizontal: 0, vertical: 0)
//            }
//
//        default:
//            return UIOffset(horizontal: 0, vertical: 0)
//        }
    }
}

extension HomeTabBarViewController : CreateNFTTabBarDelegate {
    func createButtonPressed() {
        print("Create Button Pressed! ")
    }
}

extension HomeTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        setFirebaseEvent(vc: viewController)
//        if viewController.className == EditPageViewController.className {
//            let createCanvasVC = CreateNewViewController()
//            createCanvasVC.iconList = iconsList
//            createCanvasVC.designList = localList
//            let createNavVC = UINavigationController(rootViewController: createCanvasVC)
//
//            createNavVC.isNavigationBarHidden = true
//            createNavVC.modalPresentationStyle = .overFullScreen
//            present(createNavVC, animated: true, completion: nil)
//
//            return false
//        }
        
        return true
    }
}
