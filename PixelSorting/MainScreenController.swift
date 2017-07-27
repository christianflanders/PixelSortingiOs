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
    let effectsArray = ["Effect 1", "Effect 2", "Effect 3", "Effect 4", "Effect 5"]
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
    if label == "Effect 1" {
        //SLOW AF
        activateActivity()
        let sortedTest1 = pixelData.sorted{ $0.a < $1.r}
        let sortedImage = imageFromBitmap(pixels: sortedTest1, width: Int(width), height: Int(height))
        ImageView.image = sortedImage
        stopActivity()
        //g < r
    }
    else if label == "Effect 2" {
        activateActivity()
        let sortedTest2 = pixelData.sorted{ $0.g < $1.b}
        let sortedImage2 = imageFromBitmap(pixels: sortedTest2, width: Int(width), height: Int(height))
        ImageView.image = sortedImage2
        stopActivity()
    }
    else if label == "Effect 3" {
        activateActivity()
        let sortedTest3 = someEffect(pixelData)
        let sortedImage3 = imageFromBitmap(pixels: sortedTest3, width: Int(width), height: Int(height))
        ImageView.image = sortedImage3
        stopActivity()
    }
    else if label == "Effect 4" {
        activateActivity()
        let sortedTest4 = randomSort(pixelData)
        let sortedImage4 = imageFromBitmap(pixels: sortedTest4, width: Int(width), height: Int(height))
        ImageView.image = sortedImage4
        stopActivity()
        }
    else if label == "Effect 5" {
        activateActivity()
        let sortedTest5 = sortByAlphaChanges(pixelData)
        let sortedImage5 = imageFromBitmap(pixels: sortedTest5, width: Int(width), height: Int(height))
        ImageView.image = sortedImage5
        stopActivity()
        }
    else if label == "Effect 6" {
        activateActivity()
        let sortedTest6 = sortByRow(pixelData, width: width)
        let sortedImage6 = imageFromBitmap(pixels: sortedTest6, width: Int(width), height: Int(height))
        ImageView.image = sortedImage6
        stopActivity()
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

