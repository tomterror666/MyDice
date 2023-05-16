//
//  DiceViewController.swift
//  MyDice
//
//  Created by Andre Heß on 24.03.23.
//

import UIKit

class DiceViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView?
    @IBOutlet var diceButton: UIButton?
    
    private var myDices: [DiceView] = []
    
    private var storage: UserDefaults = .standard
    
    private let diceNumberStorageKey = "diceNumber"
    private let diceColorStorageKey = "diceColor"
    private let diceEyeColorStorageKey = "diceEyeColor"
    private let diceEyeBorderColorStorageKey = "diceEyeBorderColor"
    private let backgroundImageNameStorageKey = "backgroundImageName"
    
    @objc func handleSettings() {
        let settingsController = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        settingsController.callingDiceController = self
        settingsController.numberOfDices = (storage.value(forKey: diceNumberStorageKey) as? NSNumber)?.intValue ?? 1
        
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    @IBAction func startToDice(_ sender: Any?) {
        myDices.forEach { diceView in
            diceView.startToDice(maxDiceTime: randomValue(from: 1, to: 7))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        setupNavigationBar()
        
        diceButton?.setTitle(NSLocalizedString("Dice", comment: ""), for: .normal)
        diceButton?.layer.cornerRadius = 8
        
        if let imageName = storage.string(forKey: backgroundImageNameStorageKey) {
            backgroundImageView?.image = UIImage(named: imageName)
        }
        
        becomeFirstResponder()
    }

    /*func getPiecesRatio(numberOfElements: Int, outerDistance: CGFloat, innerDistance: CGFloat) -> (Int, Int) {
        if numberOfElements == 0 {return (0, 0)}
        if numberOfElements == 1 {return (1, 1)}
            
        let scenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene>
        guard let windows = scenes?.first?.windows,
              let screenSize = windows.first?.screen.currentMode?.size else { return (0, 0) }
        let width = screenSize.width - 2 * outerDistance
        let maxHeight = screenSize.height - 2 * outerDistance
        let endVal = Int(ceil(sqrt(Double(numberOfElements))))
        
        for counter in (1...endVal) {
            let usedElementWidth = (width - CGFloat((counter - 1)) * innerDistance) / CGFloat(counter)
            let resultingHeight = ceil(CGFloat(numberOfElements) / CGFloat(counter)) * usedElementWidth
            
            if resultingHeight < maxHeight {
                return (counter, numberOfElements % counter > 0 ? numberOfElements / counter + 1 : numberOfElements / counter)
            }
        }
        
        return (0, 0)
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if myDices.count == 0 {
            let dicesNumber = (storage.value(forKey: diceNumberStorageKey) as? NSNumber)?.intValue ?? 1
            
            addDices(dicesNumber, value: 3)
        }
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            startToDice(nil)
        }
    }
    
    private func setupNavigationBar() {
        if #available(iOS 15.0, *) {
            navigationController?.setStatusBar(backgroundColor: UIColor(white: 0.9, alpha: 1))
        } else {
            navigationController?.setStatusBar(backgroundColor: UIColor(white: 0.6, alpha: 0.01))
        }
        
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.backgroundColor = UIColor(white: 0.9, alpha: 1)
        } else {
            navigationController?.navigationBar.backgroundColor = UIColor(white: 0.6, alpha: 1)
        }
        
        title = NSLocalizedString("MyDice", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\u{2630}", style: .plain, target: self, action: #selector(handleSettings))
        navigationItem.backButtonTitle = ""
    }
    
    private func randomValue(from: Int, to: Int) -> Double {
        var seed = SystemRandomNumberGenerator()
        return Double(Int.random(in: from...to, using: &seed))
    }
    
    func addDices(_ number: Int, value: Int = 7) {
        storage.setValue(NSNumber(value: number), forKey: diceNumberStorageKey)
        
        let currentDiceColor = myDices.count > 0 ? myDices.first?.backgroundColor : storage.color(forKey: diceColorStorageKey)
        let currentDiceEyeColor = myDices.count > 0 ? myDices.first?.eyeColor : storage.color(forKey: diceEyeColorStorageKey)
        let currentDiceEyeBorderColor = myDices.count > 0 ? myDices.first?.eyeBorderColor : storage.color(forKey: diceEyeBorderColorStorageKey)
        
        let distances = 20.0
        
        let topDistance = UIDevice.current.isIPhoneX() ? 128.0 : 104.0
        let scenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene>
        guard let dicesRatio = scenes?.first?.getPiecesRatio(numberOfElements: number, outerDistance: distances, innerDistance: distances, topDistance: topDistance) else {return}
        let size = dicesRatio.size
        
        view.subviews.forEach { subView in
            if (subView .isKind(of: DiceView.classForCoder())) {
                subView.removeFromSuperview()
            }
            
            myDices = []
        }
        
        for counter in 0...number - 1 {
            let dice = Bundle.main.loadNibNamed("DiceView", owner: nil)?.first as! DiceView
            
            dice.bounds.size = CGSize(width: size, height: size)
            dice.frame.origin = CGPoint(x: distances + Double(counter % dicesRatio.horizontal) * (size + distances), y: topDistance + Double(counter / dicesRatio.horizontal) * (size + distances))
            
            dice.value = value
            dice.backgroundColor = currentDiceColor ?? .white
            dice.eyeColor = currentDiceEyeColor ?? .black
            dice.eyeBorderColor = currentDiceEyeBorderColor ?? .white
            
            view.addSubview(dice)
            
            let leading = NSLayoutConstraint(item: dice, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: dice.frame.origin.x)
            let top = NSLayoutConstraint(item: dice, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: dice.frame.origin.y)
            let height = NSLayoutConstraint(item: dice, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size)
            let width = NSLayoutConstraint(item: dice, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size)
            dice.addConstraints([width, height])
            view.addConstraints([leading, top])
            
            dice.setNeedsUpdateConstraints()
            
            myDices.append(dice)
        }
    }
    
    var diceColor: UIColor {
        get {
            return myDices.first?.backgroundColor ?? .black
        }
        set {
            myDices.forEach { diceView in
                diceView.backgroundColor = newValue
            }
            
            storage.set(newValue, forKey: diceColorStorageKey)
        }
    }
    
    var diceEyeColor: UIColor {
        get {
            return myDices.first?.eyeColor ?? .black
        }
        set {
            myDices.forEach { diceView in
                diceView.eyeColor = newValue
            }
            
            storage.set(newValue, forKey: diceEyeColorStorageKey)
        }
    }
    
    var diceEyeBorderColor: UIColor {
        get {
            return myDices.first?.eyeBorderColor ?? .black
        }
        set {
            myDices.forEach { diceView in
                diceView.eyeBorderColor = newValue
            }
            
            storage.set(newValue, forKey: diceEyeBorderColorStorageKey)
        }
    }
    
    var backgroundImage: (UIImage?, String?) {
        get {
            return (backgroundImageView?.image, storage.string(forKey: backgroundImageNameStorageKey))
        }
        set {
            backgroundImageView?.image = newValue.0
            
            storage.setValue(newValue.1, forKey: backgroundImageNameStorageKey)
        }
    }
}
