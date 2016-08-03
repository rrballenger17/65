//
//  SimulationViewController.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/15/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit
import Foundation

class SimulationViewController: UIViewController, EngineDelegate {
    
    @IBAction func resetButton(sender: AnyObject) {
        
        let c = gridView.grid.cols
        let r = gridView.grid.rows
        
        StandardEngine.sharedInstance.cols = c
        StandardEngine.sharedInstance.rows = r
        
        
        // Note: Changing the cols or rows sends a notification to the statistics controller
        // as required
        
    }
    
    func gridToCellContent(board: GridProtocol)->CellContent{
        
        let newContent = CellContent()
        
        for x in 0..<board.cols{
            for y in 0..<board.rows{
                
                switch board[x, y]{
                case CellState.Living, CellState.Born:
                    newContent.living.append((x, y))
                default: break
                }
            }
        }
        
        return newContent
    }
    
    
    var saveTitle: UITextField = UITextField()

    
    @IBAction func saveButton(sender: AnyObject) {
        
        StandardEngine.sharedInstance.refreshTimer.invalidate()
        
        (tabBarController?.viewControllers![0] as! InstrumentationViewController).refreshSwitch.on = false
        
        
        let newContent = gridToCellContent(gridView.grid)
        
        let alert = UIAlertController(title: "Save as", message: nil, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {(action: UIAlertAction) in
            
            guard let title = self.saveTitle.text else {
                print("Error: couldn't retrieve user input")
                return
            }
            
            newContent.title = title
            
        
            Storage.sharedInstance.cellContents.append(newContent)
            
            
            Persist().storeData()
            
        }))
        
        alert.addTextFieldWithConfigurationHandler(){ (field: UITextField) in
            self.saveTitle = field
            
        }
        
        alert.view.setNeedsLayout()
        
        self.presentViewController(alert, animated: true, completion: nil)
    
    }
    
    
    
    
    @IBOutlet weak var gridView: GridView!
    
    @IBAction func buttonPush(sender: AnyObject) {
    
        StandardEngine.sharedInstance.step()
    
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StandardEngine.sharedInstance.delegate = self
        
        gridView.grid = StandardEngine.sharedInstance.grid
    }
    
    
    var sentBoard: CellContent? = nil
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        
        if let sentBoard = sentBoard {
            
            
            let points = sentBoard.living
            
            //points.appendContentsOf(appDelegate.contents!.born)
            
            let max = sentBoard.getLargestRowCol()
            
            StandardEngine.sharedInstance.cols = max.0
            StandardEngine.sharedInstance.rows = max.1
            
            gridView.grid = StandardEngine.sharedInstance.grid
            
            gridView.points = points
            
            self.sentBoard = nil
            
        }

        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    func engineDidUpdate(withGrid: GridProtocol){
        
        gridView.grid = StandardEngine.sharedInstance.grid
        gridView.setNeedsDisplay()
     
    }
        
    
}








