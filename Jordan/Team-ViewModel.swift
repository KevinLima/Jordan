//
//  Team-ViewModel.swift
//  Jordan
//
//  Created by Kevin Lima on 08/11/2022.
//

import Foundation

extension ContentView.TeamPoule {
    @MainActor class TeamViewModel: ObservableObject {
        @Published var teamList = [Team]()
        var teamNames = ["Nederland","Senegal","Ecuador","Qatar"]
        
        init() {
            self.generateTeams()
        }
        
        func generateTeams() {
            teamList.removeAll()
            
            for teamName in teamNames {
                let newTeam = Team(
                    name: teamName,
                    offense: Int.random(in: 1..<10),
                    defence: Int.random(in: 1..<10)
                )
                teamList.insert(newTeam, at: 0)
            }
        }
    }
}
