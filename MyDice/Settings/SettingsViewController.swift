//
//  SettingsViewController.swift
//  MyDice
//
//  Created by Andre Heß on 24.03.23.
//

import UIKit
import ImageSlideshow

class SettingsViewController: UIViewController {
    
    @IBOutlet var numberOfDicesLabel: UILabel?
    @IBOutlet var numberOfDicesValue: UILabel?
    @IBOutlet var numberOfDicesUpButton: UIButton?
    @IBOutlet var numberOfDicesDownButton: UIButton?
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Settings", comment: "")
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        numberOfDicesLabel?.text = NSLocalizedString("Number of dices:", comment: "")
        numberOfDicesValue?.text = String(numberOfDices)
        
        numberOfDicesUpButton?.setTitle("\u{25B2}", for: .normal)
        numberOfDicesUpButton?.layer.borderColor = UIColor.gray.cgColor
        numberOfDicesUpButton?.layer.borderWidth = 1
        numberOfDicesUpButton?.backgroundColor = .lightGray
        numberOfDicesUpButton?.setTitleColor(.white, for: .normal)
        numberOfDicesUpButton?.setTitleColor(.lightText, for: .highlighted)
        
        numberOfDicesDownButton?.setTitle("\u{25BC}", for: .normal)
        numberOfDicesDownButton?.layer.borderColor = UIColor.gray.cgColor
        numberOfDicesDownButton?.layer.borderWidth = 1
        numberOfDicesDownButton?.backgroundColor = .lightGray
        numberOfDicesDownButton?.setTitleColor(.white, for: .normal)
        numberOfDicesDownButton?.setTitleColor(.lightText, for: .highlighted)
        
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
    
    @IBAction func incNumberOfDices() {
        if numberOfDices < 6 {
            numberOfDices += 1
            numberOfDicesValue?.text = String(numberOfDices)
            
            callingDiceController?.addDices(numberOfDices)
        }
    }
    
    @IBAction func decNumberOfDices() {
        if numberOfDices > 1 {
            numberOfDices -= 1
            numberOfDicesValue?.text = String(numberOfDices)
            
            callingDiceController?.addDices(numberOfDices)
        }
    }

    @objc func handleOpenDiceColorSelection(_: AnyObject) {
        let controller = ColorSelectionViewController(nibName: "ColorSelectionViewController", bundle: nil)
        controller.mode = .dice
        controller.initColorValue = callingDiceController?.diceColor ?? .white
        controller.callingDiceController = callingDiceController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleOpenDiceEyeColorSelection(_: AnyObject) {
        let controller = ColorSelectionViewController(nibName: "ColorSelectionViewController", bundle: nil)
        controller.mode = .diceEye
        controller.initColorValue = callingDiceController?.diceEyeColor ?? .black
        controller.callingDiceController = callingDiceController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleOpenDiceEyeBorderColorSelection(_: AnyObject) {
        let controller = ColorSelectionViewController(nibName: "ColorSelectionViewController", bundle: nil)
        controller.mode = .diceEyeBorder
        controller.initColorValue = callingDiceController?.diceEyeBorderColor ?? .white
        controller.callingDiceController = callingDiceController
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleOpenBackgroundSelection(_: AnyObject) {
        let controller = ImageSlideShowViewController(nibName: "ImageSlideShowViewController", bundle: nil)
        callingDiceController?.backgroundImage = (UIImage(named: controller.images[0]), controller.images[0])
        controller.callingViewController = callingDiceController
        navigationController?.pushViewController(controller, animated: true)
    }
}
