//
//  MyTeamTableViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/23/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

class MyTeamTableViewController: UITableViewController {
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var teamsRef: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    var teamsDict: [String: AnyObject] = [:]
    var teams = [String]()
    var selectedTeam: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testRef = ref.child("Teams")
        testRef.observe(.value, with: { (snapshot) in
            if snapshot.hasChildren(){
                for child in snapshot.children{
                    if let node = child as? FIRDataSnapshot, let _ = node.key as String?{
                        for child in node.children{
                            let item = child as? FIRDataSnapshot
                            if (item?.key == "0NumPlayers"){
//                                if(TeamList.teamList.isEmpty){
//                                    TeamList.teamList.append(TeamID(teamID: node.key, numPlayers: item?.value as! Int))
//                                }
//                                else{
//                                    var contained: Bool = false
//                                    for element in TeamList.teamList{
//                                        if (element.teamID == node.key){
//                                            contained = true
//                                        }
//                                    }
//                                    if(!contained){
//                                         TeamList.teamList.append(TeamID(teamID: node.key, numPlayers: item?.value as! Int))
//                                    }
//                                }
                                var contained: Bool = false
                                for element in TeamList.teamList{
                                    if (element.teamID == node.key){
                                        contained = true
                                    }
                                }
                                if(!contained){
                                    TeamList.teamList.append(TeamID(teamID: node.key, numPlayers: item?.value as! String))
                                }
                            }
                        }
                        self.teams.append(node.key)
                    }
                }
                self.tableView.reloadData()
            }
        })
        // Do any additional setup after loading the view, typically from a nib.
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
        return TeamList.teamList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MyTeamTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyTeamTableViewCell else{
            fatalError("The dequeued cell is not an instance of MyTeamTableViewCell")
        }
        //print(TeamList.teamList.count)
        cell.teamID.text = TeamList.teamList[indexPath.row].teamID
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!) as! MyTeamTableViewCell;
        
        selectedTeam = currentCell.teamID.text
        performSegue(withIdentifier: "selectedTeam", sender: self)
    }
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath!) {
//        print("You selected cell #\(indexPath.row)!")
//        
//        // Get Cell Label
//        let indexPath = tableView.indexPathForSelectedRow;
//        let currentCell = tableView.cellForRow(at: indexPath!) as! MyTeamTableViewCell;
//        TeamID.teamID = currentCell.teamID.text!
//        selectedTeam = currentCell.teamID.text
////        performSegue(withIdentifier: "selectedTeam", sender: self)
//        
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "selectedTeam") {
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! SurveyListViewController
            // your new view controller should have property that will store passed value
            viewController.selectedTeam = selectedTeam
        }
        
    }

}
