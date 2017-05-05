    //
//  PlayerResponseViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/25/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//
import UIKit
import Firebase

class PlayerResponseViewController: UIViewController {
    var ref: FIRDatabaseReference!
    var surveyQuestionsRef: FIRDatabaseReference!
    var responsesRef: FIRDatabaseReference!
    var selectedSurvey: String!
    var values: [Int] = []
    var value1: Int!
    var value2: Int!
    var value3: Int!
    var value4: Int!
    var value5: Int!
    
    @IBOutlet weak var question1: UILabel!
    @IBOutlet weak var score1: UILabel!
    @IBOutlet weak var response1: UISlider!
    
    @IBOutlet weak var question2: UILabel!
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var response2: UISlider!
    
    @IBOutlet weak var question3: UILabel!
    @IBOutlet weak var score3: UILabel!
    @IBOutlet weak var response3: UISlider!
    
    @IBOutlet weak var question4: UILabel!
    @IBOutlet weak var score4: UILabel!
    @IBOutlet weak var response4: UISlider!
    
    @IBOutlet weak var question5: UILabel!
    @IBOutlet weak var score5: UILabel!
    @IBOutlet weak var response5: UISlider!
    
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
        self.surveyQuestionsRef = ref.child("Teams").child(Player.playsFor).child(self.selectedSurvey)
        self.surveyQuestionsRef.observe(.value, with: { (snapshot) in
            if(snapshot.hasChildren()){
                for child in snapshot.children{
                    if let node = child as? FIRDataSnapshot, let _ = node.key as String?{
                        if(node.key == "1"){
                            self.question1.text = node.value as? String
                        }
                        else if(node.key == "2"){

                            self.question2.text = node.value as? String
                        }
                        else if(node.key == "3"){
                            self.question3.text = node.value as? String
                        }
                        else if(node.key == "4"){
                            self.question4.text = node.value as? String
                        }
                        else if(node.key == "5"){
                            self.question5.text = node.value as? String
                        }
                    }
                }
            }
        })
        
        score1.text = "Neutral"
        score2.text = "Neutral"
        score3.text = "Neutral"
        score4.text = "Neutral"
        score5.text = "Neutral"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onResponse1(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        if(roundedValue <= 20){
            score1.text = "Strongly Disagree"
            self.value1 = 1
        }
        else if(roundedValue > 20 && roundedValue <= 40){
            score1.text = "Disagree"
            self.value1 = 2
        }
        else if(roundedValue > 40 && roundedValue <= 60){
            score1.text = "Neutral"
            self.value1 = 3
        }
        else if(roundedValue > 60 && roundedValue <= 80){
            score1.text = "Agree"
            self.value1 = 4
        }
        else{
            score1.text = "Strongly Agree"
            self.value1 = 5
        }
    }
    
    @IBAction func onResponse2(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        if(roundedValue <= 20){
            score2.text = "Strongly Disagree"
            self.value2 = 1
        }
        else if(roundedValue > 20 && roundedValue <= 40){
            score2.text = "Disagree"
            self.value2 = 2
        }
        else if(roundedValue > 40 && roundedValue <= 60){
            score2.text = "Neutral"
            self.value2 = 3
        }
        else if(roundedValue > 60 && roundedValue <= 80){
            score2.text = "Agree"
            self.value2 = 4
        }
        else{
            score2.text = "Strongly Agree"
            self.value2 = 5
        }
    }
    
    @IBAction func onResponse3(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        if(roundedValue <= 20){
            score3.text = "Strongly Disagree"
            self.value3 = 1
        }
        else if(roundedValue > 20 && roundedValue <= 40){
            score3.text = "Disagree"
            self.value3 = 2
        }
        else if(roundedValue > 40 && roundedValue <= 60){
            score3.text = "Neutral"
            self.value3 = 3
        }
        else if(roundedValue > 60 && roundedValue <= 80){
            score3.text = "Agree"
            self.value3 = 4
        }
        else{
            score3.text = "Strongly Agree"
            self.value3 = 5
        }
    }
    
    @IBAction func onResponse4(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        if(roundedValue <= 20){
            score4.text = "Strongly Disagree"
            self.value4 = 1
        }
        else if(roundedValue > 20 && roundedValue <= 40){
            score4.text = "Disagree"
            self.value4 = 2
        }
        else if(roundedValue > 40 && roundedValue <= 60){
            score4.text = "Neutral"
            self.value4 = 3
        }
        else if(roundedValue > 60 && roundedValue <= 80){
            score4.text = "Agree"
            self.value4 = 4
        }
        else{
            score4.text = "Strongly Agree"
            self.value4 = 5
        }
    }
    
    @IBAction func onResponse5(_ sender: UISlider) {
        let roundedValue = Int(sender.value)
        if(roundedValue <= 20){
            score5.text = "Strongly Disagree"
            self.value5 = 1
        }
        else if(roundedValue > 20 && roundedValue <= 40){
            score5.text = "Disagree"
            self.value5 = 2
        }
        else if(roundedValue > 40 && roundedValue <= 60){
            score5.text = "Neutral"
            self.value5 = 3
        }
        else if(roundedValue > 60 && roundedValue <= 80){
            score5.text = "Agree"
            self.value5 = 4
        }
        else{
            score5.text = "Strongly Agree"
            self.value5 = 5
        }
    }
    
    @IBAction func onDoneButton(_ sender: UIBarButtonItem) {
        if(self.value1 == nil){
            self.value1 = 3
        }
        if(self.value2 == nil){
            self.value2 = 3
        }
        if(self.value3 == nil){
            self.value3 = 3
        }
        if(self.value4 == nil){
            self.value4 = 3
        }
        if(self.value5 == nil){
            self.value5 = 3
        }
        self.surveyQuestionsRef.child("Responses").child(Player.playerName).child("1").setValue(String(self.value1))
        self.surveyQuestionsRef.child("Responses").child(Player.playerName).child("2").setValue(String(self.value2))
        self.surveyQuestionsRef.child("Responses").child(Player.playerName).child("3").setValue(String(self.value3))
        self.surveyQuestionsRef.child("Responses").child(Player.playerName).child("4").setValue(String(self.value4))
        self.surveyQuestionsRef.child("Responses").child(Player.playerName).child("5").setValue(String(self.value5))
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
