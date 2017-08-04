//
//  ImageResizing.swift
//  PixelSorting
//
//  Created by Christian Flanders on 8/4/17.
//  Copyright © 2017 Christian Flanders. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


