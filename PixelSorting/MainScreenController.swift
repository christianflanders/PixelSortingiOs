//
//  ViewController.swift
//  PixelSorting
//
//  Created by Christian Flanders on 7/22/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class MainScreenController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    //MARK: Constants
    
    
    
    //MARK: VARIABLES
    
    @IBOutlet weak var effectView: UICollectionView!
    
    //MARK: OUTLETS
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Sort1Button: UIButton!
    @IBOutlet weak var Sort2Button: UIButton!
    @IBOutlet weak var Sort3Button: UIButton!
    @IBOutlet weak var ProgressView: UIProgressView!
    //MARK: Weak Vars
    
    //MARK: Public Variables
    public var importedImage: UIImage?
    
    //MARK: Private Variables
    fileprivate var originalImage: UIImage?
    fileprivate var pixelData = [PixelData]()
    fileprivate var width = CGFloat()
    fileprivate var height = CGFloat()
    fileprivate let effectSelections = [ "Xtal", "Blue Calx", "Nanou2", "Flim", "Pulsewidth", "Polynominal C", "diskhat2", "Yellow Calx", "minipops", "aisatsana", "WindowLicker", "Tha"]
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if importedImage != nil {
        imageLoaded(importedImage)
        originalImage = importedImage
        stopActivity()
        } else {
            //display "No Picture selected!" error
        }
    }

    //MARK: IBActions
    @IBAction func SaveToLibrary(_ sender: UIButton) {
        if ImageView.image != nil {
        let imageData = UIImagePNGRepresentation(ImageView.image!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        } else {
            print("There appears to be no image")
        }
    }
    
    @IBAction func ResetEffects(_ sender: UIButton) {
        ImageView.image = originalImage
        imageLoaded(originalImage)
    }
    //MARK: Instance Methods

    func imageLoaded(_ input : UIImage?) {
                if input != nil {
                    let resized = checkSizeAndResizeImage(input!)
                    ImageView.image = resized
                    width = (resized.size.width)
                    height = (resized.size.height)
                    print("resized width is", width)
                    print("resized height is ", height)
                    ImageView.image = resized
                    
                } else {
                    print("error!")
                    //Show "Something went wrong, please select another image"
                }
    }
    
    func startActivity(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopActivity(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}


// Mark: UICollectionViewDataSourceAndDelegate

extension MainScreenController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return effectSelections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = effectSelections[indexPath.row]
        cell.filterImage.image = UIImage(named: effectSelections[indexPath.row])
        cell.filterImage.layer.cornerRadius = cell.filterImage.frame.size.width / 2
        cell.filterImage.clipsToBounds = true
        cell.filterImage.layer.borderWidth = 3.0
        cell.filterImage.layer.borderColor = UIColor.lightGray.cgColor
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAndPerformEffect(effectSelections[indexPath.row])
        if let cell = effectView.cellForItem(at: indexPath) as! CollectionViewCell? {
        cell.filterImage.layer.borderColor = UIColor.blue.cgColor
        }

    }
    
  
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = effectView.cellForItem(at: indexPath) as! CollectionViewCell? {
        cell.filterImage.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func selectAndPerformEffect(_ label :String){
        switch label {
        case "Tha":
            let start = Date()
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: arSort)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    print("Elapsed time: \(start.timeIntervalSinceNow) seconds")
                    self.stopActivity()
                }
            }
            
        case "Xtal":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: xtal)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Blue Calx":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: blueCalx)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Nanou2":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: nanou2)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        //slow
        case "Flim":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: someEffect)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        //slow
        case "Pulsewidth":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: copyAndDivide)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Polynominal C":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: insertPixels)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "diskhat2":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: rgbaSort)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Yellow Calx":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: rgbaSortMaybe)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        //doesnt seem to do anything
        case "Jynweythek":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: bigBlocks)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "minipops":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: sortByGreenChanges)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "WindowLicker":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplateIncludingWidth(effect: windowLicker)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        //TODO: Add Size Slider
        case "aisatsana":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: blocks)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }

        default:
            print("Well this shouldn't have happened")
        }
    }
    
    
    
    
    
}
