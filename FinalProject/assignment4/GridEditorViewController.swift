//
//  GridEditorViewController.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/31/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//


import UIKit
import Foundation

class GridEditorViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
 
    var cContents: CellContent = CellContent()
    
    @IBOutlet weak var gridView: GridView!
    
    var instrumentationController: InstrumentationTableViewController!
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        // convert grid to tuples
        let cContents = SimulationViewController().gridToCellContent(gridView.grid)
        
        cContents.title = titleField.text!
        
        // save new CellContent instance
        Storage.sharedInstance.cellContents[instrumentationController.selected] = cContents
        
        Persist().storeData()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
    
        self.dismissViewControllerAnimated(false, completion: nil)

    }
    
    
    @IBOutlet weak var fileContents: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleField.text = cContents.title
        
        let max = cContents.getLargestRowCol()
        
        gridView.grid = Grid(cols: max.0, rows: max.1)
     
        gridView.points = cContents.living
        
        
        fileContents.text = String(cContents.living)
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

    
    
}








