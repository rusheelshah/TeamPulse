//
//  GraphTabBarViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/24/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//


import UIKit
import Firebase

class GraphTabBarViewController: UIViewController {
    var selectedTeam: String!
    var selectedSurvey: String!
    override func viewDidLoad() {
        self.title = selectedTeam
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

