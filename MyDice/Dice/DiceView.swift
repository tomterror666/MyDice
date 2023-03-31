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
    
    private var _value: Int = 0
    public var value: Int {
        get {
            return _value
        }
        set {
            _value = newValue
            
            switch newValue {
            case 1:
                topLeft?.alpha = 0.0
                topRight?.alpha = 0.0
                midLeft?.alpha = 0.0
                midMid?.alpha = 1.0
                midRight?.alpha = 0.0
                bottomLeft?.alpha = 0.0
                bottomRight?.alpha = 0.0
            case 2:
                topLeft?.alpha = 1.0
                topRight?.alpha = 0.0
                midLeft?.alpha = 0.0
                midMid?.alpha = 0.0
                midRight?.alpha = 0.0
                bottomLeft?.alpha = 0.0
                bottomRight?.alpha = 1.0
            case 3:
                topLeft?.alpha = 1.0
                topRight?.alpha = 0.0
                midLeft?.alpha = 0.0
                midMid?.alpha = 1.0
                midRight?.alpha = 0.0
                bottomLeft?.alpha = 0.0
                bottomRight?.alpha = 1.0
            case 4:
                topLeft?.alpha = 1.0
                topRight?.alpha = 1.0
                midLeft?.alpha = 0.0
                midMid?.alpha = 0.0
                midRight?.alpha = 0.0
                bottomLeft?.alpha = 1.0
                bottomRight?.alpha = 1.0
            case 5:
                topLeft?.alpha = 1.0
                topRight?.alpha = 1.0
                midLeft?.alpha = 0.0
                midMid?.alpha = 1.0
                midRight?.alpha = 0.0
                bottomLeft?.alpha = 1.0
                bottomRight?.alpha = 1.0
            case 6:
                topLeft?.alpha = 1.0
                topRight?.alpha = 1.0
                midLeft?.alpha = 1.0
                midMid?.alpha = 0.0
                midRight?.alpha = 1.0
                bottomLeft?.alpha = 1.0
                bottomRight?.alpha = 1.0
            case 7:
                topLeft?.alpha = 1.0
                topRight?.alpha = 1.0
                midLeft?.alpha = 1.0
                midMid?.alpha = 1.0
                midRight?.alpha = 1.0
                bottomLeft?.alpha = 1.0
                bottomRight?.alpha = 1.0
            default:
                topLeft?.alpha = 0.0
                topRight?.alpha = 0.0
                midLeft?.alpha = 0.0
                midMid?.alpha = 0.0
                midRight?.alpha = 0.0
                bottomLeft?.alpha = 0.0
                bottomRight?.alpha = 0.0
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
    
    override func setNeedsUpdateConstraints() {
        let size = bounds.size.width / 5
        let distance = size / 2
        
        topLeftTopConstraint?.constant = distance
        topLeftLeadingConstraint?.constant = distance
        topLeftWidthConstraint?.constant = size
        topLeftHeightConstraint?.constant = size
        topLeft?.layer.cornerRadius = size / 2
        topLeft?.layer.borderColor = UIColor.black.cgColor
        topLeft?.layer.borderWidth = size / 20
        
        topRightTopConstraint?.constant = distance
        topRightTrailingConstraint?.constant = distance
        topRightWidthConstraint?.constant = size
        topRightHeightConstraint?.constant = size
        topRight?.layer.cornerRadius = size / 2
        topRight?.layer.borderColor = UIColor.black.cgColor
        topRight?.layer.borderWidth = size / 20
        
        midLeftTopConstraint?.constant = distance
        midLeftLeadingConstraint?.constant = distance
        midLeftWidthConstraint?.constant = size
        midLeftHeightConstraint?.constant = size
        midLeft?.layer.cornerRadius = size / 2
        midLeft?.layer.borderColor = UIColor.black.cgColor
        midLeft?.layer.borderWidth = size / 20
        
        midMidLeadingConstraint?.constant = distance
        midMidTrailingConstraint?.constant = distance
        midMidWidthConstraint?.constant = size
        midMidHeightConstraint?.constant = size
        midMid?.layer.cornerRadius = size / 2
        midMid?.layer.borderColor = UIColor.black.cgColor
        midMid?.layer.borderWidth = size / 20
        
        midRightTopConstraint?.constant = distance
        midRightTrailingConstraint?.constant = distance
        midRightWidthConstraint?.constant = size
        midRightHeightConstraint?.constant = size
        midRight?.layer.cornerRadius = size / 2
        midRight?.layer.borderColor = UIColor.black.cgColor
        midRight?.layer.borderWidth = size / 20
    
        bottomLeftTopConstraint?.constant = distance
        bottomLeftLeadingConstraint?.constant = distance
        bottomLeftWidthConstraint?.constant = size
        bottomLeftHeightConstraint?.constant = size
        bottomLeft?.layer.cornerRadius = size / 2
        bottomLeft?.layer.borderColor = UIColor.black.cgColor
        bottomLeft?.layer.borderWidth = size / 20
        
        bottomRightTopConstraint?.constant = distance
        bottomRightTrailingConstraint?.constant = distance
        bottomRightWidthConstraint?.constant = size
        bottomRightHeightConstraint?.constant = size
        bottomRight?.layer.cornerRadius = size / 2
        bottomRight?.layer.borderColor = UIColor.black.cgColor
        bottomRight?.layer.borderWidth = size / 20
        
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        super.setNeedsUpdateConstraints()
    }
}
