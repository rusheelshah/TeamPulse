//
//  NewSurveyViewController.swift
//  
//
//  Created by Rusheel Shah on 4/24/17.
//
//

import UIKit
import Firebase

class NewSurveyViewController: UIViewController {
    var ref: FIRDatabaseReference!
    @IBOutlet weak var surveyTitle: UINavigationItem!
    @IBOutlet weak var question1: UITextField!
    @IBOutlet weak var question2: UITextField!
    @IBOutlet weak var question3: UITextField!
    @IBOutlet weak var question4: UITextField!
    @IBOutlet weak var question5: UITextField!
    var q1: String!
    var q2: String!
    var q3: String!
    var q4: String!
    var q5: String!
    var surveyName: String!
    var currentTeam: String!
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
        self.surveyTitle.title = self.surveyName
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onDoneButton(_ sender: UIBarButtonItem) {
        self.ref.child("Teams").child(self.currentTeam).child(surveyName).child("1").setValue(question1.text)
        self.ref.child("Teams").child(self.currentTeam).child(surveyName).child("2").setValue(question2.text)
        self.ref.child("Teams").child(self.currentTeam).child(surveyName).child("3").setValue(question3.text)
        self.ref.child("Teams").child(self.currentTeam).child(surveyName).child("4").setValue(question4.text)
        self.ref.child("Teams").child(self.currentTeam).child(surveyName).child("5").setValue(question5.text)
        self.dismiss(animated: true, completion: nil)
    }

}
