//
//  OpeningScreenViewController.swift
//  PixelSorting
//
//  Created by Christian Flanders on 7/26/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let picker = UIImagePickerController()
    let camera = UIImagePickerController()
    var chosenImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("fahsdfasdfasd")
        picker.delegate = self
        camera.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage

        print("bye")
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
            destination.image = chosenImage 
            
        }
    }
    

}
