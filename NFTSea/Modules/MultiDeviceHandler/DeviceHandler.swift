//
//  DeviceHandler.swift
//  GIF-Maker
//
//  Created by Sagar on 6/13/22.
//

import UIKit

enum DeviceModel {
    case DeviceModel2XDefault
    case DeviceModel2XXR
    case DeviceModel2XSE
    case DeviceModel3XMini
    case DeviceModel3XDefault
    case DeviceModel3XXNormal
    case DeviceModel3XXMax
    case  DeviceModel3X12
    case DeviceModel3X12ProMax
    
    case  DeviceModel2XIpad9
    case DeviceModel2XIpad10
    case  DeviceModel2XIpad11
    case DeviceModel2XIpad12
    case DeviceModelNotFound
}

class DeviceHandler : NSObject {
    private override init() {
        super.init()
    }
    
    class func getDeviceType()-> DeviceModel {
        let scale = UIScreen.main.scale
        let screenSize = UIScreen.main.bounds.size
        switch Int(screenSize.height) {
        case 568:
            return .DeviceModel2XSE // Iphone SE
        case 780:
            return .DeviceModel3XMini; // iPhone 12/13 mini
        case 896:
            if (scale == 2) {
                return .DeviceModel2XXR; // Iphone 11
            } else if (scale == 3) {
                return .DeviceModel3XXMax; // Iphone 11 Pro Max
            }
        case 667:
            return .DeviceModel2XDefault; // Iphone 6
        case 736:
            return .DeviceModel3XDefault; // Iphone 6+
        case 812:
            return .DeviceModel3XXNormal; // Iphone 11 Pro and 12 mini
        case 844:
            return .DeviceModel3X12; // Iphone 12
        case 926:
            return .DeviceModel3X12ProMax; // 12 pro max
            
        case 1024:
            return .DeviceModel2XIpad9;
        case 1112,
            1080, // Ipad 7th gen 10.2
            1180, // Ipad Air 2020
            1133: //  Ipad mini 2021
            return .DeviceModel2XIpad10;
        case 1194:
            return .DeviceModel2XIpad11;
        case 1366:
            return .DeviceModel2XIpad12;
        default:
            return .DeviceModelNotFound
        }
        return .DeviceModelNotFound
        
    }
    
    class func isNotchedDevice()-> Bool {
        let deviceModel = DeviceHandler.getDeviceType()
        switch deviceModel {
        case .DeviceModel2XXR, .DeviceModel3XXNormal, .DeviceModel3XXMax, .DeviceModel3XMini, .DeviceModel3X12, .DeviceModel3X12ProMax :
            return true
        default:
            return false
        }
    }
    
    class func isIpad()-> Bool {
        let deviceModel = DeviceHandler.getDeviceType()
        switch deviceModel {
        case .DeviceModel2XIpad9, .DeviceModel2XIpad10, .DeviceModel2XIpad11, .DeviceModel2XIpad12 :
            return true
        default:
            return false
        }
    }
    
//    class func getTotalVerticalSafeArea()-> CGFloat {
//        if !self.isNotchedDevice() {
//            return 0
//        } else {
//            return GifMakerConfig.getSafeAreaInsetTop() + GifMakerConfig.getSafeAreaInsetBottom()
//        }
//    }
}
