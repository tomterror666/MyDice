//
//  Data.swift
//  MyDice
//
//  Created by Andre Heß on 26.03.23.
//

import Foundation
import UIKit

extension Data {
    func object<T>() -> T { withUnsafeBytes{$0.load(as: T.self)} }
    var color: UIColor { .init(data: self) }
}
