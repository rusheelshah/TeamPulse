//
//  PlayerDidRespond.swift
//  TeamPulseApp
//
//  Created by Rusheel Shah on 5/5/17.
//  Copyright © 2017 Rusheel Shah. All rights reserved.
//

import Foundation

//Stores what surveys players completed
class PlayerDidRespond{
    static var players: [PlayerStruct] = []
}

struct PlayerStruct{
    var playerName: String!
    var surveyName: String!
    var didRespond: Bool!
    
    init(playerName: String, surveyName: String, didRespond: Bool) {
        self.playerName = playerName
        self.surveyName = surveyName
        self.didRespond = didRespond
    }
}
