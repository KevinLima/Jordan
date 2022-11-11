//
//  PoolResult.swift
//  Jordan
//
//  Created by Kevin Lima on 11/11/2022.
//

import Foundation

struct PoolResult: Identifiable {
    var id = UUID()
    var team: Team
    var points: Int
    var goalsScored: Int
    var goalsConceded: Int
    
    static var examplePool: [PoolResult] = [
        PoolResult(team: Team.exampleTeam, points: 2, goalsScored: 10, goalsConceded: 5),
        PoolResult(team: Team.exampleTeam, points: 3, goalsScored: 10, goalsConceded: 5),
        PoolResult(team: Team.exampleTeam, points: 3, goalsScored: 11, goalsConceded: 6),
        PoolResult(team: Team.exampleTeam, points: 3, goalsScored: 6, goalsConceded: 0),
    ]
}
