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
    
    

    
    
}

/*class ImageResizing{
    let maxDimension: Int
    init(maxDimension:Int) {
        self.maxDimension = maxDimension
    }
    func isSmallEnough( w : Int, h: Int ) -> Bool{
       return w < maxDimension && h < maxDimension
    }
    
    
    
    
    func shrinkImage(original:UIImage) -> UIImage {
        
        var w = Int(original.size.width)
        var h = Int(original.size.height)
        if (isSmallEnough(w: w, h: h)){
            return original
        }
        while (isSmallEnough(w: w, h: h)){
            w = w/2
            h = h/2
        }
        let floatW = CGFloat(w)
        return resizeImage(image: original, newWidth: floatW)
       
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
            
            let scale = newWidth / image.size.width
            let newHeight = image.size.height * scale
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
    


}
 */





public struct PixelData {
    public var r: UInt8 = 0
    public var g: UInt8 = 0
    public var b: UInt8 = 0
    public var a: UInt8 = 0
    
}
public func imageInitialProcessing(_ image: UIImage) -> [PixelData] {
    let width = image.size.width
    let height = image.size.height
    let myImageDataArray = image.pixelData()
    let arrayOfPixelData = convertToArray(myImageDataArray!)
    return arrayOfPixelData

}
public func convertToArray(_ input : [UInt8]) -> [PixelData] {
    var index = 0
    var arrayOfPixelData = [PixelData]()
    for i in input{
        if index % 4 == 0 {
            var pixel = PixelData()
            let r = i
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
  public func imageFromBitmap(pixels: [PixelData], width: Int, height: Int) -> UIImage? {
        assert(width > 0)
        
        assert(height > 0)
        
        let pixelDataSize = MemoryLayout<PixelData>.size
        assert(pixelDataSize == 4)
        
        //assert(pixels.count == Int(width * height))
        
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

//works if assert is turned off
public func someEffect(_ input: [PixelData]) -> [PixelData]{
    var returnArray = input
    var counter = 0
    for i in input{
        if counter % 100 == 0 && counter < input.count{
            
            let random = Int(arc4random_uniform(UInt32(input.count)))
            if random < input.count {
                returnArray.insert(i, at: random)
                returnArray.insert(input[counter + 1], at: random)
                returnArray.insert(input[counter + 2], at: random)
                returnArray.insert(input[counter + 3], at: random)
                returnArray.insert(input[counter + 4], at: random)
                returnArray.insert(input[counter + 5], at: random)
                returnArray.insert(input[counter + 6], at: random)
                returnArray.insert(input[counter + 7], at: random)
                returnArray.insert(input[counter + 8], at: random)
                returnArray.insert(input[counter + 9], at: random)
                counter += 1
                print("working" , counter)
            }
        }
        counter += 1
    }
    return returnArray
}



public func randomSort(_ input: [PixelData]) -> [PixelData]{
    var index = 0
    var finishedEverything = input
    for i in input{
        let random = arc4random_uniform(UInt32((input.count)))
        let randomRange = 300
        print(randomRange)
        if random % 500 == 0 {
            if index + randomRange < input.count{
            let range = index..<index + randomRange
            var sortableRange = input[range]
            sortableRange.sort{ $0.g < $1.b}
            finishedEverything.replaceSubrange(range, with: sortableRange)
        }
        }
        index += 1
    }
    return finishedEverything
}

public func sortByAlphaChanges(_ inputData: [PixelData]) -> [PixelData]{
    //var sortableRange = [PixelData]()
    var finishedSorting = inputData
    var lastAlpha = UInt8(0)
    let maxDifference = UInt8(50)
    var index = 0
    let randomRange = 300
    for pixel in inputData {
        let op1 = pixel.a
        let op2 = lastAlpha
        let difference = Int(op1) - Int(op2)
        let range = index..<index + 300
        
        if difference > Int(maxDifference) {
            if range.endIndex < inputData.count{
                var sortableRange = inputData[index..<randomRange + index]
                sortableRange.sort { $0.b < $1.g }
                print(range)
                finishedSorting.replaceSubrange(range, with: sortableRange)
            }
            
        }
        lastAlpha = pixel.a //THIS LINE
        index += 1
    }
    return finishedSorting
}

public func sortByRow(_ toBeSorted: [PixelData], width: CGFloat ) -> [PixelData]{
    var fullySorted = toBeSorted
    let widthOfInput = Int(width)
    var counter = 0
    for pixel in toBeSorted {
        if counter % 100 == 0{
            let subrange = counter..<widthOfInput + counter
            var sorting = toBeSorted[subrange]
            sorting.sort { $0.g < $1.b }
            fullySorted.replaceSubrange(subrange, with: sorting)
            counter += 1
        } else {
            counter += 1
        }
    }
    return fullySorted
}
//seems to do pretty much the same thing as copyand divide
public func duplicatePixels(_ toBeSorted: [PixelData]) -> [PixelData]{
    var sorting = toBeSorted
    var counter = 0
    for pixels in sorting {
        if counter % 4 == 0{
            let insert = counter + 2
            sorting.insert(pixels, at: insert)
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorting
}
//good if assert is turned off
public func copyAndDivide(_ toBeSorted: [PixelData]) -> [PixelData]{
    var sorting = toBeSorted
    var counter = 0
    for pixels in sorting {
        if counter % 4 == 0{
            let insert = counter
            var maths = pixels
            let compare = toBeSorted[counter + 1]
            maths.a = UInt8(Int(compare.a) / 2)
            maths.r = UInt8(Int(compare.r) / 2)
            maths.g = UInt8(Int(compare.g) / 2)
            maths.b = UInt8(Int(compare.b) / 2)
            sorting.insert(maths, at: insert)
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorting
}


