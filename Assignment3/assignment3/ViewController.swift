//
//  ViewController.swift
//  assignment3
//
//  Created by Ryan Ballenger on 7/9/16.
//  Copyright © 2016 Ryan Ballenger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func button(sender: AnyObject) {
        
        gridView.forward()
    }
    
    @IBOutlet weak var gridView: GridView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        gridView.rows = 20
        gridView.cols = 20
        gridView.livingColor = UIColor.greenColor()
        gridView.bornColor = UIColor.greenColor().colorWithAlphaComponent(0.6)
        gridView.emptyColor = UIColor.darkGrayColor()
        gridView.diedColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
        gridView.gridColor = UIColor.blackColor()
        gridView.gridWidth = 2.0
        
        gridView.setNeedsDisplay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

