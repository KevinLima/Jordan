//
//  Result-ViewModel.swift
//  Jordan
//
//  Created by Kevin Lima on 10/11/2022.
//

import Foundation

extension ResultView {
    @MainActor class ResultViewModel: ObservableObject {
        @Published var teamList = [Team]()
        @Published var resultList = [MatchResult]()
        @Published var poolTable = [PoolResult]()
        
        func setTeamList(team: [Team]){
            teamList = team
            simulateAllGames()
            poolTable = createPoolResult()
            
            //poolTable = PoolResult.examplePool
            sortPool()
            //printMatchResults(matches: resultList)
        }
        
        func simulateAllGames(){
            var opponentList = teamList
            
            for team in teamList {
                opponentList.remove(at: 0)
                
                if opponentList.count == 0 {
                    break
                }
                
                for opponent in opponentList {
                    self.resultList.append(self.simulateGame(homeTeam: team, awayTeam: opponent))
                }
            }
        }
        
        func simulateGame(homeTeam: Team, awayTeam: Team) -> MatchResult{
            let homeShotsOnTarget = getShotsOnTarget(defence: awayTeam.defence)
            let awayShotsOnTarget = getShotsOnTarget(defence: homeTeam.defence)
            
            var matchResult = MatchResult(homeTeam: homeTeam, awayTeam: awayTeam)
            
            matchResult.homeTeamGoals = getGoalAmount(
                shots: homeShotsOnTarget, offence: homeTeam.offense)
            matchResult.AwayTeamGoals = getGoalAmount(
                shots: awayShotsOnTarget, offence: awayTeam.offense)
            
            return matchResult
        }
        
        func getShotsOnTarget(defence: Int)-> Int {
            return 10 - defence
        }
        
        func getGoalAmount(shots:Int, offence:Int)->Int{
            var goals = 0
            
            for _ in 1...shots {
                let diceRoll = Int.random(in: 1..<10)
                
                if (diceRoll <= offence){
                    goals += 1
                }
            }
            return goals
        }
        
        func createPoolResult()->[PoolResult]{
            var pool = [PoolResult]()
            
            for match in self.resultList {
                var homePoints = 0
                var awayPoints = 0
                
                if match.homeTeamGoals > match.AwayTeamGoals{
                    homePoints = 3
                } else if match.homeTeamGoals == match.AwayTeamGoals{
                    homePoints = 1
                    awayPoints = 1
                } else {
                    awayPoints = 3
                }
                
                pool = self.createPoolResult(pool: pool, team: match.homeTeam, points: homePoints, goalsScored: match.homeTeamGoals, goalsConceded: match.AwayTeamGoals)
                pool = self.createPoolResult(pool: pool, team: match.awayTeam, points: awayPoints, goalsScored: match.AwayTeamGoals, goalsConceded: match.homeTeamGoals)
            }
            
            return pool
        }
        
        func createPoolResult(pool: [PoolResult], team: Team, points: Int, goalsScored: Int, goalsConceded: Int)->[PoolResult] {
            var newPool = pool
            
            if let item = pool.firstIndex(where: {$0.team.id == team.id}){
                newPool[item].points += points
                newPool[item].goalsScored += goalsScored
                newPool[item].goalsConceded += goalsConceded
            } else {
                newPool.append(PoolResult(team: team, points: points, goalsScored: goalsScored, goalsConceded: goalsConceded))
            }
            return newPool
        }
        
        func sortPool(){
            self.poolTable.sort(by: {
                ($0.points, ($0.goalsScored - $0.goalsConceded), $0.goalsScored) >
                ($1.points, ($1.goalsScored - $1.goalsConceded), $1.goalsScored)
            })
        }
        
        func printMatchResults(matches: [MatchResult]){
            for match in matches {
                print("\(match.homeTeam.name) (\(match.homeTeam.offense),\(match.homeTeam.defence)) VS \(match.awayTeam.name) (\(match.awayTeam.offense),\(match.awayTeam.defence)). Result \(match.homeTeamGoals) - \(match.AwayTeamGoals)")
            }
        }
    }
}
