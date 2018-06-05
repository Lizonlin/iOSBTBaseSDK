//
//  NetworkReachability.swift
//  drawlinegame
//
//  Created by Alex Chow on 2017/7/6.
//  Copyright © 2017年 Bahamut. All rights reserved.
//
// Podfile : pod 'Alamofire'

import Alamofire
import Foundation

let NetworkReachabilityStatusChanged = Notification.Name(rawValue: "NetworkReachabilityStatusChanged")
let kNetworkReachabilityStatusValue = "kNetworkReachabilityStatusValue"

class NetworkReachability: NotificationCenter {
    private(set) static var manager: NetworkReachabilityManager!
    static let shared: NetworkReachability = {
        NetworkReachability()
    }()

    static func startListenNetworking() {
        if manager == nil {
            manager = NetworkReachabilityManager(host: "www.baidu.com") ?? NetworkReachabilityManager(host: "www.google.com")
        }
        if manager?.listener == nil {
            manager?.listener = { status in
                shared.post(name: NetworkReachabilityStatusChanged, object: shared, userInfo: [kNetworkReachabilityStatusValue: status])
            }
            manager?.startListening()
        }
    }

    static func stopListenNetworking() {
        manager?.stopListening()
    }

    static var isReachable: Bool {
        return manager?.isReachable ?? false
    }
}
