//
//  UserDefaults.swift
//  MyDice
//
//  Created by Andre Heß on 26.03.23.
//

import Foundation
import UIKit

extension UserDefaults {
    func set(_ color: UIColor?, forKey defaultName: String) {
        guard let data = color?.data else {
            removeObject(forKey: defaultName)
            return
        }
        set(data, forKey: defaultName)
    }
    func color(forKey defaultName: String) -> UIColor? {
        data(forKey: defaultName)?.color
    }
}
