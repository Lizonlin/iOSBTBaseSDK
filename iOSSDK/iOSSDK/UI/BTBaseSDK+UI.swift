//
//  BTBaseSDK+UI.swift
//  BTBaseSDK
//
//  Created by Alex Chow on 2018/6/11.
//  Copyright © 2018年 btbase. All rights reserved.
//

import Foundation
import UIKit

public extension BTBaseSDK {
    @objc public var GameServiceName: String { return "BTLocGameServiceName".localizedBTBaseString }

    @objc public static func tryShowLoginWithSharedAuthenticationAlert(vc: UIViewController) {
        if let auth = getAuthentication(), let accountId = auth.accountId {
            let title = "BTLocTitleSharedAuthenticationExists".localizedBTBaseString
            let msg = String(format: "BTLocMsgSharedAuthenticationExists".localizedBTBaseString, accountId)
            vc.showAlert(title, msg: msg, actions: [ALERT_ACTION_CANCEL, UIAlertAction(title: "BTLocQuickSignIn".localizedBTBaseString, style: .default, handler: { _ in
                BTServiceContainer.getBTSessionService()?.login(auth.accountId, auth.saltedPassword, passwordSalted: true, autoFillPassword: false, respAction: { _, res in
                    if res.isHttpOK {
                        openHome(vc)
                    } else {
                        openHome(vc, completion: { home in
                            home.showSignIn()
                        })
                    }
                })
            })])
        }
    }

    @objc public static func openHome(_ vc: UIViewController) {
        openHome(vc) { _ in }
    }

    private static func openHome(_ vc: UIViewController, completion: @escaping (BTBaseHomeController) -> Void) {
        BTBaseHomeEntry.openHome(vc,completion: completion)
    }
}