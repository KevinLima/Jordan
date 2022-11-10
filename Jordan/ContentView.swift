//
//  ContentView.swift
//  Jordan
//
//  Created by Kevin Lima on 07/11/2022.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        NavigationView {
            VStack(){
                TeamPoule()
                Spacer()
            }
            .navigationTitle("Teams")
        }
    }
    
    struct TeamPoule: View {
        @StateObject private var vm = TeamViewModel()
        
        var body: some View{
            Button("Refresh"){
                vm.generateTeams()
            }
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
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

