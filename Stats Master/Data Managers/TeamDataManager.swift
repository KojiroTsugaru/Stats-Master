//
//  TeamDataManager.swift
//  Stats Master
//
//  Created by KJ on 6/6/23.
//

import Foundation

class TeamData: ObservableObject {
    @Published var players: [Player] = []
    
    init(team: Team) {
        // Fetch players associated with the team
        // and assign them to the `players` property
        // You can modify the code below based on your data model
        
        if let players = team.players?.allObjects as? [Player] {
            self.players = players
        }
    }
}
