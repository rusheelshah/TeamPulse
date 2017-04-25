//
//  PlayerSurveyListViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/25/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

class PlayerSurveyListViewController: UITableViewController {
    var ref: FIRDatabaseReference!
    let currentPlayer = Player.playerName
    var currentSurveysRef: FIRDatabaseReference!
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
        currentSurveysRef = ref.child("Teams").child(self.currentPlayer)
        titleLabel.title = Player.playsFor
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
