//
//  RespondersTableViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/26/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

class RespondersTableViewController: UIViewController {
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var namesRef: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    var selectedTeam: String!
    var selectedSurvey: String!
    var names: [String]!  = []
    
    override func viewDidLoad() {
        let team = self.selectedTeam
        let survey = self.selectedSurvey
        namesRef = ref.child("Teams").child(team!).child(survey!).child("Responses")
        namesRef.observe(.value, with: { (snapshot) in
            if snapshot.hasChildren(){
                for child in snapshot.children{
                    if let node = child as? FIRDataSnapshot, var name = node.key as? String{
                        if(!(self.names.contains(name))){
                            self.names.append(name)
                        }
                    }
                }
            }
        })
        print(names)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
