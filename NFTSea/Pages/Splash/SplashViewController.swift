//
//  SplashViewController.swift
//  NFTing
//
//  Created by iRny - Bitmorpher 4 on 6/1/22.
//

import UIKit
import AVKit
import AVFoundation


class SplashViewController: UIViewController {
    
    var alreadySplashShowed = false
    let playerController = AVPlayerViewController()
    
    override func viewDidAppear(_ animated: Bool) {
        playVideo()
    }

    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "splashVideo", ofType: "mp4") else {
            debugPrint("Splash koi ?")
            return
        }
        
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)

        player.play()
    }
    
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        print("Method , video is finished ")
        playerController.view.removeFromSuperview()
        self.goToLoginOrHomePage()
    }
    
    private func goToLoginOrHomePage() {
        if alreadySplashShowed {
            return
        }
        alreadySplashShowed = true
        
//        let authenticatedUser = UserDefaults.standard.string(forKey: "userId")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeVC = storyboard.instantiateViewController(withIdentifier: "home")
        
        //TODO: try push nav, dismiss splash
        let homeTabBarController = HomeTabBarViewController()
        homeTabBarController.modalPresentationStyle = .fullScreen
        self.present(homeTabBarController, animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
        
//        if((authenticatedUser) != nil){
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let homeVC = storyboard.instantiateViewController(withIdentifier: "homeVC")
//            let navController =  UINavigationController.init(rootViewController: homeVC)
//            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//            appDelegate.window?.rootViewController = navController
//            appDelegate.window?.makeKeyAndVisible()
//        }
//        else{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "rootVC")
//            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
//            appDelegate.window?.rootViewController = vc
//            appDelegate.window?.makeKeyAndVisible()
//        }
    }
        
    
}
