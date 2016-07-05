//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Ryan Ballenger on 7/3/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    // print int 2d array by row
    func printBoardInt(board: Array<Array<Int>>){
        for y in 0...9{
            
            var str = ""
            
            for x in 0...9{
                str += String(board[x][y]) + "\t"
            }
            print(str)
            
        }
    }
    
    // print bool 2d array by row
    func printBoardBool(board: Array<Array<Bool>>){
        for y in 0...9{
            
            var str = ""
            
            for x in 0...9{
                str += String(board[x][y]) + "\t"
            }
            print(str)
        }
    }
    
    
    func countLive(board: Array<Array<Bool>>)->Int{
        
        var sum = 0
        
        for x in 0...9{
            for y in 0...9{
                
                //print(x)
                
                sum = sum + Int(board[x][y])
                
                
            }
        }
        
        return sum
        
    }
    
    // create a 2d array of random bool's
    func createRandomArray()->Array<Array<Bool>>{
        var board = Array<Array<Bool>>()
        
        for _ in 0...9{
            
            var inside = Array<Bool>()
            
            for _ in 0...9{
                                
                if arc4random_uniform(3) == 1 {
                    inside.append(true)
                } else {
                    inside.append(false)
                }
            }
            
            board.append(inside)
        }
        
        return board
    }

    /*
    func printRow(board: Array<Array<Bool>>){
        
        var str = ""
        
        for x in 0...9{
            str = str + String(board[x][2])
        }
        
        print(str)
    }*/
    
    
    @IBAction func run(sender: AnyObject) {
        
        let board = createRandomArray()
        
        // print board
        printBoardBool(board)
        
        // print neighbor counts
        printBoardInt(countNeighborsAll(board))
        
        // ***** do the step process
        var secondArray = makeBoolArray(board)
        
        for x in 0...9{
            for y in 0...9{
                
                let neighs = countNeighbors(board, x: x, y: y)
                
                let current = board[x][y]
                
                switch (current, neighs) {
                
                // alive and 2 or 3 true neighbors
                case (true, 2..<4):
                                        
                    secondArray[x][y] = true
                
                // not alive and exactly 3 true neighbors
                case (false, 3):
                    secondArray[x][y] = true
                    
                // all other cases don't result in alive
                default:
                    secondArray[x][y] = false
                }
                
            }
        }
        
        let newBoard = secondArray
        // ***** end step process
        
        printBoardBool(newBoard)
        
        textView.text = "Before: \(countLive(board))\nAfter: \(countLive(newBoard))"
    }
    

    
    
   
    
    
    
    
    
    
    
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
    
    // count true neighbors to the left
    func leftNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> Int{
        
        var sum = 0
        
        var leftX = x-1
        
        leftX = wrap(leftX)
        
        for var newY in [y-1, y, y+1]{
         
            newY = wrap(newY)
            
            sum = sum + Int(board[leftX][newY])
        }
        
        return sum
    }
    
    // count true neighbors to the right
    func rightNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> Int{
        
        var sum = 0
        
        var rightX = x+1
        
        rightX = wrap(rightX)
        
        for var newY in [y-1, y, y+1]{
            
            newY = wrap(newY)
            
            sum = sum + Int(board[rightX][newY])
        }
        
        return sum
    }
    
    // count true neighbors above and below
    func verticalNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> Int{
    
        var below = y - 1
        
        below = wrap(below)
        
        var above = y + 1
        
        above = wrap(above)
        
        var sum = Int(board[x][below])
        
        sum = sum + Int(board[x][above])
        
        return sum
    
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
    
    
    
    // count true neighbors including ones to the left, right, and vertical aligned
    func countNeighbors(board: Array<Array<Bool>>, x: Int, y: Int)-> Int{
        
        var sum = 0
        sum = sum + leftNeighbors(board, x: x, y: y)
        sum = sum + rightNeighbors(board, x: x, y: y)
        sum = sum + verticalNeighbors(board, x: x, y: y)
        
        return sum
    }
    
    
    /*
    func begin(board: Array<Array<Bool>>)->Array<Array<Bool>>{
        
        var secondArray = makeBoolArray(board)
        
        for x in 0...9{
            for y in 0...9{
             
                let neighs = countNeighbors(board, x: x, y: y)
                
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
        
    }*/
    
    // make an array containing the number of true neighbors for each spot
    func countNeighborsAll(board: Array<Array<Bool>>)-> Array<Array<Int>>{
        var neighbors = makeIntArray(board)
        
        // for all spots on the board
        for x in 0...9{
            for y in 0...9{
                let count = countNeighbors(board, x: x, y: y)
                neighbors[x][y] = count
                
            }
        }
        
        return neighbors
    }
    
    // make a 2d array (10x10) of Int's, all with value -1
    func makeIntArray(board: Array<Array<Bool>>)->Array<Array<Int>>{
        
        var holder = Array<Array<Int>>()
        
        for _ in 0...9{
            
            var newInt = Array<Int>()
            
            for _ in 0...9{
                newInt.append(-1)
            }
            
            holder.append(newInt)
        }
        
        return holder
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Problem 2"
 
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
