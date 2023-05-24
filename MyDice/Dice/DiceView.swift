//
//  DiceView.swift
//  MyDice
//
//  Created by Andre Heß on 24.03.23.
//

import UIKit

class DiceView: UIView {
    
    @IBOutlet var topLeft: UIView?
    @IBOutlet var topRight: UIView?
    @IBOutlet var midLeft: UIView?
    @IBOutlet var midMid: UIView?
    @IBOutlet var midRight: UIView?
    @IBOutlet var bottomLeft: UIView?
    @IBOutlet var bottomRight: UIView?
    
    private var allEyes: NSMutableArray?
    private var allDistanceConstraints: NSMutableArray = []
    private var allSizeConstraints: NSMutableArray = []
    
    @IBOutlet var topLeftTopConstraint: NSLayoutConstraint?
    @IBOutlet var topLeftLeadingConstraint: NSLayoutConstraint?
    @IBOutlet var topLeftWidthConstraint: NSLayoutConstraint?
    @IBOutlet var topLeftHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet var topRightTopConstraint: NSLayoutConstraint?
    @IBOutlet var topRightTrailingConstraint: NSLayoutConstraint?
    @IBOutlet var topRightWidthConstraint: NSLayoutConstraint?
    @IBOutlet var topRightHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet var midLeftTopConstraint: NSLayoutConstraint?
    @IBOutlet var midLeftLeadingConstraint: NSLayoutConstraint?
    @IBOutlet var midLeftWidthConstraint: NSLayoutConstraint?
    @IBOutlet var midLeftHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet var midMidLeadingConstraint: NSLayoutConstraint?
    @IBOutlet var midMidTrailingConstraint: NSLayoutConstraint?
    @IBOutlet var midMidEqualTopConstraint: NSLayoutConstraint?
    @IBOutlet var midMidWidthConstraint: NSLayoutConstraint?
    @IBOutlet var midMidHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet var midRightTopConstraint: NSLayoutConstraint?
    @IBOutlet var midRightTrailingConstraint: NSLayoutConstraint?
    @IBOutlet var midRightWidthConstraint: NSLayoutConstraint?
    @IBOutlet var midRightHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet var bottomLeftTopConstraint: NSLayoutConstraint?
    @IBOutlet var bottomLeftLeadingConstraint: NSLayoutConstraint?
    @IBOutlet var bottomLeftWidthConstraint: NSLayoutConstraint?
    @IBOutlet var bottomLeftHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet var bottomRightTopConstraint: NSLayoutConstraint?
    @IBOutlet var bottomRightTrailingConstraint: NSLayoutConstraint?
    @IBOutlet var bottomRightWidthConstraint: NSLayoutConstraint?
    @IBOutlet var bottomRightHeightConstraint: NSLayoutConstraint?
    
    private func intToActiveEyes(value: Int) -> NSMutableArray {
        if let tl = topLeft, let tr = topRight, let ml = midLeft, let mm = midMid, let mr = midRight, let bl = bottomLeft, let br = bottomRight {
            switch value {
            case 0:
                return []
            case 1:
                return [mm]
            case 2:
                return [tl, br]
            case 3:
                return [tl, mm, br]
            case 4:
                return [tl, tr, bl, br]
            case 5:
                return [tl, tr, mm, bl, br]
            case 6:
                return [tl, tr, ml, mr, bl, br]
            default:
                return [tl, tr, ml, mm, mr, bl, br]
            }
        }
        
        return []
    }
    
    private var _value: Int = 0
    public var value: Int {
        get {
            return _value
        }
        set {
            _value = newValue

            allEyes?.forEach({ eyeView in
                (eyeView as! UIView).alpha = 0
            })
            
            intToActiveEyes(value: newValue).forEach { eyeView in
                (eyeView as! UIView).alpha = 1
            }
        }
    }
    
    private var _eyeColor: UIColor = .black
    public var eyeColor: UIColor {
        get {
            return _eyeColor
        }
        set {
            _eyeColor = newValue
            
            topLeft?.backgroundColor = newValue
            topRight?.backgroundColor = newValue
            midLeft?.backgroundColor = newValue
            midMid?.backgroundColor = newValue
            midRight?.backgroundColor = newValue
            bottomLeft?.backgroundColor = newValue
            bottomRight?.backgroundColor = newValue
        }
    }
    
    private var _eyeBorderColor: UIColor = .black
    public var eyeBorderColor: UIColor {
        get {
            return _eyeBorderColor
        }
        set {
            _eyeBorderColor = newValue
            
            topLeft?.layer.borderColor = newValue.cgColor
            topRight?.layer.borderColor = newValue.cgColor
            midLeft?.layer.borderColor = newValue.cgColor
            midMid?.layer.borderColor = newValue.cgColor
            midRight?.layer.borderColor = newValue.cgColor
            bottomLeft?.layer.borderColor = newValue.cgColor
            bottomRight?.layer.borderColor = newValue.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        allEyes = [topLeft!, topRight!, midLeft!, midMid!, midRight!, bottomLeft!, bottomRight!]
        allDistanceConstraints = [topLeftTopConstraint!, topLeftLeadingConstraint!, topRightTopConstraint!, topRightTrailingConstraint!, midLeftTopConstraint!, midLeftLeadingConstraint!, midMidLeadingConstraint!, midMidTrailingConstraint!, midRightTopConstraint!, midRightTrailingConstraint!, bottomLeftTopConstraint!, bottomLeftLeadingConstraint!, bottomRightTopConstraint!, bottomRightTrailingConstraint!]
        allSizeConstraints = [topLeftWidthConstraint!, topLeftHeightConstraint!, topRightWidthConstraint!, topRightHeightConstraint!, midLeftWidthConstraint!, midLeftHeightConstraint!, midMidWidthConstraint!, midMidHeightConstraint!, midRightWidthConstraint!, midRightHeightConstraint!, bottomLeftWidthConstraint!, bottomLeftHeightConstraint!, bottomRightWidthConstraint!, bottomRightHeightConstraint!]
    }
    
    override func setNeedsUpdateConstraints() {
        let size = bounds.size.width / 5
        let distance = size / 2
        
        allEyes?.forEach({ eyeView in
            (eyeView as! UIView).layer.cornerRadius = size / 2
            (eyeView as! UIView).layer.borderWidth = size / 20
        })
        
        allDistanceConstraints.forEach { constraint in
            (constraint as! NSLayoutConstraint).constant = distance
        }
        allSizeConstraints.forEach { constraint in
            (constraint as! NSLayoutConstraint).constant = size
        }
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        super.setNeedsUpdateConstraints()
    }
    
    func startToDice(maxDiceTime: Double) {
        let currentBackgroundColor = backgroundColor
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        DispatchQueue.global(qos: .background).async {
            var diceTime = 0.0
            var waitTime: UInt32 = 10000
            
            while diceTime < maxDiceTime {
                DispatchQueue.main.async {
                    self.value = self.randomValue()
                }
                
                diceTime += Double(waitTime) / 1000000
                usleep(waitTime)
                waitTime = UInt32(powl(Float80(Double(waitTime)), 1.01))
            }
            
            DispatchQueue.main.async {
                self.backgroundColor = currentBackgroundColor
            }
        }
    }
    
    private func randomValue() -> Int {
        var seed = SystemRandomNumberGenerator()
        return Int.random(in: 1...6, using: &seed)
    }
}
