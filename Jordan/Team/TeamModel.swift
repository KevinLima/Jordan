//
//  TeamModel.swift
//  Jordan
//
//  Created by Kevin Lima on 08/11/2022.
//

import Foundation

struct Team: Identifiable {
    var id = UUID()
    var name: String
    var offense: Int
    var defence: Int
    
    var offString: String {
        return String(offense)
    }
    
    var defString: String {
        return String(defence)
    }
    
    static var exampleTeam = Team(name: "Hoogvliet", offense: 5, defence: 7)
}
