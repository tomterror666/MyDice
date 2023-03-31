//
//  Numeric.swift
//  MyDice
//
//  Created by Andre Heß on 26.03.23.
//

import Foundation

extension Numeric {
    var data: Data {
        var bytes = self
        return Data(bytes: &bytes, count: MemoryLayout<Self>.size)
    }
}
