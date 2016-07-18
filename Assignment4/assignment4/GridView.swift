//
//  GridView.swift
//  assignment3
//
//  Created by Ryan Ballenger on 7/10/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit

@IBDesignable class GridView: UIView {
    

    @IBInspectable var rows: Int = 5

    @IBInspectable var cols: Int = 5

    
    @IBInspectable var livingColor: UIColor = UIColor.blueColor()
    @IBInspectable var emptyColor: UIColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.5)
    @IBInspectable var bornColor: UIColor = UIColor.blueColor().colorWithAlphaComponent(0.5)
    @IBInspectable var diedColor: UIColor = UIColor.lightGrayColor()
    @IBInspectable var gridColor: UIColor = UIColor.blackColor()
    
    @IBInspectable var gridWidth: CGFloat = 0.5
    
    var grid: GridProtocol = Grid(cols: 5, rows: 5){
        didSet{
            cols = grid.cols
            rows = grid.rows
            
            let larger = cols > rows ? cols : rows
            
            dim = 250/larger
        }
    }
    
    var dim = 25
    

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
        
        
        let state = grid[x, y]
        
        grid[x, y] = state.toggle(state)
        
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
                    switch grid[x, y]{
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

    
}

















