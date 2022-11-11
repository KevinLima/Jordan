//
//  Result-ViewModel.swift
//  Jordan
//
//  Created by Kevin Lima on 10/11/2022.
//

import Foundation

extension PoolResultView {
    @MainActor class ResultViewModel: ObservableObject {
        private var teamList = [Team]()
        private var resultList = [MatchResult]()
        @Published var poolTable = [PoolResult]()
        
        func setTeamList(team: [Team]){
            teamList = team
            simulatePool()
            poolTable = createPool()
            poolTable.sortPool()
            
            //poolTable = PoolResult.examplePool
            resultList.printAll()
        }
        
        // Simulate all six games in the pool using a nested for loop
        func simulatePool(){
            // list of the away team for each game
            var opponentList = teamList
            
            for team in teamList {
                // a team cannot play itself
                opponentList.remove(at: 0)
                
                // if no opponets left, stop.
                if opponentList.count == 0 {
                    break
                }
                
                for opponent in opponentList {
                    self.resultList.append(self.simulateMatch(homeTeam: team, awayTeam: opponent))
                }
            }
        }
        
        // Simulate a single match between a home and away team
        func simulateMatch(homeTeam: Team, awayTeam: Team) -> MatchResult{
            // First calculate how many shots on targed / chances to score  each team gets based on de defensive stat of opponent
            let homeShotsOnTarget = getShotsOnTarget(defence: awayTeam.defence)
            let awayShotsOnTarget = getShotsOnTarget(defence: homeTeam.defence)
            
            // Create match results objects
            var matchResult = MatchResult(homeTeam: homeTeam, awayTeam: awayTeam)
            
            // Calculate how many goals both team scored
            matchResult.homeTeamGoals = getGoalAmount(
                shots: homeShotsOnTarget, offence: homeTeam.offense)
            matchResult.AwayTeamGoals = getGoalAmount(
                shots: awayShotsOnTarget, offence: awayTeam.offense)
            
            return matchResult
        }
        
        func getShotsOnTarget(defence: Int)-> Int {
            // the amount of  shots/chances your opponents gets is your defence minus ten
            return 10 - defence
        }
        
        // A dice roll per schot on target
        func getGoalAmount(shots:Int, offence:Int)->Int{
            var goals = 0
            
            for _ in 1...shots {
                let diceRoll = Int.random(in: 1..<10)
                
                // if the dice roll is the same or lower than office, then its a goal
                if (diceRoll <= offence){
                    goals += 1
                }
            }
            return goals
        }
        
        // combine all the important data to create an pool objects that wil be displayed
        func createPool()->[PoolResult]{
            var pool = [PoolResult]()
            
            for match in self.resultList {
                var homePoints = 0
                var awayPoints = 0
                
                // figure out how many points each table has (a loss is zero points )
                if match.homeTeamGoals > match.AwayTeamGoals{
                    homePoints = 3
                } else if match.homeTeamGoals == match.AwayTeamGoals{
                    homePoints = 1
                    awayPoints = 1
                } else {
                    awayPoints = 3
                }
                
                // add the result for the home and away team, for each match
                pool = self.createPoolRow(pool: pool, team: match.homeTeam, points: homePoints, goalsScored: match.homeTeamGoals, goalsConceded: match.AwayTeamGoals)
                pool = self.createPoolRow(pool: pool, team: match.awayTeam, points: awayPoints, goalsScored: match.AwayTeamGoals, goalsConceded: match.homeTeamGoals)
            }
            
            return pool
        }
        
        func createPoolRow(pool: [PoolResult], team: Team, points: Int, goalsScored: Int, goalsConceded: Int)->[PoolResult] {
            var newPool = pool
            
            // first check if a team doesnt alreadt have an entry in the array
            if let item = pool.firstIndex(where: {$0.team.id == team.id}){
                // add the points and goals to the existing array element
                newPool[item].points += points
                newPool[item].goalsScored += goalsScored
                newPool[item].goalsConceded += goalsConceded
            } else {
                newPool.append(PoolResult(team: team, points: points, goalsScored: goalsScored, goalsConceded: goalsConceded))
            }
            return newPool
        }
    }
}
