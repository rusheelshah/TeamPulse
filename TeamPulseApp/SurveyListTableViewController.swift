//
//  SurveyListTableViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/24/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

class SurveyListViewController: UITableViewController {
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var surveysRef: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    var surveysDict: [String: AnyObject] = [:]
    var selectedTeam: String!
    var selectedSurvey: String!
    @IBOutlet weak var teamName: UINavigationItem!
    override func viewDidLoad() {
        TeamList.surveyList.removeAll()
        teamName.title = self.selectedTeam
        if(self.selectedTeam != nil){
            let testRef = ref.child("Teams").child(self.selectedTeam)
            testRef.observe(.value, with: { (snapshot) in
                if snapshot.hasChildren(){
                    for child in snapshot.children{
                        if let node = child as? FIRDataSnapshot{
                            print(node.key)
                        }
                        if let node = child as? FIRDataSnapshot, let surveyName = node.key as String?{
                            if(surveyName != "password"){
                                if(TeamList.surveyList.isEmpty){
                                    let newSurvey = Survey(name: surveyName)
                                    TeamList.surveyList.append(newSurvey)
                                }
                                else{
                                    for item in TeamList.surveyList{
                                        TeamList.surveyNameList.append(item.name)
                                    }
                                    if(!(TeamList.surveyNameList.contains(surveyName))){
                                        let newSurvey = Survey(name: surveyName)
                                        TeamList.surveyList.append(newSurvey)
                                    }
                                }

                            }
                        }
                    }
                    print(TeamList.surveyList.count)
                    self.tableView.reloadData()
                }
            })

        }
        super.viewDidLoad()
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
        return TeamList.surveyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SurveyTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SurveyListTableViewCell else{
            fatalError("The dequeued cell is not an instance of SurveyListTableViewCell")
        }
        print(TeamList.surveyList.count)
        cell.surveyName.text = TeamList.surveyList[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!) as! SurveyListTableViewCell;
        
        self.selectedSurvey = currentCell.surveyName.text
        performSegue(withIdentifier: "selectSurvey", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "addSurvey") {
            
            guard let navigationController = segue.destination as? UINavigationController else { return }
            
            // initialize new view controller and cast it as your view controller
            let viewController = navigationController.viewControllers.first as! AddNewSurveyViewController
            // your new view controller should have property that will store passed value
            viewController.currentTeam = selectedTeam
        }
        else if (segue.identifier == "selectSurvey"){
            Responder.survey = self.selectedSurvey
            Responder.team = self.selectedTeam
            guard let tabBarController = segue.destination as? UITabBarController else {
                return }
            
            guard (tabBarController.viewControllers?.first as? UINavigationController) != nil else { return }
            
        }
        
    }
    
    
}
