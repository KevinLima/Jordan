//
//  ResultModel.swift
//  Jordan
//
//  Created by Kevin Lima on 10/11/2022.
//

import Foundation

struct MatchResult {
    var homeTeam: Team
    var awayTeam: Team
    var homeTeamGoals: Int = 0
    var AwayTeamGoals: Int = 0
}

extension [MatchResult] {
    // print all the match results in a readable way (without team id etc)
    func printAll(){
        for match in self {
            print("\(match.homeTeam.name) (\(match.homeTeam.offense),\(match.homeTeam.defence)) VS \(match.awayTeam.name) (\(match.awayTeam.offense),\(match.awayTeam.defence)). Result \(match.homeTeamGoals) - \(match.AwayTeamGoals)")
        }
    }
}
