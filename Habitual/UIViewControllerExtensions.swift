//
//  UIViewControllerExtensions.swift
//  Habitual
//
//  Created by Kandy M on 12/4/18.
//  Copyright © 2018 Kandy M. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
