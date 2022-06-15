//
//  AppDelegate.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/5/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //DevModeCode
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let connectWalletVC = storyboard.instantiateViewController(withIdentifier: "connectWalletVC") as! ConnectWalletViewController
        
        //Splash Screen Video
        
        let splashVC = storyboard.instantiateViewController(withIdentifier: "splashVC") as! SplashViewController
        
        let navController = UINavigationController(rootViewController: connectWalletVC)
        navController.setNavigationBarHidden(true, animated: true)

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }



}

