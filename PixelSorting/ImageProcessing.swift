import Foundation
import UIKit
import CoreGraphics


//public func randomSorter() -> UIImage {
//    let input = imageInitialProcessing(self)
//    var index = 0
//    var finishedEverything = input
//    for i in input{
//        let random = arc4random_uniform(UInt32((input.count)))
//        let randomRange = 300
//        print(randomRange)
//        if random % 500 == 0 {
//            if index + randomRange < input.count{
//                let range = index..<index + randomRange
//                var sortableRange = input[range]
//                sortableRange.sort{ $0.g < $1.b}
//                finishedEverything.replaceSubrange(range, with: sortableRange)
//            }
//        }
//        index += 1
//    }
//}


//works if assert is turned off
 func someEffect(_ input: [PixelData]) -> [PixelData]{
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
            }
        }
        counter += 1
    }
    return returnArray
}

public func arSort(_ input: [PixelData]) -> [PixelData]{
//    var sorted = input
    let sorted = input.sorted { $0.a < $1.r }
    return sorted
}

public func gbSort(_ input: [PixelData]) -> [PixelData]{
    var sorted = input
    sorted.sort { $0.g < $1.b }
    return sorted
}

public func randomSort(_ input: [PixelData]) -> [PixelData]{
    var index = 0
    var finishedEverything = input
    for i in input{
        let random = arc4random_uniform(UInt32((input.count)))
        let randomRange = 300
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
                finishedSorting.replaceSubrange(range, with: sortableRange)
            }
            
        }
        lastAlpha = pixel.a //THIS LINE
        index += 1
    }
    return finishedSorting
}
public func sortByRedChanges(_ inputData: [PixelData]) -> [PixelData]{
    //var sortableRange = [PixelData]()
    var finishedSorting = inputData
    var lastAlpha = UInt8(0)
    let maxDifference = UInt8(100)
    var index = 0
    let randomRange = 300
    for pixel in inputData {
        let op1 = pixel.r
        let op2 = lastAlpha
        let difference = Int(op1) - Int(op2)
        let range = index..<index + 300
        
        if difference > Int(maxDifference) {
            if range.endIndex < inputData.count{
                var sortableRange = inputData[index..<randomRange + index]
                sortableRange.sort { $0.g < $1.r }
                finishedSorting.replaceSubrange(range, with: sortableRange)
            }
            
        }
        lastAlpha = pixel.g //THIS LINE
        index += 1
    }
    return finishedSorting
}
public func sortByGreenChanges(_ inputData: [PixelData]) -> [PixelData]{
    //var sortableRange = [PixelData]()
    var finishedSorting = inputData
    var lastAlpha = UInt8(0)
    let maxDifference = UInt8(100)
    var index = 0
    let randomRange = 300
    for pixel in inputData {
        let op1 = pixel.g
        let op2 = lastAlpha
        let difference = Int(op1) - Int(op2)
        let range = index..<index + 300
        
        if difference > Int(maxDifference) {
            if range.endIndex < inputData.count{
                var sortableRange = inputData[index..<randomRange + index]
                sortableRange.sort { $0.g < $1.r }
                finishedSorting.replaceSubrange(range, with: sortableRange)
            }
            
        }
        lastAlpha = pixel.a //THIS LINE
        index += 1
    }
    return finishedSorting
}
//crashes
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
//👍
public func copyAndDivide(_ toBeSorted: [PixelData]) -> [PixelData]{
    var sorting = toBeSorted
    var counter = 0
    for pixels in sorting {
        if counter % 4 == 0{
            let insert = counter
            var maths = pixels
            let randomNum = arc4random_uniform(UInt32(255))
            let divider = UInt8(randomNum)
            maths.a = UInt8(Int(divider) / 2)
            maths.r = UInt8(Int(divider) / 2)
            maths.g = UInt8(Int(divider) / 2)
            maths.b = UInt8(Int(divider) / 2)
            sorting[counter] = maths
//            sorting[counter + 1] = maths
//            sorting[counter + 2] = maths
//            sorting[counter + 3] = maths
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorting
}

public func insertPixels(_ toBeSorted: [PixelData]) -> [PixelData]{
    var sorting = toBeSorted
    var counter = 0
    for i in sorting{
        if counter % 50 == 0{
            var newPixel =  i
            let r = newPixel.r
            let g = newPixel.g
            newPixel.r = g
            newPixel.g = r
            if counter + 50 < toBeSorted.count{
            sorting[counter+50] = newPixel
            }
            counter += 1
        } else {
            counter += 1
        }
    }
    //4 is cool but reaalllly slow. 50 is cool and relativly quick.
    
    
    return sorting
}

public func rgbaSort(_ input: [PixelData]) -> [PixelData]{
    var r = [UInt8]()
    var g = [UInt8]()
    var b = [UInt8]()
    var a = [UInt8]()
    var sorted = input
    for pixel in input{
        r.append(pixel.r)
        g.append(pixel.g)
        b.append(pixel.b)
        a.append(pixel.a)
    }
    var counter = 0
    var random = arc4random_uniform(UInt32(255))
    var randomPixel = UInt8(random)
    var u0 = randomPixel
    for pixel in sorted{
        sorted[counter].a = UInt8(0)
        if counter % 11 == 0 && counter + 11 < sorted.count {
            sorted[counter].r = r[counter]
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].r = r[counter + 1]
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].r = r[counter + 2]
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].r = r[counter + 3]
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = g[counter + 4]
            sorted[counter + 4].r = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = g[counter + 5]
            sorted[counter + 5].r = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = g[counter + 6]
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
//            sorted[counter + 7].g = g[counter + 7]
//            sorted[counter + 7].r = u0
//            sorted[counter + 7].b = u0
//            sorted[counter + 8].b = b[counter + 8]
//            sorted[counter + 8].r = u0
//            sorted[counter + 8].g = u0
//            sorted[counter + 9].b = b[counter + 9]
//            sorted[counter + 9].r = u0
//            sorted[counter + 9].g = u0
//            sorted[counter + 10].b = b[counter + 10]
//            sorted[counter + 10].r = u0
//            sorted[counter + 10].g = u0
//            sorted[counter + 11].b = b[counter + 11]
//            sorted[counter + 11].r = u0
//            sorted[counter + 11].g = u0
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorted
}
public func rgbaSortMaybe(_ input: [PixelData]) -> [PixelData]{
    var r = [UInt8]()
    var g = [UInt8]()
    var b = [UInt8]()
    var a = [UInt8]()
    var sorted = input
    for pixel in input{
        r.append(pixel.b)
        g.append(pixel.g)
        b.append(pixel.r)
        a.append(pixel.a)
    }
    var counter = 0
    var random = arc4random_uniform(UInt32(255))
    var randomPixel = UInt8(random)
    var u0 = randomPixel
    for pixel in sorted{
        var index = sorted[counter]
        index.a = UInt8(255)
        if counter % 5 == 0 && counter + 11 < sorted.count {
            sorted[counter].r = r[counter]
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].r = r[counter + 1]
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].r = r[counter + 2]
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].r = r[counter + 3]
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = g[counter + 4]
            sorted[counter + 4].r = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = g[counter + 5]
            sorted[counter + 5].r = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = g[counter + 6]
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
            sorted[counter + 7].g = g[counter + 7]
            sorted[counter + 7].r = u0
            sorted[counter + 7].b = u0
            sorted[counter + 8].b = b[counter + 8]
            sorted[counter + 8].r = u0
            sorted[counter + 8].g = u0
            sorted[counter + 9].b = b[counter + 9]
            sorted[counter + 9].r = u0
            sorted[counter + 9].g = u0
            sorted[counter + 10].b = b[counter + 10]
            sorted[counter + 10].r = u0
            sorted[counter + 10].g = u0
            sorted[counter + 11].b = b[counter + 11]
            sorted[counter + 11].r = u0
            sorted[counter + 11].g = u0
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorted
}
public func coolLines(_ input: [PixelData]) -> [PixelData]{
    var r = [UInt8]()
    var g = [UInt8]()
    var b = [UInt8]()
    var a = [UInt8]()
    var sorted = input
    for pixel in input{
        r.append(pixel.r)
        g.append(pixel.g)
        b.append(pixel.b)
        a.append(pixel.a)
    }
    var counter = 0
    var u0 = UInt8(0)
    for pixel in sorted{
        var index = sorted[counter]
        index.a = UInt8(0)
        if counter % 5 == 0 && counter + 11 < sorted.count {
            sorted[counter].r = r[counter]
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].r = r[counter + 1]
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].r = r[counter + 2]
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].r = r[counter + 3]
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = g[counter + 4]
            sorted[counter + 4].r = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = g[counter + 5]
            sorted[counter + 5].r = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = g[counter + 6]
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
            sorted[counter + 7].g = g[counter + 7]
            sorted[counter + 7].r = u0
            sorted[counter + 7].b = u0
            sorted[counter + 8].b = b[counter + 8]
            sorted[counter + 8].r = u0
            sorted[counter + 8].g = u0
            sorted[counter + 9].b = b[counter + 9]
            sorted[counter + 9].r = u0
            sorted[counter + 9].g = u0
            sorted[counter + 10].b = b[counter + 10]
            sorted[counter + 10].r = u0
            sorted[counter + 10].g = u0
            sorted[counter + 11].b = b[counter + 11]
            sorted[counter + 11].r = u0
            sorted[counter + 11].g = u0
            counter += 1
        } else {
            counter += 1
        }
    }
    for i in sorted {
        
    }
    return sorted
}
public func blue(_ input: [PixelData]) -> [PixelData]{
    var r = [UInt8]()
    var g = [UInt8]()
    var b = [UInt8]()
    var a = [UInt8]()
    var sorted = input
    for pixel in input{
        r.append(pixel.r)
        g.append(pixel.g)
        b.append(pixel.b)
        a.append(pixel.a)
    }
    var counter = 0
    var u0 = UInt8(0)
    for pixel in sorted{
        var index = sorted[counter]
        index.a = UInt8(255)
        if counter % 1 == 0 && counter + 11 < sorted.count {
            sorted[counter].r = r[counter]
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].r = r[counter + 1]
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].r = r[counter + 2]
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].r = r[counter + 3]
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = g[counter + 4]
            sorted[counter + 4].r = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = g[counter + 5]
            sorted[counter + 5].r = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = g[counter + 6]
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
            sorted[counter + 7].g = g[counter + 7]
            sorted[counter + 7].r = u0
            sorted[counter + 7].b = u0
            sorted[counter + 8].b = b[counter + 8]
            sorted[counter + 8].r = u0
            sorted[counter + 8].g = u0
            sorted[counter + 9].b = b[counter + 9]
            sorted[counter + 9].r = u0
            sorted[counter + 9].g = u0
            sorted[counter + 10].b = b[counter + 10]
            sorted[counter + 10].r = u0
            sorted[counter + 10].g = u0
            sorted[counter + 11].b = b[counter + 11]
            sorted[counter + 11].r = u0
            sorted[counter + 11].g = u0
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorted
}

