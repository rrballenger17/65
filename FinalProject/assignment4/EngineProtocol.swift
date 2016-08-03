//
//  EngineProtocol.swift
//  assignment4
//
//  Created by Ryan Ballenger on 8/2/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation

protocol EngineDelegate {
    func engineDidUpdate(withGrid: GridProtocol)
}

protocol EngineProtocol {
    
    var delegate: EngineDelegate { get set}
    
    var grid: GridProtocol {get}
    
    // needs to default to 0
    var refreshRate: Double {get set}
    
    var refreshTimer: NSTimer {get set}
    
    var mutations: Bool{get set}
    
    var mutationsRate: Int{get set}
    
    // should have no defaults
    var rows: Int { get set }
    var cols: Int { get set }
    
    init(cols: Int, rows: Int)
    
    func step() -> GridProtocol
    
}
