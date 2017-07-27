//
//  OpeningScreenViewController.swift
//  PixelSorting
//
//  Created by Christian Flanders on 7/26/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SelectFromLibrary(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
        {
            //adfadsasd
        }
        
    }
    

}