public func dotsAndShit(_ input: [PixelData]) -> [PixelData]{
    var r = [UInt8]()
    var g = [UInt8]()
    var b = [UInt8]()
    var a = [UInt8]()
    var sorted = input
    for pixel in input{
        r.append(pixel.r)
        g.append(pixel.g)
        b.append(pixel.b)
        a.append(pixel.a)
    }
    var counter = 0
    var u0 = UInt8(0)
    for pixel in sorted{
        var index = sorted[counter]
        index.a = UInt8(255)
        if counter % 8 == 0 && counter + 11 < sorted.count {
            sorted[counter].r = r[counter]
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].r = r[counter + 1]
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].r = r[counter + 2]
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].r = r[counter + 3]
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = g[counter + 4]
            sorted[counter + 4].r = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = g[counter + 5]
            sorted[counter + 5].r = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = g[counter + 6]
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
            sorted[counter + 7].g = g[counter + 7]
            sorted[counter + 7].r = u0
            sorted[counter + 7].b = u0
            sorted[counter + 8].b = b[counter + 8]
            sorted[counter + 8].r = u0
            sorted[counter + 8].g = u0
            sorted[counter + 9].b = b[counter + 9]
            sorted[counter + 9].r = u0
            sorted[counter + 9].g = u0
            sorted[counter + 10].b = b[counter + 10]
            sorted[counter + 10].r = u0
            sorted[counter + 10].g = u0
            sorted[counter + 11].b = b[counter + 11]
            sorted[counter + 11].r = u0
            sorted[counter + 11].g = u0
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorted
}

