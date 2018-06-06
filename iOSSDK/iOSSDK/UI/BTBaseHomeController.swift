//
//  BTBaseHomeController.swift
//  BTBaseSDK
//
//  Created by Alex Chow on 2018/6/3.
//  Copyright © 2018年 btbase. All rights reserved.
//

import UIKit

class BTBaseHomeController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    func tabBarController(_: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.restorationIdentifier == "AccountNavigationController" {
            if let sessionService = BTServiceContainer.getBTSessionService() {
                if sessionService.isSessionLogined {
                    return true
                }
            }
            performSegue(withIdentifier: "SignIn", sender: nil)
            return false
        }
        return true
    }

    @IBAction func OnClickClose(_: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}

public class BTBaseHomeEntry {
    internal private(set) static var homeController: BTBaseHomeController?

    public static func getEntryViewController() -> UIViewController {
        let board = UIStoryboard(name: "BTBaseMainStoryboard", bundle: Bundle.iOSBTBaseSDKUI)
        homeController = board.instantiateViewController(withIdentifier: "BTBaseHomeController") as? BTBaseHomeController
        return homeController!
    }

    public static func closeHomeController() {
        homeController?.dismiss(animated: true, completion: nil)
    }
}