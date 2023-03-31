//
//  ColorSelectionViewController.swift
//  MyDice
//
//  Created by Andre Heß on 25.03.23.
//

import UIKit
import Colorful

enum ColorSelectionMode: String {
    case dice = "Dice"
    case diceEye = "DiceEye"
    case diceEyeBorder = "DiceEyeBorder"
}

class ColorSelectionViewController: UIViewController {
    
    public var callingDiceController: DiceViewController?
    
    public var mode: ColorSelectionMode = .dice
    
    public var initColorValue: UIColor = .black

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch mode {
        case .dice:
            title = NSLocalizedString("Dice Color", comment: "")
        case .diceEye:
            title = NSLocalizedString("Dice Eye Color", comment: "")
        case .diceEyeBorder:
            title = NSLocalizedString("Dice Eye Border Color", comment: "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorPicker: ColorPicker = ColorPicker(frame: view.bounds, primaryAction: UIAction(title: "", handler: { action in
        }))
        colorPicker.addTarget(self, action: #selector(handleColorChanged), for: .valueChanged)
        colorPicker.set(color: initColorValue, colorSpace: .extendedSRGB)
        view.addSubview(colorPicker)
    }

    @objc func handleColorChanged(picker: ColorPicker) {
        switch mode {
        case .dice:
            callingDiceController?.diceColor = picker.color
        case .diceEye:
            callingDiceController?.diceEyeColor = picker.color
        case .diceEyeBorder:
            callingDiceController?.diceEyeBorderColor = picker.color
        }
    }
}
