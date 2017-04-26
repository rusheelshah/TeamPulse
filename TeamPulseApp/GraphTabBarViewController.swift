//
//  GraphTabBarViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/24/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//


import UIKit
import Firebase

class GraphTabBarViewController: UIViewController {
    var selectedTeam: String!
    var selectedSurvey: String!
    
    override func viewDidLoad() {
        self.title = selectedTeam
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.createGraph()
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
        
        let titleString = "\(selectedSurvey) Survey Responses"
        let title = UILabel(frame: CGRect(x: 0, y: 15, width: graphView.bounds.size.width, height: 20));
        title.text = titleString as String;
        title.numberOfLines = 0;
        title.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
        title.textAlignment = NSTextAlignment.center;
        graphView.addSubview(title)
        
        //xVals
        let xVals = ["1", "2", "3", "4", "5"]
        
        //yVals
        let yVals = ["Strongly Disagree", "Disagree", "Neutral", "Agree", "Strongly Agree"]
        
        //draw y-axis
        var yAxis = UIBezierPath()
        yAxis.move(to: CGPoint(x: 70, y: graphView.bounds.size.height - 60));
        yAxis.addLine(to: CGPoint(x:70, y: 30 + title.bounds.size.height));
        var yAxisLayer = CAShapeLayer()
        yAxisLayer.path = yAxis.cgPath
        yAxisLayer.strokeColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1).cgColor
        yAxisLayer.lineWidth = 3.0;
        yAxisLayer.fillColor = UIColor.clear.cgColor
        graphView.layer.addSublayer(yAxisLayer)
        
        //draw x-axis
        var xAxis = UIBezierPath()
        xAxis.move(to: CGPoint(x: 70, y: graphView.bounds.size.height - 60));
        xAxis.addLine(to: CGPoint(x:graphView.bounds.size.width - 30, y: graphView.bounds.size.height - 60));
        var xAxisLayer = CAShapeLayer()
        xAxisLayer.path = xAxis.cgPath
        xAxisLayer.strokeColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1).cgColor
        xAxisLayer.lineWidth = 3.0;
        xAxisLayer.fillColor = UIColor.clear.cgColor
        graphView.layer.addSublayer(xAxisLayer)
        
        //add x-axis title
        var xtitle = UILabel(frame: CGRect(x: 70, y: graphView.bounds.size.height - 20, width: graphView.bounds.size.width - 100, height: 20))
        xtitle.text = "Questions"
        xtitle.textAlignment = NSTextAlignment.center;
        xtitle.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
        
        //add x-axis labels
        var increment = (graphView.bounds.size.width - 100) / 5
        var x = CGFloat(70);
        var y = graphView.bounds.size.height - 50;
        var height = CGFloat(15);
        var width = increment;
        for i in 0 ... 4{
            var label = UILabel(frame: CGRect(x:x, y:y, width:width, height:height));
            label.text = xVals[i];
            label.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
            label.textAlignment = NSTextAlignment.center;
            graphView.addSubview(label)
            x = x + increment;
        }
        
        //add y-axis labels
        var increment2 = (graphView.bounds.size.height - 110) / 5
        var x2 = CGFloat(5);
        var y2 = CGFloat(50);
        var height2 = CGFloat(50);
        var width2 = CGFloat(60);
        for i in 0 ... 4{
            var label2 = UITextView(frame: CGRect(x:x2, y:y2, width:width2, height:height2));
            label2.text = yVals[i];
            label2.textColor = UIColor(colorLiteralRed: 77/255.0, green: 77/255.0, blue: 22/255.0, alpha: 1)
            label2.textAlignment = NSTextAlignment.center;
            graphView.addSubview(label2)
            y2 = y2 + increment2;
        }
        
        //draw bars
        var questions = [1.5, 3.5, 5, 4.7, 2.6]
        var scoreHeight = (graphView.bounds.size.height - 110) / 5
        var barWidth = (graphView.bounds.size.width - 100) / 5;
        var x3 = CGFloat(70)
        var y3 = graphView.bounds.size.height - 60;
        var height3 = scoreHeight;
        var width3 = barWidth;
        for i in 0 ... 4{
            var barView = UIView(frame: CGRect(x:CGFloat(x3 + 5), y:y3, width:width3 - 5, height:-(height3 * CGFloat(questions[i]))))
            barView.backgroundColor = UIColor(colorLiteralRed:251/255.0, green:10/255.0, blue:95/255.0, alpha:1)
            barView.layer.cornerRadius = 5;
            barView.layer.masksToBounds = true;
            var barLabel = UILabel(frame:barView.bounds)
            barLabel.text = "\(questions[i])"
            barLabel.textColor = UIColor.white
            barLabel.textAlignment = NSTextAlignment.center;
            barView.addSubview(barLabel)
            graphView.addSubview(barView)
            x3 = x3 + barWidth
        }

        
        
        
    }
    
    
}

