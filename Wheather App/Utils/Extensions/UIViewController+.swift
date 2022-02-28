//
//  UIViewController+.swift
//  Wheather App
//
//  Created by Sinan Kulen on 23.02.2022.
//

import Foundation
import UIKit

extension UIViewController
{
    static var nibName : String
    {
        return String(describing: self)
    }
}
