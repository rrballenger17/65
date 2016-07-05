//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by Ryan Ballenger on 7/3/16.
//  Copyright © 2016 ios. All rights reserved.
//

import UIKit

class Problem3ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    // print 2d array of ints by row
    func printBoardInt(board: Array<Array<Int>>){
        for y in 0...9{
            
            var str = ""
            
            for x in 0...9{
                str += String(board[x][y]) + "\t"
            }
            print(str)
            
        }
    }
    
    // print 2d array of bool's by row
    func printBoardBool(board: Array<Array<Bool>>){
        for y in 0...9{
            
            var str = ""
            
            for x in 0...9{
                str += String(board[x][y]) + "\t"
            }
            print(str)
        }
    }
    
    // count true's in a 2d bool array
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
    
    // create a random 10x10 array of bool's
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
    
    
    func printRow(board: Array<Array<Bool>>){
        
        var str = ""
        
        for x in 0...9{
            str = str + String(board[x][2])
        }
        
        print(str)
    }
    
    // button action - create a board, print states, and make a step forward
    @IBAction func run(sender: AnyObject) {
        
        let engine = Engine()
        
        let board = createRandomArray()
        
        // print board
        printBoardBool(board)
        
        // print neighbor counts
        printBoardInt(engine.countNeighborsAll(board))
        
        let newBoard = engine.step(board)
        
        printBoardBool(newBoard)
        
        textView.text = "Before: \(countLive(board))\nAfter: \(countLive(newBoard))"
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Problem 3"
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}