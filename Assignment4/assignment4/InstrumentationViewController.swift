//
//  InstrumentationViewController.swift
//  assignment4
//
//  Created by Ryan Ballenger on 7/15/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    
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
                userInfo: ["name": "fred"],
                repeats: true)
        }
    
    }
    
    
    func timerDidFire(sender: AnyObject){
        StandardEngine.sharedInstance.step()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshSwitch.on = false
        
        colsText.text = String(StandardEngine.sharedInstance.cols)
        colsStepper.value = Double(StandardEngine.sharedInstance.cols)
        
        rowsText.text = String(StandardEngine.sharedInstance.rows)
        rowsStepper.value = Double(StandardEngine.sharedInstance.rows)
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

