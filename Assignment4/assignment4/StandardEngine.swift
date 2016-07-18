//
//  StandardEngine.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/17/16.
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
    
    // should have no defaults
    var rows: Int { get set }
    var cols: Int { get set }
    
    init(cols: Int, rows: Int)
    
    func step() -> GridProtocol
    
}



class StandardEngine: EngineProtocol {
    
    var delegate: EngineDelegate
    
    var grid: GridProtocol{
        get{
            return myGrid
        }
    }
    
    // needs to default to 0
    var refreshRate: Double = 0
    
    var refreshTimer: NSTimer
    
    // should have no defaults
    var rows: Int{
        didSet {
            myGrid = Grid(cols: cols, rows: rows)
        }
    }
    
    var cols: Int{
        didSet {
            myGrid = Grid(cols: cols, rows: rows)
        }
    }
    
    required init(cols: Int, rows: Int){
        
        self.cols = cols
        self.rows = rows
        
        refreshTimer = NSTimer()
        
        delegate = emptyDelegate()
        
        myGrid = Grid(cols: cols, rows: rows)
        
    }
    
    func step()->GridProtocol{
        
        let secondArray = Grid(cols: cols, rows: rows)
        
        for x in 0...cols-1{
            for y in 0...rows-1{
                
                let tuples = myGrid.neighbors((x,y))
                
                var neighs = 0
                
                for t in tuples{
                    if(myGrid[t.0, t.1] == CellState.Living || myGrid[t.0, t.1] == CellState.Born){
                        neighs = neighs + 1
                    }
                    
                }
                
                let current = myGrid[x, y]
                
                switch (current, neighs) {
                    
                case (CellState.Living, 2..<4),(CellState.Born, 2..<4):
                    secondArray[x, y] = CellState.Living
                    
                case (CellState.Empty, 3), (CellState.Died, 3):
                    secondArray[x, y] = CellState.Born
                    
                default:
                    if(current == CellState.Living || current == CellState.Born){
                        secondArray[x, y] = CellState.Died
                    }else{
                        secondArray[x, y] = CellState.Empty
                    }
                    
                }
            }
        }
        
        myGrid = secondArray
        
        return myGrid
        
    }
    
    private var myGrid: GridProtocol{
        didSet{
            delegate.engineDidUpdate(self.myGrid)
            
            let center = NSNotificationCenter.defaultCenter()
            let note = NSNotification(name: "newGrid", object: self.myGrid as! Grid)
            center.postNotification(note)
        }
    }
    

    private static var _sharedInstance = StandardEngine(cols: 10, rows: 10)
    
    static var sharedInstance: StandardEngine {
        get {
            return _sharedInstance
        }
    }
    
}


class emptyDelegate: EngineDelegate {
    
    func engineDidUpdate(withGrid: GridProtocol){
        
    }
}

