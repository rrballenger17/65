//
//  StorageProtocol.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/3/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation


protocol StorageProtocol {
    
    init()
    
    var cellContents: [CellContent] {get set}
        
    init(coder decode: NSCoder)
    
    func encodeWithCoder(encode: NSCoder)
}