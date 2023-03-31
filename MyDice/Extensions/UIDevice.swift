//
//  UIDevice.swift
//  MyDice
//
//  Created by Andre Heß on 24.03.23.
//

import Foundation
import UIKit

extension UIDevice {
    func isIPhoneX() -> Bool {
        let height = UIScreen.main.nativeBounds.height / UIScreen.main.scale
        let width = UIScreen.main.nativeBounds.width / UIScreen.main.scale

        return (height == 780 || width == 780       // ???
                || height == 812 || width == 812    // iPhone X, iPhone XS, iPhone 11 Pro, iPhone 13 mini
                || height == 844 || width == 844    // iPhone 12, iPhone 12 Pro, iPhone 13, iPhone 13 Pro, iPhone 14
                || height == 852 || width == 852    // iPhone 14 Pro
                || height == 896 || width == 896    // iPhone XS Max, iPhone XR, iPhone 11, iPhone 11 Pro Max
                || height == 926 || width == 926    // iPhone 12 Pro Max, iPhone 13 Pro Max, iPhone 14 Plus
                || height == 932 || width == 932)   // iPhone Pro 14 Max
    }
}
