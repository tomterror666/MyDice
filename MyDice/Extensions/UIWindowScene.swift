//
//  UIWindowScene.swift
//  MyDice
//
//  Created by Andre Heß on 29.04.23.
//

import Foundation
import UIKit

class DicesRatio {
    var horizontal: Int = 0
    var vertical: Int = 0
    var size: CGFloat = 0.0
    
    init(horizontal: Int, vertical: Int, size: CGFloat) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.size = size
    }
    
    init(_ tripel:(Int, Int, CGFloat)) {
        horizontal = tripel.0
        vertical = tripel.1
        size = tripel.2
    }
}

extension UIWindowScene {
    func getPiecesRatio(numberOfElements: Int, outerDistance: CGFloat, innerDistance: CGFloat, topDistance: CGFloat = 0) -> DicesRatio {
        guard let screen = windows.first?.screen, let screenSize = screen.currentMode?.size else { return DicesRatio((0, 0, 0.0)) }
        let width = screenSize.width / screen.scale - 2 * outerDistance
        
        if numberOfElements == 0 {return DicesRatio((0, 0, 0.0))}
        if numberOfElements == 1 {return DicesRatio((1, 1, width))}
            
        let maxHeight = screenSize.height / screen.scale - 2 * outerDistance - topDistance
        let endVal = Int(ceil(sqrt(Double(numberOfElements))))
        
        for counter in (1...endVal) {
            let usedElementWidth = (width - CGFloat((counter - 1)) * innerDistance) / CGFloat(counter)
            let verticalNumbers = ceil(CGFloat(numberOfElements) / CGFloat(counter))
            let resultingHeight = verticalNumbers * usedElementWidth + (verticalNumbers - 1) * innerDistance
            
            if resultingHeight < maxHeight {
                return DicesRatio((counter, numberOfElements % counter > 0 ? numberOfElements / counter + 1 : numberOfElements / counter, usedElementWidth))
            }
        }
        
        /*let ratio = CGFloat(width) / CGFloat(maxHeight)
        let horizontal = Int(ceil(sqrt(CGFloat(numberOfElements) * ratio)))
        let vertical = Int(ceil((CGFloat(numberOfElements) / CGFloat(horizontal))))
        let size = floor((width - CGFloat((horizontal - 1)) * innerDistance) / CGFloat(horizontal))
        return DicesRatio(horizontal: horizontal, vertical: vertical, size: size)*/
        
        return DicesRatio((0, 0, 0.0))
    }
}
