//
//  HomeTabBarViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/8/22.
//

import UIKit


//protocol HomeTabBarVCDelegate {
//    func homeTabBarCalled()
//}

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
        
        print("Tab bar: view will appear called")
        
        if isAlreadyLoaded { return }
        isAlreadyLoaded = true
        delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.frame.size.height = 94
        tabBar.frame.origin.y = view.frame.height - tabBar.frame.size.height
        
        tabBar.isTranslucent = true
        UITabBar.appearance().barTintColor = UIColor.clear
        UITabBar.appearance().tintColor = UIColor(red: 122/255, green: 54/255, blue: 247/255, alpha: 1.0)
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
//        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 122/255, green: 54/255, blue: 247/255, alpha: 1)

        let bgImageView = UIImageView(image: getTabBarBGImage())
        bgImageView.frame = tabBar.bounds
        tabBar.addSubview(bgImageView)
        tabBar.sendSubviewToBack(bgImageView)
        
        tabBar.itemPositioning = .fill
        tabBar.itemSpacing = UIScreen.main.bounds.width/6
    }
    
    //Multidevice catalogues
    func getTabBarBGImage() -> UIImage {
        let deviceTypeTab = DeviceHandler.isIpad()
        if deviceTypeTab {
            return UIImage(named: "tabBarBackground_tab")!
        }else {
            return UIImage(named: "tabBackground")!
        }
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
        
        
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "home")
        let navHomeVC = UINavigationController(rootViewController: homeVC)
        navHomeVC.isNavigationBarHidden = true
//        navHomeVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        var customTabBarItem:UITabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeTabIcon"), selectedImage: UIImage(named: "selectedHomeTabIcon"))
        navHomeVC.tabBarItem = customTabBarItem
        let selectedColor   = UIColor(red: 122/255, green: 54/255, blue: 247/255, alpha: 1.0)
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
        let navCreateNFTVC = UINavigationController(rootViewController: createNFTVC)
//        navCreateNFTVC.tabBarItem.image = UIImage(named: "createIcon")
        navCreateNFTVC.tabBarItem.imageInsets = getCreateButtonIconInsets()
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
//        navThirdTabVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        navThirdTabVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        navThirdTabVC.isNavigationBarHidden = true
        navThirdTabVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        
        let profileVC = storyBoard.instantiateViewController(withIdentifier: "profileVC")
        let navProfileVC = UINavigationController(rootViewController: profileVC)
        navProfileVC.tabBarItem.title = "Profile"
        navProfileVC.tabBarItem.setTitleTextAttributes(textAttributes, for: .normal)
        navProfileVC.tabBarItem.image = UIImage(named: "profileTabIcon")
        
//        navProfileVC.tabBarItem.imageInsets = getTabBarItemImageInsets()
        navProfileVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 15)
        navProfileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
//        navProfileVC.tabBarItem.titlePositionAdjustment = getTextBottomSpace()
        navProfileVC.isNavigationBarHidden = true
        
        viewControllers = [navHomeVC, navMyNFTsVC, navCreateNFTVC, navThirdTabVC, navProfileVC]
        tabBar.isTranslucent = false
        
    }
    
    private func getTabBarItemImageInsets()-> UIEdgeInsets {
        if (DeviceHandler.isIpad()) {
            return UIEdgeInsets(top: -2, left: 5, bottom: -2, right: 5)
        } else if (!DeviceHandler.isNotchedDevice()) {
            return UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 0)
        } else {
            return UIEdgeInsets(top: -2, left: 0, bottom: -2, right: 0)
        }
    }
    
    private func getTabBarItemTitleInsets()-> UIOffset {
        return UIOffset(horizontal: 12, vertical: 12)
    }
    
    private func getCreateButtonIconInsets() -> UIEdgeInsets {
//        return UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
        let deviceType = DeviceHandler.getDeviceType()
        switch deviceType {
        case .DeviceModel2XIpad9:
            if #available(iOS 11.0, *) {

                return UIEdgeInsets(top: -8, left: 10, bottom: 8,  right: -10)
            } else {

                return UIEdgeInsets(top: 0, left: 0, bottom: 0,  right: 0)
            }
        case .DeviceModel2XIpad10:
            if #available(iOS 11.0, *) {

                return UIEdgeInsets(top: -10, left: 8, bottom: 10, right: -8)
            } else {

                return UIEdgeInsets(top: 0, left: 0, bottom: 0,  right: 0)
            }
        case .DeviceModel2XIpad11:
            return UIEdgeInsets(top: -8, left: 12, bottom: 8, right: -12)
            
        case .DeviceModel2XIpad12:
            if #available(iOS 11.0, *) {

                return UIEdgeInsets(top: -8, left: 12, bottom: 8, right: -12)
            } else {
                return UIEdgeInsets(top: 10, left: 0, bottom: -10,  right: 0)
            }
        default:
            return UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
        }
    }
    
    private func getTextBottomSpace() -> UIOffset {
        if (DeviceHandler.isIpad()) {
            return UIOffset(horizontal: 0, vertical: 5)
        } else if (!DeviceHandler.isNotchedDevice()) {
            return UIOffset(horizontal: 0, vertical: -20)
        } else {
            return UIOffset(horizontal: 0, vertical: -3)
        }
    }
}

extension HomeTabBarViewController : CreateNFTTabBarDelegate {
    func createButtonPressed() {
        print("Create Button Pressed! ")
        let createNFTVC = CreateNFTViewController()
        let navCreateNFTVC = UINavigationController(rootViewController: createNFTVC)
        self.present(navCreateNFTVC, animated: true, completion: nil)
    }
}

extension HomeTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
}
