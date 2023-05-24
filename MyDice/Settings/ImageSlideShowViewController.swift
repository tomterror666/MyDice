//
//  ImageSlideShowViewController.swift
//  MyDice
//
//  Created by Andre Heß on 28.03.23.
//

import UIKit
import ImageSlideshow

class ImageSlideShowViewController: UIViewController, ImageSlideshowDelegate {

    @IBOutlet var slideShow: ImageSlideshow?
    @IBOutlet var selectedImageNameLabel: UILabel?
    @IBOutlet var cleanupButton: UIButton?
    
    var callingViewController: DiceViewController?
    
    var images: [String] = [
        "aluminium",
        "beach_full",
        "beach_half",
        "concrete_coarse",
        "concrete_fine",
        "glas",
        "gold",
        "ice",
        "marble",
        "moon",
        "sand",
        "water",
        "wood"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageSource: [BundleImageSource] = []
        images.forEach { name in
            imageSource.append(BundleImageSource(imageString: name))
        }
        
        slideShow?.setImageInputs(imageSource)
        slideShow?.delegate = self
        slideShow?.backgroundColor = UIColor(white: 0.9, alpha: 1)
        slideShow?.pageIndicatorPosition = PageIndicatorPosition(vertical: .under)
        slideShow?.contentScaleMode = .scaleAspectFill
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("MyPhotos", comment: ""), style: .plain, target: self, action: #selector(selectOwnImage))
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = NSLocalizedString("Background Image", comment: "")
        
        cleanupButton?.setTitle(NSLocalizedString("Cleanup", comment: ""), for: .normal)
        
        selectedImageNameLabel?.text = NSLocalizedString("Chosen: ", comment: "") + NSLocalizedString(images.first ?? "", comment: "")
    }
    
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        selectedImageNameLabel?.text = NSLocalizedString("Chosen: ", comment: "") + NSLocalizedString(images[page], comment: "")
        
        callingViewController?.backgroundImage = (UIImage(named: images[page]), images[page])
    }
    
    @IBAction func cleanup(_ sender: Any) {
        callingViewController?.backgroundImage = (nil, nil)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func selectOwnImage(_ sender: Any) {
        let photoSelector = PhotoSelectionViewController(nibName: "PhotoSelectionViewController", bundle: nil)
        
        photoSelector.callingViewController = callingViewController
        
        if var currentVCs = navigationController?.viewControllers {
            currentVCs.removeLast()
            currentVCs.append(photoSelector)
            navigationController?.setViewControllers(currentVCs, animated: true)
        }
    }
}
