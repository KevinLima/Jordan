//
//  ContentView.swift
//  Jordan
//
//  Created by Kevin Lima on 07/11/2022.
//

import SwiftUI

struct View: View {
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
            }
            .navigationTitle("Teams")
            .toolbar {
                Button("Refresh"){
                    vm.generateTeams()
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            View()
        }
    }
}
