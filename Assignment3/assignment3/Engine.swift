//
//  Engine.swift
//  Assignment2
//
//  Created by Ryan Ballenger on 7/5/16.
//  Copyright © 2016 ios. All rights reserved.
//

import Foundation

// Note: I recieved my grade on this shortly before #3 was due and did not have time
// to make the suggested changes.

class Engine{
    
    var boardDim = 20
    
    func wrap(position: Int)-> Int{
        
        var coord = position
        
        if coord < 0 {
            coord = coord + boardDim
        }
        
        if coord > boardDim-1 {
            coord = coord - boardDim
        }
        
        return coord
    }
    

    
    func leftNeighbors(board: Array<Array<CellState>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        
        var leftX = x-1
        
        leftX = wrap(leftX)
        
        for var newY in [y-1, y, y+1]{
            
            newY = wrap(newY)
            
            all.append((leftX, newY))
        }
        
        return all
    }
    
    func rightNeighbors(board: Array<Array<CellState>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        
        var rightX = x+1
        
        rightX = wrap(rightX)
        
        for var newY in [y-1, y, y+1]{
            
            newY = wrap(newY)
            
            all.append((rightX, newY))
        }
        
        return all
    }
    
    func verticalNeighbors(board: Array<Array<CellState>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var below = y - 1
        
        below = wrap(below)
        
        var above = y + 1
        
        above = wrap(above)
        
        var all = [(x,below)]
        
        all.append((x, above))
        
        return all
        
    }
    
    func makeCellStateArray(board: Array<Array<CellState>>)->Array<Array<CellState>>{
        
        var holder = Array<Array<CellState>>()
        
        for _ in 0...boardDim - 1{
            
            var newCellState = Array<CellState>()
            
            for _ in 0...boardDim - 1{
                newCellState.append(CellState.Empty)
            }
            
            holder.append(newCellState)
        }
        
        return holder
    }
    
    func neighbors(board: Array<Array<CellState>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        all.appendContentsOf(leftNeighbors(board, x: x, y: y))
        all.appendContentsOf(rightNeighbors(board, x: x, y: y))
        all.appendContentsOf(verticalNeighbors(board, x: x, y: y))
        
        return all
    }
    

    
    func step(board: Array<Array<CellState>>)->Array<Array<CellState>>{
        
        var secondArray = makeCellStateArray(board)
        
        for x in 0...boardDim-1{
            for y in 0...boardDim-1{
                
                let tuples = neighbors(board, x: x, y: y)
                
                var neighs = 0
                
                for t in tuples{
                    if(board[t.0][t.1] == CellState.Living || board[t.0][t.1] == CellState.Born){
                        neighs = neighs + 1
                    }
                    
                }
                
                let current = board[x][y]
                
                switch (current, neighs) {
                    
                case (CellState.Living, 2..<4),(CellState.Born, 2..<4):
                    secondArray[x][y] = CellState.Living
                    
                case (CellState.Empty, 3), (CellState.Died, 3):
                    secondArray[x][y] = CellState.Born
                    
                default:
                    if(current == CellState.Living || current == CellState.Born){
                        secondArray[x][y] = CellState.Died
                    }else{
                        secondArray[x][y] = CellState.Empty
                    }
                    
                }
            }
        }
        
        return secondArray
        
    }
    
    /*
    func countNeighborsAll(board: Array<Array<CellState>>)-> Array<Array<Int>>{
        
        var neighborsArr = makeIntArray(board)
        
        // for all spots on the board
        for x in 0...boardDim-1{
            for y in 0...boardDim-1{
                
                let tuples = neighbors(board, x: x, y: y)
                
                var neighs = 0
                
                for t in tuples{
                    if(board[t.0][t.1] == CellState.Living || board[t.0][t.1] == CellState.Born){
                        neighs = neighs + 1
                    }
                }
                
                neighborsArr[x][y] = neighs
                
            }
        }
        
        return neighborsArr
    }*/
    
    func makeIntArray(board: Array<Array<CellState>>)->Array<Array<Int>>{
        
        var holder = Array<Array<Int>>()
        
        for _ in 0...boardDim - 1{
            
            var newInt = Array<Int>()
            
            for _ in 0...boardDim-1{
                newInt.append(-1)
            }
            
            holder.append(newInt)
        }
        
        return holder
    }
    
    // an initializer if the class changes in the future and a variable needs initiated
    init(){}
    
}










