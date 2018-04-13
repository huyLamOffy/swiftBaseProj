//
//  BaseViewController.swift
//  SwiftBaseProject
//
//  Created by Huy Lam on 3/22/18.
//  Copyright © 2018 Huy Lam. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class BaseViewController: UIViewController {
    //MARK: - Properties
    internal var progressHUD: MBProgressHUD?
    
    //MARK: - View cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ReachabilityManager.shared.removeListener(listener: self)
    }
    
    deinit {
        print(self,"deinit")
    }
    
    //MARK: - Helper methods
    internal func showHud(message: String = "Loading...") {
        if progressHUD == nil {
            progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        progressHUD?.label.text = message
    }
    
    internal func dismissHud() {
        progressHUD?.hide(animated: true)
        progressHUD = nil
    }
}

//MARK: - NetworkStatusListener
extension BaseViewController: NetworkStatusListener {
    func networkStatusDidChange(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        switch status {
        case .notReachable:
            print("The network is not reachable")
            
        case .unknown :
            print("It is unknown whether the network is reachable")
            
        case .reachable(.ethernetOrWiFi):
            print("The network is reachable over the WiFi connection")
            
        case .reachable(.wwan):
            print("The network is reachable over the WWAN connection")
        }
    }
}
