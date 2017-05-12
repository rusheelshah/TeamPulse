//
//  TeamID.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 4/22/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import Foundation
import Firebase


//Stores teams with teamId and number of players
class TeamID{
    var teamID: String
    var numPlayers: String
    init(teamID: String, numPlayers: String) {
        self.teamID = teamID
        self.numPlayers = numPlayers
    }
}

