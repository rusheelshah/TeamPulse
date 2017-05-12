//
//  NewTeamViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/22/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit
import Firebase

class NewTeamViewController: UIViewController {
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var inputTeamID: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputConfirm: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var invalidPassword: UILabel!
    @IBOutlet weak var numPlayers: UITextField!
    
    override func viewDidLoad() {
        invalidPassword.isHidden = true
        self.ref = FIRDatabase.database().reference()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    //Add teamId, password, and number of players to Firebase
    @IBAction func onDone(_ sender: UIBarButtonItem) {
        if((inputTeamID.text?.isEmpty)! && (inputPassword.text?.isEmpty)! && (inputConfirm.text?.isEmpty)! && (numPlayers.text?.isEmpty)!){
            self.dismiss(animated: true, completion: nil)
        }
        if((!(self.inputTeamID.text?.isEmpty)!) && (!(self.numPlayers.text?.isEmpty)!)){
            let team = TeamID(teamID: self.inputTeamID.text!, numPlayers: self.numPlayers.text!)
            if((self.inputPassword.text) == (self.inputConfirm.text)){
                TeamList.teamList.append(team)
                self.ref.child("Teams").child(team.teamID).child("password").setValue(self.inputPassword.text)
                self.ref.child("Teams").child(team.teamID).child("0NumPlayers").setValue(self.numPlayers.text)
                self.dismiss(animated: true, completion: nil)
            }
            else{
                invalidPassword.isHidden = false
                inputPassword.text?.removeAll()
                inputConfirm.text?.removeAll()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
