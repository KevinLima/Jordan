//
//  ResultView.swift
//  Jordan
//
//  Created by Kevin Lima on 10/11/2022.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject private var vm = ResultViewModel()
    
    init(teamList: [Team]) {
        vm.setTeamList(team: teamList)
    }
    
    var body: some View {
        Text(vm.teamList.first!.name)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(teamList: [Team.exampleTeam])
    }
}
