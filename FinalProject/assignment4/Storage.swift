//
//  Storage.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/1/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation


class Storage: NSObject , StorageProtocol{
    
    var cellContents: [CellContent] = []
    
    private static var oneInstance: Storage = Storage()
    
    static var sharedInstance: Storage {
        get {
            return oneInstance
        }
    }
    
    override required init(){}
    
    required init(coder decode: NSCoder) {
        if let contents = decode.decodeObjectForKey("contents") as? [CellContent] {
            self.cellContents = contents
        }
    }
    
    func encodeWithCoder(encode: NSCoder) {
        
        encode.encodeObject(self.cellContents, forKey: "contents")
        
    }
    
}