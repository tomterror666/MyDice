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
    func getPiecesRatio(numberOfElements: Int, outerDistance: CGFloat, innerDistance: CGFloat, topDistance: CGFloat = 0, bottomDistance: CGFloat = 0) -> DicesRatio {
        guard let screen = windows.first?.screen, let screenSize = screen.currentMode?.size else { return DicesRatio((0, 0, 0.0)) }
        let width = screenSize.width / screen.scale - 2 * outerDistance
        
        if numberOfElements == 0 {return DicesRatio((0, 0, 0.0))}
        if numberOfElements == 1 {return DicesRatio((1, 1, width))}
        
        let maxHeight = screenSize.height / screen.scale - 2 * outerDistance - topDistance - bottomDistance
        let endVal = Int(ceil(sqrt(Double(numberOfElements))))
        
        for counter in (1...endVal) {
            let usedElementWidth = scaledRound((width - CGFloat((counter - 1)) * innerDistance) / CGFloat(counter))
            let verticalNumbers = ceil(CGFloat(numberOfElements) / CGFloat(counter))
            let resultingHeight = verticalNumbers * usedElementWidth + (verticalNumbers - 1) * innerDistance
            
            if resultingHeight < maxHeight {
                return DicesRatio((counter, numberOfElements % counter > 0 ? numberOfElements / counter + 1 : numberOfElements / counter, usedElementWidth))
            }
        }
        
        return DicesRatio((0, 0, 0.0))
    }
    
    private func scaledRound(_ value: CGFloat) -> CGFloat {
        guard let screen = windows.first?.screen else { return 0.0 }
        let scale = screen.scale
        
        return round(value * scale) / scale
    }
    
    func currentScreenSize() -> CGSize {
        if let mainScreen = self.windows.first?.screen {
            return CGSize(width: mainScreen.bounds.width * mainScreen.scale, height: mainScreen.bounds.size.height * mainScreen.scale)
        } else {
            return .zero
        }
    }
}
