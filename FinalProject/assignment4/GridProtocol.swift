//
//  GridProtocol.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/3/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation


protocol GridProtocol {
    var rows: Int { get }
    var cols: Int { get }
    
    init(cols: Int, rows: Int)
    
    func neighbors(tuple: (Int, Int)) -> [(Int, Int)]
    
    // change this to cell state
    subscript(col: Int, row: Int) -> CellState { get set }
}

