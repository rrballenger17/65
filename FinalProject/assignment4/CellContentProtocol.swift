//
//  CellContentProtocol.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/3/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation

protocol CellContentProtocol{
    
    init()
    
    // decode title and points
    init(coder decode: NSCoder)
    
    // encode title and points
    func encodeWithCoder(encode: NSCoder)
    
    
    var title: String {get set}
    
    var living: [(Int,Int)] {get set}
    
    
    func getLargestRowCol()->(Int, Int)
}