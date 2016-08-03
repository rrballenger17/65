//
//  InstrumentationViewController.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/15/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController{
    
    
    ///////////////////////
    /// end table delegation
    //////////////////////
   
    @IBOutlet weak var mutationsSlider: UISlider!
    @IBOutlet weak var mutationsSwitch: UISwitch!
    
    @IBAction func mutationsChange(sender: UISwitch) {
        StandardEngine.sharedInstance.mutations = sender.on
 
    }
    
    
    @IBOutlet weak var mutationText: UITextField!
    
    @IBAction func mutationsRateChange(sender: AnyObject) {
    
        StandardEngine.sharedInstance.mutationsRate = Int(mutationsSlider.value)
        
        mutationText.text = String(1.0/mutationsSlider.value)
        
    }
    
    @IBOutlet weak var rowsText: UITextField!
    
    @IBAction func rowsChange(sender: UIStepper) {
        rowsText.text = String(sender.value)
    
        if sender.value == 0.0 {
            return
        }
        
        StandardEngine.sharedInstance.rows = Int(sender.value)
    
    }
    
    @IBOutlet weak var rowsStepper: UIStepper!
    
    
    
    @IBOutlet weak var colsText: UITextField!
    
    @IBAction func colsChange(sender: UIStepper) {
        colsText.text = String(sender.value)
        
        if sender.value == 0.0 {
            return
        }
        
        StandardEngine.sharedInstance.cols = Int(sender.value)
    }
    
    @IBOutlet weak var colsStepper: UIStepper!
    
    
    @IBOutlet weak var refreshSwitch: UISwitch!
    
    @IBAction func refreshSwitchClick(sender: AnyObject) {
        if(!refreshSwitch.on){
            StandardEngine.sharedInstance.refreshTimer.invalidate()
            return
        }
        
        refreshChange(slider)
    }
    
    
    @IBOutlet weak var refreshText: UITextField!
    
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func refreshChange(sender: UISlider) {
        refreshText.text = String(sender.value)
        
        if(!refreshSwitch.on){
            StandardEngine.sharedInstance.refreshTimer.invalidate()
            return
        }
        
        let refresh = NSTimeInterval(1.0/Double(sender.value))
        
        StandardEngine.sharedInstance.refreshTimer.invalidate()

        if refresh != 0 {
            
            let sel = #selector(self.timerDidFire(_:))
            StandardEngine.sharedInstance.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refresh,
                target: self,
                selector: sel,
                userInfo: ["name": "dory"],
                repeats: true)
        }
    
    }
    
    
    func timerDidFire(sender: AnyObject){
        StandardEngine.sharedInstance.step()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshSwitch.on = false
        
        mutationsSwitch.on = false
        
        mutationText.text = String(1/mutationsSlider.value)
        
        
        colsText.text = String(StandardEngine.sharedInstance.cols)
        colsStepper.value = Double(StandardEngine.sharedInstance.cols)
        
        rowsText.text = String(StandardEngine.sharedInstance.rows)
        rowsStepper.value = Double(StandardEngine.sharedInstance.rows)
        // Do any additional setup after loading the view, typically from a nib.
        
        addNavBar()
        
        
    }
    
    let navBarHeight = 44
    
    func addNavBar(){
        
        let height = Int(UIApplication.sharedApplication().statusBarFrame.size.height)
        
        let width = Int(self.view.frame.size.width)
        
        let bar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: height , width: width , height: navBarHeight))
        self.view.addSubview(bar);
        
        let item = UINavigationItem(title: "Instrumentation");
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.addRow(_:)));
        item.rightBarButtonItem = addButton
        
        bar.setItems([item], animated: false);
        
    }
    
    
    
    
    func addRow(sender: AnyObject){

        Storage.sharedInstance.cellContents.append(CellContent())
        
        Persist().storeData()
        
        let controller = self.childViewControllers[0] as! InstrumentationTableViewController

        controller.tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // reset text field
        urlField.text = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
        
        rowsStepper.value = Double(StandardEngine.sharedInstance.rows)
        
        rowsText.text = String(StandardEngine.sharedInstance.rows)
        
        colsStepper.value = Double(StandardEngine.sharedInstance.cols)
        
        colsText.text = String(StandardEngine.sharedInstance.cols)
        
    }
    
    @IBOutlet weak var container: UIView!
    
    
    @IBAction func reloadButton(sender: AnyObject) {
        let controller = self.childViewControllers[0] as! InstrumentationTableViewController

        controller.url = urlField.text!
        
        Persist().clearData()
        
        controller.downloadData()
        
        controller.tableView.reloadData()
        
    }


    
    
    
    @IBOutlet weak var urlField: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