public func coolReversedLines(_ input: [PixelData]) -> [PixelData]{
    var r = [UInt8]()
    var g = [UInt8]()
    var b = [UInt8]()
    var a = [UInt8]()
    var sorted = input
    for pixel in input{
        r.append(pixel.b)
        g.append(pixel.g)
        b.append(pixel.r)
        a.append(pixel.a)
    }
    var counter = 0
    var u0 = UInt8(0)
    for pixel in sorted{
        var index = sorted[counter]
        index.a = UInt8(255)
        if counter % 5 == 0 && counter + 11 < sorted.count {
            sorted[counter].r = r[counter]
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].r = r[counter + 1]
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].r = r[counter + 2]
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].r = r[counter + 3]
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = g[counter + 4]
            sorted[counter + 4].r = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = g[counter + 5]
            sorted[counter + 5].r = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = g[counter + 6]
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
            sorted[counter + 7].g = g[counter + 7]
            sorted[counter + 7].r = u0
            sorted[counter + 7].b = u0
            sorted[counter + 8].b = b[counter + 8]
            sorted[counter + 8].r = u0
            sorted[counter + 8].g = u0
            sorted[counter + 9].b = b[counter + 9]
            sorted[counter + 9].r = u0
            sorted[counter + 9].g = u0
            sorted[counter + 10].b = b[counter + 10]
            sorted[counter + 10].r = u0
            sorted[counter + 10].g = u0
            sorted[counter + 11].b = b[counter + 11]
            sorted[counter + 11].r = u0
            sorted[counter + 11].g = u0
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorted
}

