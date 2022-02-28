//
//  UICollectionReusableView.swift
//  Wheather App
//
//  Created by Sinan Kulen on 24.02.2022.
//

import Foundation
import UIKit

extension UICollectionReusableView
{
    static var reuseIdentifier : String
    {
        return String(describing: self)
    }
    
    static var nib : UINib
    {
        return UINib(nibName: self.reuseIdentifier, bundle: nil)
    }
}
