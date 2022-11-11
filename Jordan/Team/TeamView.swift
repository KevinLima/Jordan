//
//  ContentView.swift
//  Jordan
//
//  Created by Kevin Lima on 07/11/2022.
//

import SwiftUI

struct TeamView: View {
    @State private var isPresenting = false
    @StateObject private var vm = TeamViewModel()
   
    var body: some View {
        NavigationView {
            VStack(){
                Grid(alignment: .leading, horizontalSpacing: 30){
                    GridRow{
                        Text("Country")
                        Text("Off")
                        Text("Def")
                    }
                    .fontWeight(.bold)
                    
                    ForEach(vm.teamList) { team in
                        GridRow{
                            Text(team.name)
                            Text(team.offString)
                            Text(team.defString)
                        }
                    }
                }
                .font(.system(size: 25))
                Spacer()
                Button("START") {
                    isPresenting = true
                }
                NavigationLink("", destination: ResultView(teamList: vm.teamList), isActive: $isPresenting)
                Spacer()
            }
            .navigationTitle("Teams")
            .toolbar {
                Button("Refresh"){
                    vm.generateTeams()
                }
            }
        }
    }
    
    struct TeamView_Previews: PreviewProvider {
        static var previews: some View {
            TeamView()
        }
    }
}
