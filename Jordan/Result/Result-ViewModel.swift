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
        
        func setTeamList(team: [Team]){
            self.teamList = team
            simulateAllGames()
            print("amount of games:  \(resultList.count)")
        }
        
        func simulateAllGames(){
            var homeTeam = teamList[0]
            
            for team in teamList {
                if team.id != homeTeam.id{
                    let teamIndex = self.teamList.firstIndex { item in
                        item.id == team.id
                    }!
                    
                    if teamList.indices.contains(teamIndex + 1){
                        let awayTeam = teamList[teamIndex+1]
                        
                        self.resultList.append(self.simulateGame(homeTeam: homeTeam, awayTeam: awayTeam))
                    }
                }
                else {
                    continue
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
    }
}
