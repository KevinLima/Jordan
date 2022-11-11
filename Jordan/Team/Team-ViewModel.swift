//
//  Team-ViewModel.swift
//  Jordan
//
//  Created by Kevin Lima on 08/11/2022.
//

import Foundation

extension TeamView {
    @MainActor class TeamViewModel: ObservableObject {
        @Published var teamList = [Team]()        
        private var teamNames = ["Nederland","Senegal","Ecuador","Qatar"]
        
        init() {
            self.generateTeams()
        }
        
        func generateTeams() {
            // in case of a refresh
            teamList.removeAll()
            
            for teamName in teamNames {
                let newTeam = Team(
                    name: teamName,
                    // offence and defence stats are randomly generated
                    offense: Int.random(in: 1..<10),
                    defence: Int.random(in: 1..<10)
                )
                teamList.insert(newTeam, at: 0)
            }
        }
    }
}
