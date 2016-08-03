//
//  StatisticsViewController.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/15/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Do any additional setup after loading the view, typically from a nib.
        
        let sel = #selector(self.watchForNotifications(_:))
        let center  = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "newGrid", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        watchForNotifications(NSNotification(name: "getCurrentCounts", object: StandardEngine.sharedInstance.grid as! Grid))
    }
    
    @IBOutlet weak var livingLabel: UILabel!
    
    @IBOutlet weak var bornLabel: UILabel!
    
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    
    @IBOutlet weak var diedLabel: UILabel!
    
    
    func watchForNotifications(notification:NSNotification) {
        let grid = notification.object as! Grid
        
        let cols = grid.cols
        let rows = grid.rows
        
        var living = 0
        
        var born = 0
        
        var died = 0
        
        var empty = 0
        
        for x in 0...cols-1{
            for y in 0...rows-1{
                let state = grid[x, y]
                
                switch state{
                case CellState.Living:
                    living = living + 1
                case CellState.Born:
                    born = born + 1
                case CellState.Empty:
                    empty = empty + 1
                case CellState.Died:
                    died = died + 1
                }
            }
        }
        
        livingLabel.text = String(living)
        bornLabel.text = String(born)
        emptyLabel.text = String(empty)
        diedLabel.text = String(died)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
