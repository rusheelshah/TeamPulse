//
//  PlayerLoginViewController.swift
//  
//
//  Created by Rusheel Shah on 4/25/17.
//
//

import UIKit
import Firebase

class PlayerLoginViewController: UIViewController {
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputTeam: UITextField!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var invalidLogin: UILabel!
    var ref: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    var authenticated: Bool = false
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
        invalidLogin.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onGoButton(_ sender: UIButton) {
        let team = inputTeam.text
        let password = inputPassword.text
        Player.playerName = inputName.text!
        Player.playsFor = team!
        let testRef = ref.child("Teams")
        testRef.observe(.value, with: { (snapshot) in
            if snapshot.hasChildren(){
                for child in snapshot.children{
                    let node = child as? FIRDataSnapshot
                    print(node?.key)
                    if(node?.key == team){
                        for entry in (node?.children)!{
                            let item = entry as? FIRDataSnapshot
                            
                            if((item?.key == "password") && (item?.value as? String == password)){
                                self.authenticated = true
                                self.performSegue(withIdentifier: "playerAuthenticated", sender: self)
                            }
                        }
                    }
                }
                if(!self.authenticated){
                    self.invalidLogin.isHidden = false
                    self.inputPassword.text?.removeAll()
                    self.inputTeam.text?.removeAll()
                }
            }
        })
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    
}
