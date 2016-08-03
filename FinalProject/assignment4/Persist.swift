//
//  Persist.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/2/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation



class Persist{
    
    func clearData(){
        
        let nsd = NSUserDefaults.standardUserDefaults()
        
        nsd.setObject(nil, forKey: "storage")
        
    }
    
    
    
    func storeData() {
        
        let nsd = NSUserDefaults.standardUserDefaults()
        
        nsd.setObject(NSKeyedArchiver.archivedDataWithRootObject(Storage.sharedInstance), forKey: "storage")
        
        
    }
    
    
    func getStoredData()-> Storage?{
    
        let nsd = NSUserDefaults.standardUserDefaults()
    
        guard let storage = nsd.objectForKey("storage") as? NSData else{
            return nil
        }
        
        let unarch = NSKeyedUnarchiver(forReadingWithData: storage)
            
        guard let old = unarch.decodeObjectForKey("root") as? Storage else{
            return nil
        }
    
        return old

    }
}