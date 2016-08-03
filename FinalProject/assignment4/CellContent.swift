//
//  CellContent.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/2/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation

class CellContent: NSObject, CellContentProtocol{

    override required init(){}
    
    
    // decode title and points
    required init(coder decode: NSCoder) {
        
        if let title = decode.decodeObjectForKey("title") as? String{
            
            self.title = title
        
        }
        
        if let livingX = decode.decodeObjectForKey("livingX") as? [Int], livingY = decode.decodeObjectForKey("livingY") as? [Int] {
            
            var newLiving: [(Int, Int)] = []
            
            for index in 0..<livingX.count{
                newLiving.append((livingX[index], livingY[index]))
            }
            
            self.living = newLiving
            
        }
    }
    
    // encode title and points
    func encodeWithCoder(encode: NSCoder) {
        
        encode.encodeObject(self.title, forKey: "title")
        
        // convert tuples to arrays since tuples aren't AnyObject
        var x:[Int] = []
        var y:[Int] = []
        
        for point in living{
            
            x.append(point.0)
            y.append(point.1)
        }
        
        
        encode.encodeObject(x, forKey: "livingX")
        encode.encodeObject(y, forKey: "livingY")
        
    }
    
    
    
    var title = "New Board"
    
    var living: [(Int,Int)] = []
    
    
    func getLargestRowCol()->(Int, Int){
        
        
        let points: [(Int, Int)] =  living
       
        var cols = 0
        var rows = 0
        
        for point in points{
            if(point.0 > cols){
                cols = point.0
            }
            
            if(point.1 > rows){
                rows = point.1
            }
        }
        
        rows = rows + 1
        cols = cols + 1
        
        // round counts up to nearest 10
        if(rows % 10 != 0){
            rows += (10 - rows % 10)
        }
        
        if(cols % 10 != 0){
            cols += (10 - cols % 10)
        }
        
        
        return (cols,rows)
        
    }
    
    
}
