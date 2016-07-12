//
//  GridView.swift
//  assignment3
//
//  Created by Ryan Ballenger on 7/10/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {

    @IBInspectable var rows: Int = 20 {
        didSet {
            initializeGrid()
        }
    }
    
    @IBInspectable var cols: Int = 20 {
        didSet {
            initializeGrid()
        }
    }
    
    @IBInspectable var livingColor: UIColor = UIColor.blueColor()
    @IBInspectable var emptyColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable var bornColor: UIColor = UIColor.greenColor()
    @IBInspectable var diedColor: UIColor = UIColor.brownColor()
    @IBInspectable var gridColor: UIColor = UIColor.blackColor()
    
    @IBInspectable var gridWidth: CGFloat = 0.5

    var grid: [[CellState]] = [[]]
    
    let dim = 14
    
    // create the grid of size col x row with all CellState.Empty values
    func initializeGrid(){
        grid = []
        
        for x in 0...(cols - 1){
            for y in 0...(rows - 1){
                
                if y == 0{
                    grid.append([])
                }
                
                grid[x].append(CellState.Empty)
                
                // commented out: initiate each column to a different state
                /*
                var mod = x%4
                
                print(mod)
                
                if mod == 0 {
                    grid[x].append(CellState.Born)
                }else if mod == 1{
                    grid[x].append(CellState.Living)
                }else if mod == 2{
                    grid[x].append(CellState.Died)
                }else if mod == 3{
                    grid[x].append(CellState.Empty)
                } */
                
            }
        }
    }
    
    // When a touch begins (faster response than touch ends etc) toggle the corresponding cell
    // and re-display it.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var point = CGPoint(x: 0, y: 0)
        
        for touch in touches {
            point = touch.locationInView(self)
        }
        
        let x = Int(point.x) / dim
        
        let y = Int(point.y) / dim
        
        // ignore clicks outside of grid
        if(x > cols-1 || y > rows-1){
            return
        }
        
        
        let state = grid[x][y]
        
        grid[x][y] = state.toggle(state)
        
        self.setNeedsDisplayInRect(CGRect(x: x * dim,y: y * dim, width: dim, height: dim))
        
    }

    // Draw the grid and cells contained in the parameter CGRect
    override func drawRect(rect: CGRect) {
        
        let currentContext = UIGraphicsGetCurrentContext()
        
        for x in 0...cols-1{
            
            for y in 0...rows-1{
        
                let origin = CGPoint(x: dim * x, y: dim * y)
                
                // CGRect.contains is true for points on the line
                if(rect.contains(origin)){
                    
                    // draw grid lines
                    let newRect = CGRect(origin: origin, size: CGSize(width: dim, height: dim))
                    CGContextSetStrokeColorWithColor(currentContext, gridColor.CGColor)
                    CGContextSetLineWidth(currentContext, gridWidth);
                    CGContextStrokeRect(currentContext, newRect);
                    
                    // fill cell circle
                    var color = UIColor.redColor()
                    switch grid[x][y]{
                    case CellState.Living: color = livingColor
                    case CellState.Empty: color = emptyColor
                    case CellState.Born: color = bornColor
                    case CellState.Died: color = diedColor
                    }
                    let circleRect = CGRect(x: dim*x + 1, y: dim*y + 1, width: dim-2, height: dim-2)
                    CGContextSetFillColorWithColor(currentContext, color.CGColor)
                    CGContextFillEllipseInRect(currentContext, circleRect)
                    
                }
            }
        }
    }
    
    // progress the grid 1 unit of time and redisplay the changed cells
    func forward(){
        let engine = Engine()
        
        let oldGrid = grid
        
        grid = engine.step(grid)
        
        // only re-draw changed cells
        for x in 0...cols-1{
            for y in 0...rows-1{
                if(oldGrid[x][y] != grid[x][y]){
                    self.setNeedsDisplayInRect(CGRect(x: x*dim, y: y*dim, width: dim, height: dim))
                }
            }
        }

    }
    
}

















