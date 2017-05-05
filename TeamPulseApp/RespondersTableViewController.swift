//
//  RespondersTableViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/26/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

class RespondersTableViewController: UITableViewController {
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var namesRef: FIRDatabaseReference!
    var graphRef: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    var selectedTeam: String!
    var selectedSurvey: String!
    var names: [String]!  = []
    var score1: [Int]! = []
    var score2: [Int]! = []
    var score3: [Int]! = []
    var score4: [Int]! = []
    var score5: [Int]! = []
    
    override func viewDidLoad() {
        print(Responder.survey)
        print(Responder.team)
        namesRef = ref.child("Teams").child(Responder.team).child(Responder.survey).child("Responses")
        namesRef.observe(.value, with: { (snapshot) in
            if snapshot.hasChildren(){
                for child in snapshot.children{
                    if let node = child as? FIRDataSnapshot, var name = node.key as? String{
                        print(name)
                        if(!(self.names.contains(name))){
                            self.names.append(name)
                        }
                    }
                }
                self.tableView.reloadData()
            }
        })
        print(names)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onRefresh(_ sender: UIBarButtonItem) {
        self.viewDidAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "responderName"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RespondersTableViewCell else{
            fatalError("The dequeued cell is not an instance of PlayerSurveyListTableViewCell")
        }
        //print(TeamList.surveyList.count)
        cell.responderName.text = self.names[indexPath.row]
        return cell
    }
    
}
