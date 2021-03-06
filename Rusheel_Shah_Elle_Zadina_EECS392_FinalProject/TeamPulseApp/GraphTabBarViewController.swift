//
//  GraphTabBarViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/24/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//


import UIKit
import Firebase

//ViewController that shows the graph of the aggregated data
class GraphTabBarViewController: UIViewController {
    var ref: FIRDatabaseReference = FIRDatabase.database().reference()
    var namesRef: FIRDatabaseReference!
    var graphRef: FIRDatabaseReference!
    var refHandle: FIRDatabaseHandle?
    var selectedTeam: String!
    var selectedSurvey: String!
    var people: Int!
    var score1: [String]! = []
    var score2: [String]! = []
    var score3: [String]! = []
    var score4: [String]! = []
    var score5: [String]! = []

    @IBOutlet weak var noResponseLabel: UILabel!
    
    override func viewDidLoad() {
        self.noResponseLabel.isHidden = true
        self.loadData()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func loadData(){
        self.title = Responder.survey
        namesRef = ref.child("Teams").child(Responder.team).child(Responder.survey).child("Responses")
        namesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren(){
                let count = snapshot.childrenCount
                self.people = Int(count)
                for child in snapshot.children{
                    if let node = child as? FIRDataSnapshot, let name = node.key as String?{
                        print(name)
                        self.getAnswers(name: name)
                    }
                }
            }
            else{
                self.noResponseLabel.isHidden = false
            }
        })
        
    }
    
    func getAnswers(name: String){
        self.graphRef = self.ref.child("Teams").child(Responder.team).child(Responder.survey).child("Responses").child(name)
        self.graphRef.observeSingleEvent(of: .value, with: { (snapshot2) in
            if(snapshot2.hasChildren()){
                for child in snapshot2.children{
                    if let node = child as? FIRDataSnapshot, var _ = node.key as String?{
                        if(node.key == "1"){
                            self.score1.append(node.value as! String)
                        }
                        else if(node.key == "2"){
                            self.score2.append(node.value as! String)
                        }
                        else if(node.key == "3"){
                            self.score3.append(node.value as! String)
                        }
                        else if(node.key == "4"){
                            self.score4.append(node.value as! String)
                        }
                        else if(node.key == "5"){
                            self.score5.append(node.value as! String)
                        }
                    }
                }
            }
            self.createGraph()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGraph(){
        
        //create view
         let graphView = UIView(frame: CGRect(x: 15, y: (self.navigationController?.navigationBar.frame.size.height)! + 30, width: self.view.bounds.size.width - 30, height: 400))
        graphView.layer.cornerRadius = 15;
        graphView.layer.masksToBounds = true;
        self.view.addSubview(graphView)
        
        //set border
        graphView.layer.borderColor = UIColor(colorLiteralRed: 255/255.0, green: 51/255.0, blue: 92/255.0, alpha: 1).cgColor
        graphView.layer.borderWidth = 3.0;
        
        //add title
        
        let titleString = "\(Responder.survey) Survey Responses"
        let title = UILabel(frame: CGRect(x: 0, y: 15, width: graphView.bounds.size.width, height: 20));
        title.text = titleString as String;
        title.numberOfLines = 0;
        title.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
        title.textAlignment = NSTextAlignment.center;
        graphView.addSubview(title)
        
        //xVals
        let xVals = ["1", "2", "3", "4", "5"]
        
        //yVals
        let yVals = ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagree"]
        
        //draw y-axis
        let yAxis = UIBezierPath()
        yAxis.move(to: CGPoint(x: 70, y: graphView.bounds.size.height - 60));
        yAxis.addLine(to: CGPoint(x:70, y: 30 + title.bounds.size.height));
        let yAxisLayer = CAShapeLayer()
        yAxisLayer.path = yAxis.cgPath
        yAxisLayer.strokeColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1).cgColor
        yAxisLayer.lineWidth = 3.0;
        yAxisLayer.fillColor = UIColor.clear.cgColor
        graphView.layer.addSublayer(yAxisLayer)
        
        //draw x-axis
        let xAxis = UIBezierPath()
        xAxis.move(to: CGPoint(x: 70, y: graphView.bounds.size.height - 60));
        xAxis.addLine(to: CGPoint(x:graphView.bounds.size.width - 30, y: graphView.bounds.size.height - 60));
        let xAxisLayer = CAShapeLayer()
        xAxisLayer.path = xAxis.cgPath
        xAxisLayer.strokeColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1).cgColor
        xAxisLayer.lineWidth = 3.0;
        xAxisLayer.fillColor = UIColor.clear.cgColor
        graphView.layer.addSublayer(xAxisLayer)
        
        //add x-axis title
        let xtitle = UILabel(frame: CGRect(x: 70, y: graphView.bounds.size.height - 20, width: graphView.bounds.size.width - 100, height: 20))
        xtitle.text = "Questions"
        xtitle.textAlignment = NSTextAlignment.center;
        xtitle.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
        
        //add x-axis labels
        let increment = (graphView.bounds.size.width - 100) / 5
        var x = CGFloat(70);
        let y = graphView.bounds.size.height - 50;
        let height = CGFloat(15);
        let width = increment;
        for i in 0 ... 4{
            let label = UILabel(frame: CGRect(x:x, y:y, width:width, height:height));
            label.text = xVals[i];
            label.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
            label.textAlignment = NSTextAlignment.center;
            graphView.addSubview(label)
            x = x + increment;
        }
        
        //add y-axis labels
        let increment2 = (graphView.bounds.size.height - 110) / 5
        let x2 = CGFloat(5);
        var y2 = CGFloat(50);
        let height2 = CGFloat(50);
        let width2 = CGFloat(60);
        for i in 0 ... 4{
            let label2 = UITextView(frame: CGRect(x:x2, y:y2, width:width2, height:height2));
            label2.text = yVals[i];
            label2.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
            label2.textAlignment = NSTextAlignment.center;
            graphView.addSubview(label2)
            y2 = y2 + increment2;
        }
        
        //draw bars
        var q1 = 0
        var q2 = 0
        var q3 = 0
        var q4 = 0
        var q5 = 0
        for i in 0 ... (score1.count - 1){
            q1 = q1 + Int(score1[i])!
            q2 = q2 + Int(score2[i])!
            q3 = q3 + Int(score3[i])!
            q4 = q4 + Int(score4[i])!
            q5 = q5 + Int(score5[i])!
        }
        var questions = [(q1/score1.count), (q2/score1.count), (q3/score1.count), (q4/score1.count), (q5/score1.count)]
        let scoreHeight = (graphView.bounds.size.height - 110) / 5
        let barWidth = (graphView.bounds.size.width - 100) / 5;
        var x3 = CGFloat(70)
        let y3 = graphView.bounds.size.height - 60;
        let height3 = scoreHeight;
        let width3 = barWidth;
        for i in 0 ... 4{
            let barView = UIView(frame: CGRect(x:CGFloat(x3 + 5), y:y3, width:width3 - 5, height:-(height3 * CGFloat(questions[i]))))
            barView.backgroundColor = UIColor(colorLiteralRed:51/255.0, green:153/255.0, blue:255/255.0, alpha:1)
            barView.layer.cornerRadius = 5;
            barView.layer.masksToBounds = true;
            graphView.addSubview(barView)
            x3 = x3 + barWidth
        }

        
        
        
    }
    
    
}

