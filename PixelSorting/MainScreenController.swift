//
//  ViewController.swift
//  PixelSorting
//
//  Created by Christian Flanders on 7/22/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class MainScreenController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var importedImage: UIImage?
    var originalImage: UIImage?
    var pixelData = [PixelData]()
    var width = CGFloat()
    var height = CGFloat()
    let effectSelections = ["Effect 1", "Effect 2", "Effect 3", "Effect 4", "Effect 5", "Effect 6", "Effect 7", "Effect 8", "Effect 9", "Effect 10", "Effect 11", "Effect 12", "Effect 13", "Effect 14"]
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoaded(importedImage!)
        originalImage = importedImage
        stopActivity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Sort1Button: UIButton!
    @IBOutlet weak var Sort2Button: UIButton!
    @IBOutlet weak var Sort3Button: UIButton!
    @IBOutlet weak var ProgressView: UIProgressView!
    
    func imageLoaded(_ input : UIImage?) {
                print("original image width is", input?.size.width)
                print("original image height is", input?.size.height)
                if let imageLoaded = input {
                    let resized = checkSizeAndResizeImage(input!)
                    ImageView.image = resized
                    width = resized.size.width
                    height = resized.size.height
                    print("resized width is", width)
                    print("resized height is ", height)
                    ImageView.image = resized
                    
                } else {
                    print("error!")
                }
    }
    
    @IBAction func SaveToLibrary(_ sender: UIButton) {
        let imageData = UIImagePNGRepresentation(ImageView.image!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)

    }


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return effectSelections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = effectSelections[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAndDoEffect(effectSelections[indexPath.row])
        
    }
    
    func selectAndDoEffect(_ label :String){
        switch label {
        case "Effect 1":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: arSort)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 2":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: gbSort)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 3":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: randomSort)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 4":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: sortByAlphaChanges)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
            //slow
        case "Effect 5":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: duplicatePixels)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
            //slow
        case "Effect 6":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: copyAndDivide)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 7":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: insertPixels)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 8":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: rgbaSort)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 9":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: rgbaSortMaybe)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 10":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: sortByRedChanges)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
        case "Effect 11":
            startActivity()
            DispatchQueue.global().async {
                let effectedImage = self.importedImage?.effectTemplate(effect: sortByGreenChanges)
                DispatchQueue.main.async {
                    self.ImageView.image = effectedImage
                    self.stopActivity()
                }
            }
            
        default:
            print("Well this shouldn't have happened")
        }
    }


    @IBAction func ResetEffects(_ sender: UIButton) {
        ImageView.image = originalImage
        imageLoaded(originalImage)
    }
    func startActivity(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopActivity(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func checkSizeAndResizeImage(_ input : UIImage) -> UIImage{
        let verticalResizer: CGFloat = 1334
        let horizontalResizer: CGFloat = 750
        var resizedReturnImage: UIImage
        let inputWidth = input.size.width
        let inputHeight = input.size.height
        //Vertical image
        if inputHeight > inputWidth {
            resizedReturnImage = input.resized(toWidth: verticalResizer)!
        } else { //Horizontal Image
            resizedReturnImage = input.resized(toWidth: horizontalResizer)!
        }
        return resizedReturnImage
    }
    
    
    
}