//👍
public func blocks(_ input: [PixelData]) -> [PixelData] {
    var sorted = input
    var counter = 0
    for _ in sorted{
        if counter % 20 == 0 {
            sorted[counter + 1] = sorted[counter]
            sorted[counter + 2] = sorted[counter]
            sorted[counter + 3] = sorted[counter]
            sorted[counter + 4] = sorted[counter]
            sorted[counter + 5] = sorted[counter]
            sorted[counter + 6] = sorted[counter]
            sorted[counter + 7] = sorted[counter]
            sorted[counter + 8] = sorted[counter]
            sorted[counter + 9] = sorted[counter]
            sorted[counter + 10] = sorted[counter]
            sorted[counter + 11] = sorted[counter]
            sorted[counter + 12] = sorted[counter]
            sorted[counter + 13] = sorted[counter]
            sorted[counter + 14] = sorted[counter]
            sorted[counter + 15] = sorted[counter]
            sorted[counter + 16] = sorted[counter]
            sorted[counter + 17] = sorted[counter]
            sorted[counter + 18] = sorted[counter]
            counter += 1
        } else {
            counter += 1
        }
    }
    return sorted
}

public func bigBlocks(_ input: [PixelData]) -> [PixelData] {
    var sorted = input
    var counter = 0
    let random = Int(arc4random_uniform(UInt32(input.count / 8)))
    for _ in sorted{
        if counter % random == 0 {
            if counter + 26 < input.count{
            sorted[counter + 1] = sorted[counter]
            sorted[counter + 2] = sorted[counter]
            sorted[counter + 3] = sorted[counter]
            sorted[counter + 4] = sorted[counter]
            sorted[counter + 5] = sorted[counter]
            sorted[counter + 6] = sorted[counter]
            sorted[counter + 7] = sorted[counter]
            sorted[counter + 8] = sorted[counter]
            sorted[counter + 9] = sorted[counter]
            sorted[counter + 10] = sorted[counter]
            sorted[counter + 11] = sorted[counter]
            sorted[counter + 12] = sorted[counter]
            sorted[counter + 13] = sorted[counter]
            sorted[counter + 14] = sorted[counter]
            sorted[counter + 15] = sorted[counter]
            sorted[counter + 16] = sorted[counter]
            sorted[counter + 17] = sorted[counter]
            sorted[counter + 18] = sorted[counter]
            sorted[counter + 19] = sorted[counter]
            sorted[counter + 20] = sorted[counter]
            sorted[counter + 21] = sorted[counter]
            sorted[counter + 22] = sorted[counter]
            sorted[counter + 23] = sorted[counter]
            sorted[counter + 24] = sorted[counter]
            sorted[counter + 25] = sorted[counter]
            sorted[counter + 26] = sorted[counter]
            sorted[counter + 27] = sorted[counter]
                counter += 1

            }
        } else {
            counter += 1
        }
    }
    return sorted
}



