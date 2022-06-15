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
        
        let authenticatedUser = UserDefaults.standard.string(forKey: "userId")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //TODO: try push nav, dismiss splash

        
        if((authenticatedUser) != nil){
            
            let homeTabBarController = HomeTabBarViewController()
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(homeTabBarController, animated: true)
        }
        else{
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
        
    
}
