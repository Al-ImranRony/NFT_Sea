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
        return true
    }
    
    override init() {
//        FirebaseApp.configure()
        
        //Splash Screen Video
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let splashVC = storyboard.instantiateViewController(withIdentifier: "splashVC")
//        let navController =  UINavigationController.init(rootViewController: splashVC)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = splashVC
        self.window?.makeKeyAndVisible()
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

