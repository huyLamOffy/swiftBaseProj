//
//  KeychainUtils.swift
//  plaapping
//
//  Created by Quang Luu on 2/6/17.
//  Copyright © 2017 Officience. All rights reserved.
//

import Foundation
import KeychainAccess

class KeychainHelper {
    
    static let shared = KeychainHelper()
    let keychain = Keychain(service: "") //NOTE: add new service
    
    // App Token
    func getAppToken() -> String? { return keychain[KeychainKey.apptoken] }
    func setAppToken(token: String) { keychain[KeychainKey.apptoken] = token }
    func removeAppToken() {
        do {
            try keychain.remove(KeychainKey.apptoken)
        } catch let error {
            print("error: \(error)")
        }
    }
    
    // App Token
    func getRefreshToken() -> String? { return keychain[KeychainKey.refreshToken] }
    func setRefreshToken(token: String) { keychain[KeychainKey.refreshToken] = token }
    func removeRefreshToken() {
        do {
            try keychain.remove(KeychainKey.refreshToken)
        } catch let error {
            print("error: \(error)")
        }
    }
    
    func getWalletInfo() -> String? { return keychain[KeychainKey.walletInfo] }
    func setWalletInfo(walletInfo: String) { keychain[KeychainKey.walletInfo] = walletInfo }
    func removeWalletInfo() {
        do {
            try keychain.remove(KeychainKey.walletInfo)
        } catch let error {
            print("error: \(error)")
        }
    }
    
}

fileprivate enum KeychainKey {
    static let apptoken = "app_token"
    static let walletInfo = "wallet_info"
    static let refreshToken = "refresh_token"
}

