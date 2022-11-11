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
    
    // usefull to test sorting
    static var examplePool: [PoolResult] = [
        PoolResult(team: Team.exampleTeam, points: 2, goalsScored: 10, goalsConceded: 5),
        PoolResult(team: Team.exampleTeam, points: 3, goalsScored: 10, goalsConceded: 5),
        PoolResult(team: Team.exampleTeam, points: 3, goalsScored: 11, goalsConceded: 6),
        PoolResult(team: Team.exampleTeam, points: 3, goalsScored: 6, goalsConceded: 0),
    ]
}

extension [PoolResult] {
    mutating func sortPool(){
        // Sorting order 1.points 2.goal balance (doelsaldo) 3.goals scored
        // Not sorted by goals conceded because if goal balance and goals scored are the equal, then goals conceded will also be the same
        self = self.sorted(by: {
            ($0.points, ($0.goalsScored - $0.goalsConceded), $0.goalsScored) >
            ($1.points, ($1.goalsScored - $1.goalsConceded), $1.goalsScored)
        })
    }
}
