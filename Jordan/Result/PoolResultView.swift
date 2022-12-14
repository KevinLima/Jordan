//
//  ResultView.swift
//  Jordan
//
//  Created by Kevin Lima on 10/11/2022.
//

import SwiftUI

struct PoolResultView: View {
    @ObservedObject private var vm = ResultViewModel()
    
    init(teamList: [Team]) {
        vm.setTeamList(team: teamList)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            Grid(horizontalSpacing: 30){
                GridRow{
                    Text("Country")
                    Text("P")
                    Text("GB")
                    Text("G")
                    Text("GC")
                }
                .fontWeight(.bold)
                
                ForEach(vm.poolTable) { item in
                    GridRow{
                        Text(item.team.name)
                        Text("\(item.points)")
                        Text("\(item.goalsScored - item.goalsConceded)")
                        Text("\(item.goalsScored)")
                        Text("\(item.goalsConceded)")
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("P = Points")
                Text("GB = Goal Balance (Doelsaldo)")
                Text("G = Goals scored (Doelpunten voor)")
                Text("GC = Goals conceded (Doelpunten tegen)")
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        PoolResultView(teamList: [Team.exampleTeam])
    }
}
