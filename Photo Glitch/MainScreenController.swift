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
    //Each effect avaliable
    fileprivate let effectSelections = ["WindowLicker",  "Blue Calx", "Nanou2", "Flim", "Pulsewidth", "Polynominal C", "diskhat2", "Yellow Calx", "aisatsana","Xtal" , "Tha"]

    
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
    //Image our user has added
    
    public var importedImage: UIImage?
    
    //MARK: Private Variables
    
    fileprivate var originalImage: UIImage?
    //Empty array of pixel data that we will later fill to manipulate with effects
    
    fileprivate var pixelData = [PixelData]()
    fileprivate var width = CGFloat()
    fileprivate var height = CGFloat()

    fileprivate var resized: UIImage?
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //if there is an image loaded, start our initial processing.
        if importedImage != nil {
            processImageLoaded(importedImage)
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
    

    //MARK: Instance Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Preparation to go back to the initial import screen, and stores our image in case the user decides to cancel and return.
        if segue.identifier == "BackToImport"{
            let segueDestination = segue.destination as! OpeningScreenViewController
            var isThereAnImage:Bool
            if importedImage != nil {
                isThereAnImage = true

            } else {
                isThereAnImage = false
            }
            segueDestination.doesContainPicture = isThereAnImage
            segueDestination.imageSentBack = importedImage!
        }
    }
    //Resizes the loaded image, for easier processing.
    func processImageLoaded(_ input : UIImage?) {
                if input != nil {
                     resized = checkSizeAndResizeImage(input!)
                    ImageView.image = resized
                    width = (resized?.size.width)!
                    height = (resized?.size.height)!
                    print("resized width is", width)
                    print("resized height is ", height)
                    ImageView.image = resized
                    
                } else {
                    print("error!")
                    //Show "Something went wrong, please select another image"
                }
    }
    //Starts the activity indicator when processing
    func startActivity(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    //Stops the activity indicator when done processing
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
    //Gets the cell for each effect
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
    //When the user pressed the effects "button" performs the selected effect
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAndPerformEffect(effectSelections[indexPath.row], imageForEffects: resized!)
        if let cell = effectView.cellForItem(at: indexPath) as! CollectionViewCell? {
        cell.filterImage.layer.borderColor = UIColor.blue.cgColor
        }

    }
    
    //Turns off the blue ring if the user selects a different effect
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = effectView.cellForItem(at: indexPath) as! CollectionViewCell? {
        cell.filterImage.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    //Main function to tell which effect has been selected and perform the processing asyncronously.
    fileprivate func processImageWithEffect(_ imageForEffects: UIImage, effectName: @escaping ([PixelData]) -> [PixelData]) {
        startActivity()
        DispatchQueue.global().async {
            let effectedImage = imageForEffects.effectTemplate(effect: effectName)
            DispatchQueue.main.async {
                self.ImageView.image = effectedImage
                self.stopActivity()
            }
        }
    }
    
    func selectAndPerformEffect(_ label :String, imageForEffects:UIImage){
        switch label {
        case "Tha":
            processImageWithEffect(imageForEffects,effectName: arSort)
    
        case "Xtal":
            processImageWithEffect(imageForEffects,effectName: xtal)

        case "Blue Calx":
            processImageWithEffect(imageForEffects,effectName: blueCalx)

        case "Nanou2":
            processImageWithEffect(imageForEffects,effectName: nanou2)

        case "Flim":
            processImageWithEffect(imageForEffects,effectName: someEffect)

        case "Pulsewidth":
            processImageWithEffect(imageForEffects,effectName: copyAndDivide)

        case "Polynominal C":
            processImageWithEffect(imageForEffects,effectName: insertPixels)
        case "diskhat2":
            processImageWithEffect(imageForEffects,effectName: rgbaSort)

        case "Yellow Calx":
            processImageWithEffect(imageForEffects,effectName: rgbaSortMaybe)

        case "Jynweythek":
            processImageWithEffect(imageForEffects,effectName: bigBlocks)

        case "minipops":
            processImageWithEffect(imageForEffects,effectName: sortByGreenChanges)
        //This effect needs an extra parameter so we cant use the processImageWithEffects function
            
        case "WindowLicker":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplateIncludingWidth(effect: windowLicker)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "aisatsana":
            processImageWithEffect(imageForEffects,effectName: blocks)
        default:
            print("Well this shouldn't have happened")
        }
    }
    
    
    
    
    
}
