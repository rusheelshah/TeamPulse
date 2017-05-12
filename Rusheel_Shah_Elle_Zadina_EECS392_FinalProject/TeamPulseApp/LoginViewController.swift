//
//  LoginViewController.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/22/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import UIKit

//Initial view controller with different segues depending on user
class LoginViewController: UIViewController {
    @IBAction func onPlayerButton(_ sender: UIButton) {
        Member.isPlayer = true
    }
    @IBAction func onCoachButton(_ sender: UIButton) {
        Member.isCoach = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
