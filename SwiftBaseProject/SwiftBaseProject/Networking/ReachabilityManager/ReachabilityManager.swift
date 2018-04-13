//
//  ReachabilityManager.swift
//  plaapping
//
//  Created by Quang Luu on 5/18/17.
//  Copyright © 2017 Officience. All rights reserved.
//

import Alamofire

/// Protocol for listenig network status change
public protocol NetworkStatusListener : class {
    func networkStatusDidChange(status: NetworkReachabilityManager.NetworkReachabilityStatus)
}

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()  // 2. Shared instance
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: NetworkReachabilityManager.NetworkReachabilityStatus = .notReachable
    
    // 5. Reachibility instance for Network status monitoring
    private let networkReachabilityManager = NetworkReachabilityManager()
    
    // 6. Array of delegates which are interested to listen to network status change
    var listeners = [NetworkStatusListener]()
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        
        networkReachabilityManager?.listener = {[unowned self] status in
            
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
            
            self.reachabilityStatus = status
            
            // Sending message to each of the delegates
            for listener in self.listeners {
                listener.networkStatusDidChange(status: status)
            }
        }
        networkReachabilityManager?.startListening()
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        networkReachabilityManager?.stopListening()
    }
    
    /// Adds a new listener to the listeners array
    ///
    /// - parameter delegate: a new listener
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }
    
    /// Removes a listener from listeners array
    ///
    /// - parameter delegate: the listener which is to be removed
    func removeListener(listener: NetworkStatusListener){
        listeners = listeners.filter{ $0 !== listener}
    }
}
