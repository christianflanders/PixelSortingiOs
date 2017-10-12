import Foundation
import UIKit
import CoreGraphics

extension UIImage {
    public func pixelData() -> [UInt8]? {
        let size = self.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = self.cgImage else { return nil }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        return pixelData
    }

        public func fixOrientation() -> UIImage {
            if self.imageOrientation == UIImageOrientation.up {
                return self
            }
            
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
            self.draw(in: CGRectMake(0, 0, self.size.width, self.size.height))
            let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            return normalizedImage;
        }
    
//MARK: Functions
    
    public func imageInitialProcessing(_ image: UIImage) -> [PixelData] {
        let fixed = image.fixOrientation()
        let myImageDataArray = fixed.pixelData()
        let arrayOfPixelData = convertToArray(myImageDataArray!)
        return arrayOfPixelData
        
    }
    //Takes the array of numbers we get back and sorts it into pixel data that we can manipulate easier
    public func convertToArray(_ input : [UInt8]) -> [PixelData] {
        var index = 0
        var arrayOfPixelData = [PixelData]()
        for _ in input{
            if index % 4 == 0 {
                var pixel = PixelData()
                let r = input[index]
                let g = input[index + 1]
                let b = input[index + 2]
                let a = input[index + 3]
                pixel.r = a
                pixel.g = r
                pixel.b = g
                pixel.a = b
                arrayOfPixelData.append(pixel)
                index += 1
            } else {
                index += 1
            }
            // a r b g
        }
        return arrayOfPixelData
    }
    //takes our bitmap and converts it back into a UIImage
    public func imageFromBitmap(pixels: [PixelData], width: Int, height: Int) -> UIImage? {
        assert(width > 0)
        
        assert(height > 0)
        
        let pixelDataSize = MemoryLayout<PixelData>.size
        assert(pixelDataSize == 4)
        
        assert(pixels.count == Int(width * height))
        
        let data: Data = pixels.withUnsafeBufferPointer {
            return Data(buffer: $0)
        }
        
        let cfdata = NSData(data: data) as CFData
        let provider: CGDataProvider! = CGDataProvider(data: cfdata)
        if provider == nil {
            print("CGDataProvider is not supposed to be nil")
            return nil
        }
        let cgimage: CGImage! = CGImage(
            width: width,
            height: height,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: width * pixelDataSize,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: provider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        if cgimage == nil {
            print("CGImage is not supposed to be nil")
            return nil
        }
        return UIImage(cgImage: cgimage)
    }
    
    public func effectTemplate(effect: ([PixelData]) -> [PixelData]) -> UIImage {
        print(self.size.width)
        print(self.size.height)

        let mutableImage = imageInitialProcessing(self)
        let processedImage = effect(mutableImage)
        if let returnImage = imageFromBitmap(pixels: processedImage, width: Int(self.size.width), height: Int(self.size.height)) {
            return returnImage
        } else {
            print("this shouldnt happen")
            return self
        }
        
    }
    
    public func effectTemplateIncludingWidth(effect: ([PixelData],CGFloat) -> [PixelData]) -> UIImage {
        let mutableImage = imageInitialProcessing(self)
        let processedImage = effect(mutableImage, self.size.width)
        if let returnImage = imageFromBitmap(pixels: processedImage, width: Int(self.size.width), height: Int(self.size.height)) {
            return returnImage
        } else {
            print("this shouldnt happen")
            return self
        }
        
    }
}

//END OF IMAGE EXTENSION
public struct PixelData {
    public var r: UInt8 = 0
    public var g: UInt8 = 0
    public var b: UInt8 = 0
    public var a: UInt8 = 0
    
}

public func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}



public func checkSizeAndResizeImage(_ input : UIImage) -> UIImage{
    let verticalResizer: CGFloat = 1920
    let horizontalResizer: CGFloat = 1080
    var resizedReturnImage: UIImage
    let inputWidth = input.size.width
    let inputHeight = input.size.height
    //Vertical image
    if inputHeight > inputWidth {
        resizedReturnImage = input.resized(toWidth: verticalResizer)!
        print("image resized by width!")
    } else { //Horizontal Image
        print("image re3sized by height!")
        resizedReturnImage = input.resized(toWidth: horizontalResizer)!
    }
    return resizedReturnImage
}


