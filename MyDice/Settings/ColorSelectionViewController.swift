//
//  ColorSelectionViewController.swift
//  MyDice
//
//  Created by Andre Heß on 25.03.23.
//
import UIKit

enum ColorSelectionMode: String {
    case dice = "Dice"
    case diceEye = "DiceEye"
    case diceEyeBorder = "DiceEyeBorder"
}

class ColorSelectionViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    public var mode: ColorSelectionMode = .dice
    public var initColorValue: UIColor = .black
    public var callingDiceController: DiceViewController?
    
    
    @IBOutlet weak var colorView: UIView?
    @IBOutlet weak var graySwitch: UISwitch?
    
    var selectedColor: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceView = view
        colorPicker.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        colorPicker.popoverPresentationController?.permittedArrowDirections = []
        present(colorPicker, animated: true, completion: nil);
    }
    
    @IBAction func cooseColorButtonTouched(_ sender: UIButton) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true, completion: nil);
    }
    
    @IBAction func graySwitchValueChanged(_ sender: UIButton) {
        updateColorView();
    }
    
    func updateColorView() {
        /*if let graySwitch = graySwitch, graySwitch.isOn {
            let grayColors = UIColor.grayColorArray(count: 100, step: 0.01)
            selectedColor = grayColors.first ?? .white
            colorView?.backgroundColor = selectedColor
        } else {print("Selected color: \(selectedColor)")*/
            colorView?.backgroundColor = selectedColor
        //}
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        selectedColor = viewController.selectedColor
        updateColorView()
    }
}
/*
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
*/
