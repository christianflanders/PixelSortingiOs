import UIKit
import CoreGraphics

public func someEffect(_ input: [PixelData]) -> [PixelData]{
    var returnArray = input
    for i in 0..<input.count{
        if i % 100 == 0 {
            let random = Int(arc4random_uniform(UInt32((100))))
            print(random)
            if random + i < input.count {
            for j in i..<random + i{
                returnArray[j] = input[random]
                }
        }
        }
        }
    return returnArray
    }


public func arSort(_ input: [PixelData]) -> [PixelData]{
//    var sorted = input
    let sorted = input.sorted { $0.b < $1.r }
    return sorted
}
//gbSort
public func xtal(_ input: [PixelData]) -> [PixelData]{
    var sorted = input
    sorted.sort { $0.g < $1.b }
    return sorted
}

//randomsort
public func blueCalx(_ input: [PixelData]) -> [PixelData]{
    var finishedEverything = input
    for i in 0..<input.count{
//        let random = arc4random_uniform(UInt32((input.count)))
        if i % 1000 == 0 {
            let randomRange = Int(arc4random_uniform(UInt32((800))))
            if i + randomRange < input.count{
            let range = i..<i + randomRange
            var sortableRange = input[range]
            sortableRange.sort{ $0.g < $1.b}
            finishedEverything[range] = sortableRange
        }
        }
    }
    return finishedEverything
}
//sortbyalphachanges
public func nanou2(_ inputData: [PixelData]) -> [PixelData]{
    var returnArray = inputData
    for i in 0..<inputData.count{
        if i % 500 == 0  {
            let random = Int(arc4random_uniform(UInt32((250))))
            print(random)
            if random + i < inputData.count {
                var sortable = inputData[i..<random + i]
                sortable.sort { $0.g < $1.b }
                returnArray.replaceSubrange(i..<random + i, with: sortable)
            }
        }
    }
    return returnArray
}


public func sortByGreenChanges(_ inputData: [PixelData]) -> [PixelData]{
    //var sortableRange = [PixelData]()
    var finishedSorting = inputData
    var lastAlpha = UInt8(0)
    let maxDifference = UInt8(5)
    var index = 0
    let randomRange = 500
    for pixel in inputData {
        let op1 = pixel.g
        let op2 = lastAlpha
        let difference = Int(op1) - Int(op2)
        let range = index..<index + randomRange
        
        if difference > Int(maxDifference) && range.endIndex < inputData.count {
                var sortableRange = inputData[index..<randomRange + index]
                sortableRange.sort { $0.g < $1.b }
                finishedSorting.replaceSubrange(range, with: sortableRange)
        }
        lastAlpha = pixel.g //THIS LINE
        print(lastAlpha)
        index += 1
    }
    return finishedSorting
}


public func copyAndDivide(_ toBeSorted: [PixelData]) -> [PixelData]{
    var sorting = toBeSorted
    for i in 0..<sorting.count {
        if i % 4 == 0{
            var maths = sorting[i]
            let randomNum = arc4random_uniform(UInt32(255))
            let divider = UInt8(randomNum)
            maths.a = UInt8(Int(divider) / 2)
            maths.r = UInt8(Int(divider) / 2)
            maths.g = UInt8(Int(divider) / 2)
            maths.b = UInt8(Int(divider) / 2)
            sorting[i] = maths
    }
}
    return sorting

}

public func insertPixels(_ toBeSorted: [PixelData]) -> [PixelData]{
    var sorting = toBeSorted
    var counter = 0
    for i in sorting{
        if counter % 10 == 0{
            let randomNum = Int(arc4random_uniform(UInt32(200)))
            let randomNumR = UInt8(arc4random_uniform(UInt32(255)))
            let randomNumG = UInt8(arc4random_uniform(UInt32(255)))
            let randomNumB = UInt8(arc4random_uniform(UInt32(255)))

            var newPixel =  i
            newPixel.r = randomNumR
            newPixel.g = randomNumG
            newPixel.b = randomNumB
            if counter + randomNum < toBeSorted.count{
            sorting[counter+randomNum] = newPixel
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
    let random = arc4random_uniform(UInt32(255))
    let randomPixel = UInt8(random)
    let u0 = randomPixel
    for _ in sorted{
        sorted[counter].a = UInt8(0)
        if counter % 50 == 0 && counter + 6 < sorted.count {
            sorted[counter].a = u0
            sorted[counter].g = u0
            sorted[counter].b = u0
            sorted[counter + 1].a = u0
            sorted[counter + 1].g = u0
            sorted[counter + 1].b = u0
            sorted[counter + 2].a = u0
            sorted[counter + 2].g = u0
            sorted[counter + 2].b = u0
            sorted[counter + 3].a = u0
            sorted[counter + 3].g = u0
            sorted[counter + 3].b = u0
            sorted[counter + 4].g = u0
            sorted[counter + 4].a = u0
            sorted[counter + 4].b = u0
            sorted[counter + 5].g = u0
            sorted[counter + 5].a = u0
            sorted[counter + 5].b = u0
            sorted[counter + 6].g = u0
            sorted[counter + 6].r = u0
            sorted[counter + 6].b = u0
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
    let random = arc4random_uniform(UInt32(255))
    let randomPixel = UInt8(random)
    let u0 = randomPixel
    for _ in sorted{
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

public func blocks(_ input: [PixelData]) -> [PixelData] {
    var sorted = input
    var counter = 0
    for _ in sorted{
        if counter % 20 == 0 {
            if counter + 19 < input.count{
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
            }
            counter += 1

        } else {
            counter += 1
        }
    }
    return sorted
}

//blocksBasedOnInputSize
public func windowLicker(_ pixelData: [PixelData], width: CGFloat) -> [PixelData]{
    // for each 20th of the images width, copy the first pixel into the next 20
    let howManyLinesToCut = Int(width) / (Int(arc4random_uniform(UInt32(50))) + 1)
    var sorted = pixelData
    let count = pixelData.count
    for i in 0..<count {
        if i % howManyLinesToCut == 0 && i + howManyLinesToCut < count{
            let pixelToCopy = sorted[i]
            for i in i..<howManyLinesToCut + i{
                sorted[i] = pixelToCopy
            }
        }
    }
    return sorted
}

public func bigBlocks(_ input: [PixelData]) -> [PixelData] {
    var sorted = input
    let random = Int(arc4random_uniform(UInt32(100)))
    for i in 0..<sorted.count {
        if i % 100 == 0 {
            if i + random < input.count{
                for j in i..<i + random{
                    sorted.append(input[j + random])
                    sorted.remove(at: 0)
                }

            }
        }
    }
    return sorted
}



