//
//  CellState.swift
//  assignment3
//
//  Created by Ryan Ballenger on 7/10/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation


enum CellState: String {
    
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func description()->String {
        switch self{
        case Living: return Living.rawValue
        case Empty: return Empty.rawValue
        case Born: return Born.rawValue
        case Died: return Died.rawValue
        }
    }
    
    // It was stated on the discussion board to return the case value and not the raw value
    func allVals()->[CellState]{
        return [.Living, .Empty, .Born, .Died]
    }
    
    func toggle(value: CellState)->CellState{
        switch value{
        case .Empty, .Died: return .Living
        case .Born, .Living: return .Empty
        }
    }
    
}