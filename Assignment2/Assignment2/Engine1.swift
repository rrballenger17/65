//
//  Engine1.swift
//  Assignment2
//
//  Created by Ryan Ballenger on 7/5/16.
//  Copyright © 2016 ios. All rights reserved.
//

import Foundation

class Engine1{
    
    
    
    func wrap(position: Int)-> Int{
        
        var coord = position
        
        if coord < 0 {
            coord = coord + 10
        }
        
        if coord > 9 {
            coord = coord - 10
        }
        
        return coord
    }
    
    
    
    func leftNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        
        var leftX = x-1
        
        leftX = wrap(leftX)
        
        for var newY in [y-1, y, y+1]{
            
            newY = wrap(newY)
            
            all.append((leftX, newY))
        }
        
        return all
    }
    
    func rightNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        
        var rightX = x+1
        
        rightX = wrap(rightX)
        
        for var newY in [y-1, y, y+1]{
            
            newY = wrap(newY)
            
            all.append((rightX, newY))
        }
        
        return all
    }
    
    func verticalNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var below = y - 1
        
        below = wrap(below)
        
        var above = y + 1
        
        above = wrap(above)
        
        var all = [(x,below)]
        
        all.append((x, above))
        
        return all
        
    }
    
    
    
    
    func makeBoolArray(board: Array<Array<Bool>>)->Array<Array<Bool>>{
        
        var holder = Array<Array<Bool>>()
        
        for _ in 0...board.count - 1{
            
            var newBool = Array<Bool>()
            
            for _ in 0...9{
                newBool.append(false)
            }
            
            holder.append(newBool)
        }
        
        return holder
    }
    
    
    
    
    func neighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> [(Int, Int)]{
        
        var all = [(Int, Int)]()
        all.appendContentsOf(leftNeighbors(board, x: x, y: y))
        all.appendContentsOf(rightNeighbors(board, x: x, y: y))
        all.appendContentsOf(verticalNeighbors(board, x: x, y: y))
        
        return all
    }
    
    
    func step2(board: Array<Array<Bool>>)->Array<Array<Bool>>{
        
        var secondArray = makeBoolArray(board)
        
        for x in 0...9{
            for y in 0...9{
                
                let tuples = neighbors(board, x: x, y: y)
                
                var neighs = 0
                
                for t in tuples{
                    neighs = neighs + Int(board[t.0][t.1])
                }
                                
                let current = board[x][y]
                
                switch (current, neighs) {
                    
                case (true, 2..<4):
                    secondArray[x][y] = true
                    
                case (false, 3):
                    secondArray[x][y] = true
                    
                default:
                    secondArray[x][y] = false
                }
                
            }
        }
        
        return secondArray
        
        
        
    }
    
    
    func countNeighborsAll(board: Array<Array<Bool>>)-> Array<Array<Int>>{
        var neighborsArr = makeIntArray(board)
        
        // for all spots on the board
        for x in 0...9{
            for y in 0...9{
                
                let tuples = neighbors(board, x: x, y: y)
                
                var neighs = 0
                
                for t in tuples{
                    neighs = neighs + Int(board[t.0][t.1])
                }
                
                neighborsArr[x][y] = neighs
                
            }
        }
        
        return neighborsArr
    }
    
    func makeIntArray(board: Array<Array<Bool>>)->Array<Array<Int>>{
        
        var holder = Array<Array<Int>>()
        
        for _ in 0...board.count - 1{
            
            var newInt = Array<Int>()
            
            for _ in 0...9{
                newInt.append(-1)
            }
            
            holder.append(newInt)
        }
        
        return holder
    }
    
    // an initializer if the class changes in the future and a variable needs initiated
    init(){}
    
}










