//
//  PlayerSurveyListViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/25/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

//ViewController that lists available surveys for player
class PlayerSurveyListViewController: UITableViewController {
    var ref: FIRDatabaseReference!
    let currentPlayer = Player.playerName
    var currentSurveysRef: FIRDatabaseReference!
    var surveyList: [String] = []
    var selectedSurvey: String!
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var refresh: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
        currentSurveysRef = ref.child("Teams").child(Player.playsFor)
        titleLabel.title = Player.playsFor
        //pulls current surveys from firebase
        currentSurveysRef.observe(.value, with: { (snapshot) in
            if(snapshot.hasChildren()){
                print("num " + String(snapshot.childrenCount))
                for child in snapshot.children{
                    if let node = child as? FIRDataSnapshot, var _ = node.key as String?{
                        if(node.key != "password" && node.key != "0NumPlayers" && !(self.surveyList.contains(node.key))){
                            print("here: " + node.key)
                            self.surveyList.append(node.key)
                            var player = PlayerStruct(playerName: Player.playerName, surveyName: node.key, didRespond: false)
                            //shows done if player already completed the given survey
                            for item in node.children{
                                if let responders = item as? FIRDataSnapshot{
                                    if(responders.key == "Responses"){
                                        for person in responders.children{
                                            if let name = person as? FIRDataSnapshot{
                                                if(name.key == self.currentPlayer){
                                                    player.didRespond = true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            PlayerDidRespond.players.append(player)
                        }
                    }
                }
                print("Rusheel: " + String(self.surveyList.count))
                self.tableView.reloadData()
            }
        })
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
        return self.surveyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "playerSurveys"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlayerSurveyListTableViewCell else{
            fatalError("The dequeued cell is not an instance of PlayerSurveyListTableViewCell")
        }
        print(TeamList.surveyList.count)
        cell.surveyLabel.text = self.surveyList[indexPath.row]
        if(PlayerDidRespond.players[indexPath.row].didRespond){
            cell.done.isHidden = false
            cell.isUserInteractionEnabled = false
        }
        else{
            cell.done.isHidden = true
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow;
        let currentCell = tableView.cellForRow(at: indexPath!) as! PlayerSurveyListTableViewCell;
        
        selectedSurvey = currentCell.surveyLabel.text
        performSegue(withIdentifier: "response", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "response") {
            
             guard let navigationController = segue.destination as? UINavigationController else { return }
            
            // initialize new view controller and cast it as your view controller
            let viewController = navigationController.viewControllers.first as! PlayerResponseViewController
            // your new view controller should have property that will store passed value
            viewController.selectedSurvey = selectedSurvey
        }
        
    }
    
}
