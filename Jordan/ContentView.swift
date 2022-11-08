//
//  ContentView.swift
//  Jordan
//
//  Created by Kevin Lima on 07/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var teamViewModel = TeamViewModel()
    
    var body: some View {
        NavigationView {
            List(teamViewModel.teamList) { team in
                HStack{
                    Text(team.name)
                    Spacer()
                    Text("\(team.offense)")
                    Spacer()
                    Text("\(team.defence)")
                }
            }
            
            .navigationTitle("Teams")
            .toolbar{
                Button("Refresh"){
                    teamViewModel.generateTeams()
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
