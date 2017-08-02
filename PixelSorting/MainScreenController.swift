//
//  ViewController.swift
//  PixelSorting
//
//  Created by Christian Flanders on 7/22/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class MainScreenController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var image: UIImage?
    var originalImage: UIImage?
    var pixelData = [PixelData]()
    var width = CGFloat()
    var height = CGFloat()
    let activityIndicator = UIActivityIndicatorView()
    let effectsArray = ["Effect 1", "Effect 2", "Effect 3", "Effect 4", "Effect 5", "Effect 6", "Effect 7", "Effect 8", "Effect 9", "Effect 10", "Effect 11", "Effect 12", "Effect 13", "Effect 14"]
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoaded(image!)
        originalImage = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Sort1Button: UIButton!
    @IBOutlet weak var Sort2Button: UIButton!
    @IBOutlet weak var Sort3Button: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var ProgressView: UIProgressView!
    
    func imageLoaded(_ input : UIImage?) {
                if let imageLoaded = input {
                    ImageView.image = imageLoaded
                    width = imageLoaded.size.width
                    height = imageLoaded.size.height
                    print(width)
                    print(height)
                    ImageView.image = imageLoaded
        
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
        return effectsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = effectsArray[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectAndDoEffect(effectsArray[indexPath.row])
        
    }
    

    func selectAndDoEffect(_ label :String){
        switch label {
        case "Effect 1":
            let effectedImage = image?.effectTemplate(effect: arSort)
            ImageView.image = effectedImage
        case "Effect 2":
            let effectedImage = image?.effectTemplate(effect: gbSort)
            ImageView.image = effectedImage
        case "Effect 3":
            let effectedImage = image?.effectTemplate(effect: randomSort)
            ImageView.image = effectedImage
        case "Effect 4":
            let effectedImage = image?.effectTemplate(effect: sortByAlphaChanges)
            ImageView.image = effectedImage
        case "Effect 5":
            let effectedImage = image?.effectTemplate(effect: duplicatePixels)
            ImageView.image = effectedImage
        case "Effect 6":
            let effectedImage = image?.effectTemplate(effect: copyAndDivide)
            ImageView.image = effectedImage
        case "Effect 7":
            let effectedImage = image?.effectTemplate(effect: insertPixels)
            ImageView.image = effectedImage
        case "Effect 8":
            let effectedImage = image?.effectTemplate(effect: rgbaSort)
            ImageView.image = effectedImage
        case "Effect 9":
            let effectedImage = image?.effectTemplate(effect: rgbaSortMaybe)
            ImageView.image = effectedImage
        case "Effect 10":
            let effectedImage = image?.effectTemplate(effect: sortByRedChanges)
            ImageView.image = effectedImage
        case "Effect 11":
            let effectedImage = image?.effectTemplate(effect: sortByGreenChanges)
            ImageView.image = effectedImage
        
        default:
            print("Well this shouldn't have happened")
        }
   }


    @IBAction func ResetEffects(_ sender: UIButton) {
        ImageView.image = originalImage
        imageLoaded(originalImage)
    }
}

