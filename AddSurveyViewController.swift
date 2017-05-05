//
//  AddSurveyViewController.swift
//  
//
//  Created by Rusheel Shah on 4/24/17.
//
//

import UIKit
import Firebase

class AddNewSurveyViewController: UIViewController {
    @IBOutlet weak var surveyName: UITextField!
    var ref: FIRDatabaseReference!
    var currentTeam: String!
    override func viewDidLoad() {
        self.ref = FIRDatabase.database().reference()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onAdd(_ sender: UIBarButtonItem) {
        let currentSurvey = Survey(name: self.surveyName.text!)
        TeamList.surveyList.append(currentSurvey)
        
        if(!(self.surveyName.text?.isEmpty)!){
            let name = self.surveyName.text!
            //let currentSurvey = Survey(name: name)
            //TeamList.surveyList.append(currentSurvey)
            self.ref.child("Teams").child(self.currentTeam).child(name)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "newSurvey") {
            
            // initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! NewSurveyViewController
            // your new view controller should have property that will store passed value
            viewController.surveyName = self.surveyName.text!
            viewController.currentTeam = self.currentTeam
        }
        
    }
}
    
    
