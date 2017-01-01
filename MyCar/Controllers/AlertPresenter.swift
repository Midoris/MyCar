//
//  AlertPresenter.swift
//  MyCar
//
//  Created by Ievgenii Iablonskyi on 01/01/2017.
//  Copyright © 2017 Ievgenii Iablonskyi. All rights reserved.
//

import Foundation
import UIKit

class AlertPresenter {

    class func showAlert(withTitle title: String, andMessage message: String) {
        guard let controller = UIApplication.topViewController() else {
            print("Wasn't able to find top controller")
            return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }

}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

