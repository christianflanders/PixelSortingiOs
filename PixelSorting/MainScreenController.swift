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
    var pixelData = [PixelData]()
    var width = CGFloat()
    var height = CGFloat()
    let activityIndicator = UIActivityIndicatorView()
    let effectsArray = ["Effect 1", "Effect 2", "Effect 3", "Effect 4", "Effect 5", "Effect 6", "Effect 7", "Effect 8", "Effect 9", "Effect 10", "Effect 11", "Effect 12", "Effect 13", "Effect 14"]
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoaded()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Sort1Button: UIButton!
    @IBOutlet weak var Sort2Button: UIButton!
    @IBOutlet weak var Sort3Button: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var ProgressView: UIProgressView!
    
//    @IBAction func SelectFromLibrary(_ sender: UIBarButtonItem) {
//        let image = UIImagePickerController()
//        image.delegate = self
//        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
//        image.allowsEditing = false
//        self.present(image, animated: true)
//        {
//            //adfadsasd
//        }
//        
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

//        
//        self.dismiss(animated: true, completion: nil)
//    }
    func imageLoaded() {
                if let imageLoaded = image {
                    ImageView.image = imageLoaded
                    pixelData = imageInitialProcessing(imageLoaded)
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
            let sortedTest1 = pixelData.sorted{ $0.a < $1.r}
            let sortedImage = imageFromBitmap(pixels: sortedTest1, width: Int(width), height: Int(height))
            ImageView.image = sortedImage
        case "Effect 2":
            let sortedTest2 = pixelData.sorted{ $0.g < $1.b}
            let sortedImage2 = imageFromBitmap(pixels: sortedTest2, width: Int(width), height: Int(height))
            ImageView.image = sortedImage2
        case "Effect 3":
            let sortedTest3 = rgbaSortMaybe(pixelData)
            let sortedImage3 = imageFromBitmap(pixels: sortedTest3, width: Int(width), height: Int(height))
            ImageView.image = sortedImage3
        case "Effect 4":
            let sortedTest4 = randomSort(pixelData)
            let sortedImage4 = imageFromBitmap(pixels: sortedTest4, width: Int(width), height: Int(height))
            ImageView.image = sortedImage4
        case "Effect 5":
            let sortedTest5 = sortByAlphaChanges(pixelData)
            let sortedImage5 = imageFromBitmap(pixels: sortedTest5, width: Int(width), height: Int(height))
            ImageView.image = sortedImage5
        case "Effect 6":
            let sortedTest6 = sortByRow(pixelData, width: width)
            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
            ImageView.image = sortedImage6
        case "Effect 7":
            let sortedTest7 = duplicatePixels(pixelData)
            let sortedImage7 = imageFromBitmap(pixels: sortedTest7, width: Int(width), height: Int(height))
            ImageView.image = sortedImage7
        //effect
        case "Effect 8":
            let sortedTest8 = copyAndDivide(pixelData)
            let sortedImage8 = imageFromBitmap(pixels: sortedTest8, width: Int(width), height: Int(height))
            ImageView.image = sortedImage8
        case "Effect 9":
            let sortedTest9 = insertPixels(pixelData)
            let sortedImage9 = imageFromBitmap(pixels: sortedTest9, width: Int(width), height: Int(height))
            ImageView.image = sortedImage9
        case "Effect 10":
            let sortedTest10 = rgbaSort(pixelData)
            let sortedImage10 = imageFromBitmap(pixels: sortedTest10, width: Int(width), height: Int(height))
            ImageView.image = sortedImage10
        case "Effect 11":
            let sortedTest11 = coolLines(pixelData)
            let sortedImage11 = imageFromBitmap(pixels: sortedTest11, width: Int(width), height: Int(height))
            ImageView.image = sortedImage11
        case "Effect 12":
            let sortedTest6 = blue(pixelData)
            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
            ImageView.image = sortedImage6
        case "Effect 13":
            let sortedTest6 = dotsAndShit(pixelData)
            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
            ImageView.image = sortedImage6
        case "Effect 14":
            let sortedTest6 = coolReversedLines(pixelData)
            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
            ImageView.image = sortedImage6
//        case "Effect 15":
//            let sortedTest6 = sortByRow(pixelData)
//            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
//            ImageView.image = sortedImage6
//        case "Effect 16":
//            let sortedTest6 = sortByRow(pixelData)
//            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
//            ImageView.image = sortedImage6
//        case "Effect 17":
//            let sortedTest6 = sortByRow(pixelData)
//            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
//            ImageView.image = sortedImage6
//        case "Effect 18":
//            let sortedTest6 = sortByRow(pixelData)
//            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
//            ImageView.image = sortedImage6
//        case "Effect 19":
//            let sortedTest6 = sortByRow(pixelData)
//            let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
//            ImageView.image = sortedImage6
        default:
            print("Well this shouldn't have happened")
        }
   }
    func activateActivity(){
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        
    }
    func stopActivity(){
        activityIndicator.alpha = 0
        activityIndicator.startAnimating()
    }

}

