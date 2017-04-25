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
    override func viewDidLoad() {
        invalidPassword.isHidden = true
        self.ref = FIRDatabase.database().reference()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func onDone(_ sender: UIBarButtonItem) {
        if(!(self.inputTeamID.text?.isEmpty)!){
            TeamID.teamID = self.inputTeamID.text!
            if((self.inputPassword.text) == (self.inputConfirm.text)){
                self.ref.child("Teams").child(TeamID.teamID).child("password").setValue(self.inputPassword.text)
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
