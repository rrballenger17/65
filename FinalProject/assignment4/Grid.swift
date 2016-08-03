//
//  Grid.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/17/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation

//Create a class Grid which implements the GridProtocol and holds a collection of CellStates.
class Grid: GridProtocol {
    var rows: Int
    var cols: Int
    
    required init(cols: Int, rows: Int){
        self.rows = rows
        self.cols = cols
        
        grid = initializeGrid()
        
    }
    
    func neighbors(tuple: (Int, Int)) -> [(Int, Int)]{
        
        return getNeighbors(grid, x: tuple.0, y: tuple.1)
        
    }
    
    subscript(col: Int, row: Int) -> CellState {
        get {
            return grid[col][row]
        }
        set(newValue) {
            grid[col][row] = newValue
        }
    }
    
    // collection of cell states
    private var grid: [[CellState]] = []

    // wrap values outside board when finding neighbors
    private func wrap(position: Int, vertical: Bool)-> Int{
        var coord = position
        let count = vertical ? rows : cols
        if coord < 0 {
            coord = coord + count
        }
        if coord > count-1 {
            coord = coord - count
        }
        return coord
    }
    
    // find horizontal neighbors
    private func horizontalNeighbors(board: Array<Array<CellState>>, x: Int, y: Int, left: Bool)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        var leftX = x
        
        if(left){
            leftX = leftX - 1
        }else{
            leftX = leftX + 1
        }
        
        leftX = wrap(leftX, vertical: false)
        for var newY in [y-1, y, y+1]{
            
            newY = wrap(newY, vertical: true)
            
            all.append((leftX, newY))
        }
        return all
    }
    
    // find vertical neighbors
    func verticalNeighbors(board: Array<Array<CellState>>, x: Int, y: Int)-> [(Int, Int)]{
        var below = y - 1
        below = wrap(below, vertical: true)
        var above = y + 1
        above = wrap(above, vertical: true)
        var all = [(x,below)]
        all.append((x, above))
        return all
    }
    
    // find all the neighbors and convert them to tuples
    private func getNeighbors(board: Array<Array<CellState>>, x: Int, y: Int)-> [(Int, Int)]{
        var all = [(Int, Int)]()
        all.appendContentsOf(horizontalNeighbors(board, x: x, y: y, left: true))
        all.appendContentsOf(horizontalNeighbors(board, x: x, y: y, left: false))
        all.appendContentsOf(verticalNeighbors(board, x: x, y: y))
        return all
    }
    
    // initialize a CellState array of arrays based on the row and col dimensions
    private func initializeGrid() -> [[CellState]]{
        var newGrid: [[CellState]] = []
        for x in 0...(cols - 1){
            for y in 0...(rows - 1){
                
                if y == 0{
                    newGrid.append([])
                }
                newGrid[x].append(CellState.Empty)
            }
        }
        return newGrid
    }
    
}
