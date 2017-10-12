//
//  OpeningScreenViewController.swift
//  PixelSorting
//
//  Created by Christian Flanders on 7/26/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Constants
    fileprivate let picker = UIImagePickerController()
    fileprivate let camera = UIImagePickerController()
    
    //MARK: Outlets
    @IBOutlet weak var cancel: UIButton!
    
    //MARK: Weak vars
    
    //MARK: Public Variables
    
    public var chosenImage = UIImage()
    public var doesContainPicture = false
    public var imageSentBack = UIImage()
    
    //MARK: Private Variables

    
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        camera.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if doesContainPicture {
            cancel.isHidden = false
        } else {
            cancel.isHidden = true
        }
    }
    
    //MARK: IBActions
    @IBAction func SelectFromLibrary(_ sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: UIButton){
        camera.allowsEditing = false
        camera.sourceType = .camera
        self.present(camera, animated: true, completion: nil)
        
    }
    
    //MARK: Instance Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "ImageFromLibrarySelected", sender: self)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("dismissed")
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ImageFromLibrarySelected" {
            let destination = segue.destination as! MainScreenController
            destination.importedImage = chosenImage
        } else if segue.identifier == "CancelButton" {
            let destination = segue.destination as! MainScreenController
            destination.importedImage = imageSentBack
        }
    }
}
