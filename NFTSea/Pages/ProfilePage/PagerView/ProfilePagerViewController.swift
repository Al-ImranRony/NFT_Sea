//
//  ProfilePagerViewController.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/21/22.
//

import UIKit
import Pageboy
import Tabman

class PagerViewController: TabmanViewController{
    
    var viewControllers = [AllNFTsViewController(), UIViewController(), UIViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.dataSource = self
        
        setupPageBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func setupPageBar() {
        let pageBar = TMBar.ButtonBar()
        pageBar.indicator.weight = .light
        pageBar.layout.contentInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        pageBar.buttons.customize { button in
            button.tintColor = UIColor(red: 183/255, green: 181/255, blue: 181/255, alpha: 1.0)
            button.selectedTintColor = .white
        }
        let systemBar = pageBar.systemBar()
        systemBar.backgroundStyle = .clear
        addBar(systemBar, dataSource: self, at:.top)
    }
}

extension PagerViewController: PageboyViewControllerDataSource, TMBarDataSource {
  
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 3
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            let item = TMBarItem(title: "All NFTs")
            return item
        case 1:
            let item = TMBarItem(title: "Collected")
            return item
        case 2:
            let item = TMBarItem(title: "Created")
            return item
        default:
            let title = "NFTs \(index)"
            return TMBarItem(title: title)
        }
    }
    
}
