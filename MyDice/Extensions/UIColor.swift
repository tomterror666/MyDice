//
//  UIColor.swift
//  MyDice
//
//  Created by Andre Heß on 26.03.23.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(data: Data) {
        let size = MemoryLayout<CGFloat>.size
        self.init(red:   data.subdata(in: size*0..<size*1).object(),
                  green: data.subdata(in: size*1..<size*2).object(),
                  blue:  data.subdata(in: size*2..<size*3).object(),
                  alpha: data.subdata(in: size*3..<size*4).object())
    }
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        return getRed(&red, green: &green, blue: &blue, alpha: &alpha) ?
        (red, green, blue, alpha) : nil
    }
    var data: Data? {
        guard let rgba = rgba else { return nil }
        return rgba.red.data + rgba.green.data + rgba.blue.data + rgba.alpha.data
    }
    
    static func grayColorArray(count: Int, step: CGFloat) -> [UIColor] {
        var grayValues: CGFloat = 0;
        var colors: [UIColor] = []
        for _ in 1...count {
            colors.append(UIColor(red: grayValues, green: grayValues, blue: grayValues, alpha: 1))
            grayValues += step
        }
        
        return colors
    }
}
