//
//  AppDelegate.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/5/22.
//

import UIKit
import FirebaseCore
import FirebaseFirestore


public let storyBoard = UIStoryboard(name: "Main", bundle: nil)
public let firestore = Firestore.firestore()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        //DevModeCode
        
        let connectWalletVC = storyBoard.instantiateViewController(withIdentifier: "connectWalletVC") as! ConnectWalletViewController
        let profileVC = storyBoard.instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        let homeTabBarController = HomeTabBarViewController()

        //Splash Screen Video
        
        let splashVC = storyBoard.instantiateViewController(withIdentifier: "splashVC") as! SplashViewController
        
        let navController = UINavigationController(rootViewController: homeTabBarController)
        navController.setNavigationBarHidden(true, animated: true)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }



}

