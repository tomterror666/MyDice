//
//  PhotoSelectionViewController.swift
//  MyDice
//
//  Created by Andre Heß on 24.05.23.
//

import UIKit
import Photos
import ImageSlideshow

class PhotoSelectionViewController: UIViewController, ImageSlideshowDelegate {
    
    var photos: [(UIImage, String)] = []
    var callingViewController: DiceViewController?
    
    @IBOutlet var slideShow: ImageSlideshow?
    
    @IBOutlet var cleanupButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("MyPhotos", comment: "")
        cleanupButton?.setTitle(NSLocalizedString("Cleanup", comment: ""), for: .normal)
        
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized, .limited:
                self.fetchPhotosFromLibrary()
                
                DispatchQueue.main.async {
                    var imageSource: [ImageSource] = []
                    self.photos.forEach { photo in
                        imageSource.append(ImageSource(image: photo.0))
                    }
                    
                    self.slideShow?.setImageInputs(imageSource)
                    self.slideShow?.delegate = self
                    self.slideShow?.backgroundColor = UIColor(white: 0.9, alpha: 1)
                    self.slideShow?.pageIndicatorPosition = PageIndicatorPosition(vertical: .under)
                    self.slideShow?.contentScaleMode = .scaleAspectFill
                }
            case .denied, .restricted, .notDetermined:
                self.showError("denied!!")
            @unknown default:
                self.showError("unknown Error!!")
            }
        }
    }
    
    @objc private func fetchPhotosFromLibrary() {
        if !Thread.isMainThread {
            performSelector(onMainThread: #selector(fetchPhotosFromLibrary), with: nil, waitUntilDone: true)
            
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)] // Sort by creation date, newest first
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        let scenes = UIApplication.shared.connectedScenes as? Set<UIWindowScene>
        guard let screenSize = scenes?.first?.currentScreenSize() else { return }
        
        // Process the fetched assets
        fetchResult.enumerateObjects { asset, _, _ in
            let imageManager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            
            imageManager.requestImage(for: asset, targetSize: screenSize, contentMode: .aspectFit, options: requestOptions) { image, _ in
                if let image = image {
                    self.photos.append((image, asset.localIdentifier))
                }
            }
        }
    }

    
    private func showError(_ error: String) {
        
    }
    
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("selected \(photos[page])")
        callingViewController?.backgroundImage = photos[page]
    }

    @IBAction func cleanup(_ sender: Any) {
        callingViewController?.backgroundImage = (nil, nil)
        
        navigationController?.popViewController(animated: true)
    }
}
