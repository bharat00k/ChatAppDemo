//
//  Helper.swift
//  ChatAppDemo
//
//  Created by Bharat Khatke on 25/08/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit

class Helper: NSObject {

}

extension UINavigationController {
    func popToYourViewController(ofClass: AnyClass, animated: Bool)  {
        if let vc = viewControllers.filter({ $0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
}
