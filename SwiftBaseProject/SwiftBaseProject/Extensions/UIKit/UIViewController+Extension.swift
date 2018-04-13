//
//  UIViewController+Extension.swift
//  ineocoin
//
//  Created by Huy Lam on 12/6/17.
//  Copyright © 2017 Engie Ineo. All rights reserved.
//
//
//  UIViewController+Extension.swift
//  plaapping
//
//  Created by Quang Luu on 4/27/17.
//  Copyright © 2017 Officience. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIViewController{
    
    var previousViewController:UIViewController?{
        if let controllersOnNavStack = self.navigationController?.viewControllers{
            let n = controllersOnNavStack.count
            //if self is still on Navigation stack
            if controllersOnNavStack.last === self, n > 1{
                return controllersOnNavStack[n - 2]
            }else if n > 0{
                return controllersOnNavStack[n - 1]
            }
        }
        return nil
    }
    
    public var isVisible: Bool {
        // http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
        return self.isViewLoaded && view.window != nil
    }
    
    func showLoadingProgress(message: String = "Loading...") {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func dismissLoadingProgress() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func showAlert(title: String?, message: String?, okAction: ((UIAlertAction) -> ())? = nil) {
        if self.navigationController?.visibleViewController is UIAlertController != true {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "ok", style: .default, handler: okAction)
            alertController.addAction(OKAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func showError(message: String) {
        InfoView.showIn(viewController: self, message: message, status: .negative)
    }
    
    func makeToast(message: String) {
        InfoView.showIn(viewController: self, message: message)
    }
    
    func isModal() -> Bool {
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
        
    }
}

extension UIViewController {
    var appDelegate:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension UIViewController {
    class func instance() -> Self {
        let storyboardName = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.initialViewController()
    }
}

