//
//  Survey.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/24/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import Foundation

//Stores survey with name and if all players answered
class Survey{
    var name: String!
    var allAnswered: Bool!
    init(name: String, allAnswered: Bool) {
        self.name = name
        self.allAnswered = allAnswered
    }
}

