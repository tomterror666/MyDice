//
//  SettingsViewController.swift
//  MyDice
//
//  Created by Andre Heß on 24.03.23.
//

import UIKit
import ImageSlideshow
import GMStepper

let MAX_DICES = 100

enum ColorSelectionMode {
    case dice
    case diceEye
    case diceEyeBorder
}

class SettingsViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    @IBOutlet var numberOfDicesLabel: UILabel?
    @IBOutlet var numberOfDicesValue: UILabel?
    @IBOutlet var numberOfDicesStepper: GMStepper?
    @IBOutlet var selectDiceColorsView: UIView?
    @IBOutlet var selectDiceColorsLabel: UILabel?
    @IBOutlet var selectDiceColorsValueView: UIView?
    @IBOutlet var selectDiceColorsIconLabel: UILabel?
    @IBOutlet var selectDiceEyeColorsView: UIView?
    @IBOutlet var selectDiceEyeColorsLabel: UILabel?
    @IBOutlet var selectDiceEyeColorsValueView: UIView?
    @IBOutlet var selectDiceEyeColorsIconLabel: UILabel?
    @IBOutlet var selectDiceEyeBorderColorsView: UIView?
    @IBOutlet var selectDiceEyeBorderColorsLabel: UILabel?
    @IBOutlet var selectDiceEyeBorderColorsValueView: UIView?
    @IBOutlet var selectDiceEyeBorderColorsIconLabel: UILabel?
    @IBOutlet var selectBackgroundImageView: UIView?
    @IBOutlet var selectBackgroundImageLabel: UILabel?
    @IBOutlet var selectBackgroundImageValueView: UIImageView?
    @IBOutlet var selectBackgroundImageIconLabel: UILabel?
    
    var numberOfDices = 1
    
    public var callingDiceController: DiceViewController?
    public var mode: ColorSelectionMode = .dice

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Settings", comment: "")
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        numberOfDicesLabel?.text = NSLocalizedString("Number of dices:", comment: "")
        numberOfDicesValue?.text = String(numberOfDices)
        
        numberOfDicesStepper?.value = Double(numberOfDices)
        
        selectDiceColorsView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenDiceColorSelection)))
        selectDiceColorsView?.isUserInteractionEnabled = true
        selectDiceColorsLabel?.text = NSLocalizedString("Select dice color", comment: "")
        selectDiceColorsValueView?.backgroundColor = callingDiceController?.diceColor
        selectDiceColorsValueView?.layer.borderColor = UIColor.lightGray.cgColor
        selectDiceColorsValueView?.layer.borderWidth = 1
        selectDiceColorsIconLabel?.text = "\u{27A4}"
        
        selectDiceEyeColorsView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenDiceEyeColorSelection)))
        selectDiceEyeColorsView?.isUserInteractionEnabled = true
        selectDiceEyeColorsLabel?.text = NSLocalizedString("Select dice eye color", comment: "")
        selectDiceEyeColorsValueView?.backgroundColor = callingDiceController?.diceEyeColor
        selectDiceEyeColorsValueView?.layer.borderColor = UIColor.lightGray.cgColor
        selectDiceEyeColorsValueView?.layer.borderWidth = 1
        selectDiceEyeColorsIconLabel?.text = "\u{27A4}"
        
        selectDiceEyeBorderColorsView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenDiceEyeBorderColorSelection)))
        selectDiceEyeBorderColorsView?.isUserInteractionEnabled = true
        selectDiceEyeBorderColorsLabel?.text = NSLocalizedString("Select dice eye border color", comment: "")
        selectDiceEyeBorderColorsValueView?.backgroundColor = callingDiceController?.diceEyeBorderColor
        selectDiceEyeBorderColorsValueView?.layer.borderColor = UIColor.lightGray.cgColor
        selectDiceEyeBorderColorsValueView?.layer.borderWidth = 1
        selectDiceEyeBorderColorsIconLabel?.text = "\u{27A4}"
        
        selectBackgroundImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleOpenBackgroundSelection)))
        selectBackgroundImageView?.isUserInteractionEnabled = true
        selectBackgroundImageLabel?.text = NSLocalizedString("Select background image", comment: "")
        selectBackgroundImageValueView?.image = callingDiceController?.backgroundImage.0
        selectBackgroundImageIconLabel?.text = "\u{27A4}"
    }
    
    @IBAction func stepperValueDidChange(_ sender: GMStepper) {
        numberOfDices = Int(sender.value)
        
        numberOfDicesValue?.text = String(numberOfDices)
        callingDiceController?.addDices(numberOfDices)
    }

    @objc func handleOpenDiceColorSelection(_: AnyObject) {
        mode = .dice
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceView = view
        colorPicker.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        colorPicker.popoverPresentationController?.permittedArrowDirections = []
        present(colorPicker, animated: true, completion: nil);
    }
    
    @objc func handleOpenDiceEyeColorSelection(_: AnyObject) {
        mode = .diceEye
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceView = view
        colorPicker.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        colorPicker.popoverPresentationController?.permittedArrowDirections = []
        present(colorPicker, animated: true, completion: nil);
    }
    
    @objc func handleOpenDiceEyeBorderColorSelection(_: AnyObject) {
        mode = .diceEyeBorder
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.modalPresentationStyle = .popover
        colorPicker.popoverPresentationController?.sourceView = view
        colorPicker.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        colorPicker.popoverPresentationController?.permittedArrowDirections = []
        present(colorPicker, animated: true, completion: nil);
    }
    
    @objc func handleOpenBackgroundSelection(_: AnyObject) {
        let controller = ImageSlideShowViewController(nibName: "ImageSlideShowViewController", bundle: nil)
        callingDiceController?.backgroundImage = (UIImage(named: controller.images[0]), controller.images[0])
        controller.callingViewController = callingDiceController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let selectedColor = viewController.selectedColor

        switch mode {
        case .dice:
            callingDiceController?.diceColor = selectedColor
            selectDiceColorsValueView?.backgroundColor = selectedColor
        case .diceEye:
            callingDiceController?.diceEyeColor = selectedColor
            selectDiceEyeColorsValueView?.backgroundColor = selectedColor
        case .diceEyeBorder:
            callingDiceController?.diceEyeBorderColor = selectedColor
            selectDiceEyeBorderColorsValueView?.backgroundColor = selectedColor
        }
    }
}
