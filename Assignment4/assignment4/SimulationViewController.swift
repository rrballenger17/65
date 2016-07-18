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
    
    @IBOutlet weak var gridView: GridView!
    
    @IBAction func buttonPush(sender: AnyObject) {
    
        StandardEngine.sharedInstance.step()
    
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        StandardEngine.sharedInstance.delegate = self
        
        gridView.grid = StandardEngine.sharedInstance.grid
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    func engineDidUpdate(withGrid: GridProtocol){
        
        gridView.grid = StandardEngine.sharedInstance.grid
        gridView.setNeedsDisplay()
        
        let center = NSNotificationCenter.defaultCenter()
        let note = NSNotification(name: "newGrid", object: withGrid as! Grid)
        center.postNotification(note)
                
    }
        
    
}








