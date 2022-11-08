//
//  TeamModel.swift
//  Jordan
//
//  Created by Kevin Lima on 08/11/2022.
//

import Foundation

struct Team: Identifiable, Codable {
    var id = UUID()
    var name: String
    var offense: Int
    var defence: Int
    
    static var exampleTeam = Team(name: "Hoogvliet", offense: 5, defence: 7)
}
