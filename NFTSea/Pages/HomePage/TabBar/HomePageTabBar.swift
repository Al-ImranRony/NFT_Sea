//
//  HomePageTabBar.swift
//  NFTSea
//
//  Created by Bitmorpher 4 on 6/8/22.
//

import UIKit


class HomePageTabBar: UITabBar {

    override var traitCollection: UITraitCollection {
         guard UIDevice.current.userInterfaceIdiom == .pad else {
             return super.traitCollection
         }
         return UITraitCollection(horizontalSizeClass: .compact)
     }
}

