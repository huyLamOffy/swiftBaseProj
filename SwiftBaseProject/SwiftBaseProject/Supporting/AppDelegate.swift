//
//  AppDelegate.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 3/22/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setupUI()
        APIClient.sharedInstanceWith(model: APIModel(baseUrl: "https://ineo.officience.com/api/v1", token: "eyJraWQiOiI4R2Y5NERLc3lqdmJlUlAySlNpZEZrOW5CM3k2bzB2NGFGb1UyeGZWbUxZIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULkdCeEZwTUpfbmpfX1N0UGtJNXo2b1dpWmc1WGl2S0d3X3lYaldyTGtJX2MuWkx2NzE1YzA3L1g2bUY1R2VsUzNxWm9mbjhadyt3N1A4MHlZaFVlNGVmZz0iLCJpc3MiOiJodHRwczovL2Rldi00NDc1Njgub2t0YXByZXZpZXcuY29tIiwiYXVkIjoiaHR0cHM6Ly9kZXYtNDQ3NTY4Lm9rdGFwcmV2aWV3LmNvbSIsInN1YiI6ImxpZW1AbWFpbGluYXRvci5jb20iLCJpYXQiOjE1MjM2MDQyOTEsImV4cCI6MTUyMzYwNzg5MSwiY2lkIjoiMG9hZGJkYW1vdEdwMUppc2YwaDciLCJ1aWQiOiIwMHVkbGEwYmR5a2k4YTJxcDBoNyIsInNjcCI6WyJvZmZsaW5lX2FjY2VzcyIsInBob25lIiwicHJvZmlsZSIsImVtYWlsIiwiYWRkcmVzcyIsIm9wZW5pZCJdfQ.f45lzkMjsxvGlGaOZNWBlQQ7zyRJgzI0YR8AqRow3lzPP_xyE-PlECYedzqrwyQO1M86RIR83xP6_nMR8QiTZMmQq9e_9KRGMQ7Zo9E7cjdtToqDslhjh7loQ5KJTx4BmG5OE_Phm2Wp-gWAYD9bMEUgDiEjL-hEkBtTNSF-9JBYO4CcWYYhdmIWdaZjRa9FQdS30Wvti7f_fOeLeqqyGLDAVV4Ls3zbFZMfbV7m1Z1-ncmPcK3KMUPofvfVCNftr76scBN3rJ_5EIwXtmRxb0Ich9zH-jPVrOWMkIF_Lt22uE6f-ofBP5Vk8eczcEmfOrP_44d13qKCfdIYkpZGqw", refreshToken: "rNFf6uTKKuqQ2YJxfHl-l87kpJUi3pVbmett54Y5zZg"))
        setRootViewController()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // Stop network listener
        ReachabilityManager.shared.stopMonitoring()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        // Start network listener
        ReachabilityManager.shared.startMonitoring()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//MARK: - Helper methods
extension AppDelegate {
    private func setupUI() {
        // Alamofire indicator
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        // UI
        ApperanceProxyHelper.customizeNavigationBar()
    }
    
    func setRootViewController() {
        var vc: UIViewController!
        vc = TestViewController.instance()
//        if let token = MyApplication.appToken {
//            vc = MainTabbarController.instance()
//            (vc as? MainTabbarController)?.importWallet(walletJSON)
//            (vc as? MainTabbarController)?.viewModel.fetchMyProfile()
//        } else {
//            vc = LoginViewController.instance()
//        }
        
        self.window?.rootViewController = vc
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
    }
}

