//
//  Utils.swift
//  ineocoin
//
//  Created by Huy Lam on 12/6/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//

import Foundation
import UIKit
class Utils {
    
    static func resetAppData() {
        KeychainHelper.shared.removeAppToken()
        KeychainHelper.shared.removeWalletInfo()
    }
}
public enum OFDeviceType {
    case iphone_4_or_lower
    case iphone_5
    case iphone_6
    case iphone_6_plus
    case iphone_x
    case ipad
    case unspecified
    
    public static func getDeviceType() ->OFDeviceType {
        let screenHeight = UIScreen.main.bounds.size.height
        
        if UI_USER_INTERFACE_IDIOM() == .pad {
            return .ipad
        } else if  UI_USER_INTERFACE_IDIOM() == .phone {
            if screenHeight == 480.0 {
                return .iphone_4_or_lower
            } else if screenHeight == 568.0 {
                return .iphone_5
            }else if screenHeight == 667.0 {
                return .iphone_6
            }else if screenHeight == 736.0 {
                return .iphone_6_plus
            } else if screenHeight == 812.0 {
                return .iphone_x
            } else {
                return .unspecified
            }
        }
        return unspecified
    }
}

