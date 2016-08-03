//
//  InstrumentationTableViewController.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/31/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import Foundation
import UIKit

class InstrumentationTableViewController: UITableViewController {
    
    
    var url = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
    
    
    func downloadData(){
        data.request(url, sender: self, completionHandler: { (response: [String], arrays: [[(Int,Int)]]) in
            
            let storage = Storage.sharedInstance
            
            storage.cellContents = []
            
            for c in 0..<arrays.count{
                let board = CellContent()
                board.living = arrays[c]
                board.title = response[c]
                storage.cellContents.append(board)
            }
            
            Persist().storeData()
            
            let block = NSBlockOperation {
                self.tableView.reloadData()
            }
            
            NSOperationQueue.mainQueue().addOperation(block)
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p = Persist()
        
        let result = p.getStoredData()
        
        Storage.sharedInstance.cellContents = []
        
        if let result = result{

            Storage.sharedInstance.cellContents = result.cellContents

        }else{
            
            downloadData()
        }
        
    }
    
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Simulate"
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            simulate(indexPath.row)
            
            // reset swiped cell
            tableView.reloadData()

        }
    }
    
    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    var selected: Int = -1
    
    var data = DataHandler()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.sharedInstance.cellContents.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        guard let cell = tableView.dequeueReusableCellWithIdentifier("cellId") else {
            preconditionFailure("Error: tableView.dequeueReusableCellWithIdentifier")
        }
        
        //let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("Error: cell.textLabel")
        }
        
        nameLabel.text = Storage.sharedInstance.cellContents[indexPath.row].title
        
        return cell
    }
    
    
    func simulate(index: Int){
        
        let controller = tabBarController?.viewControllers?[1] as! SimulationViewController
        
        controller.sentBoard = Storage.sharedInstance.cellContents[index]
        
        tabBarController?.selectedIndex = 1
        
    }
    

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selected = indexPath.row
        
        self.performSegueWithIdentifier("editSegue", sender: self)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editSegue"{
            
            let controller = segue.destinationViewController as! GridEditorViewController
            
            controller.cContents = Storage.sharedInstance.cellContents[selected]
            
            controller.instrumentationController = self
            
        }
    }
    
    




}






class CustomButton: UIButton{
    
    
    
    var row : Int = -1
}






