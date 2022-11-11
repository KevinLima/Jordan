//
//  PoolResult.swift
//  Jordan
//
//  Created by Kevin Lima on 11/11/2022.
//

import Foundation

struct PoolResult: Identifiable {
    var id = UUID()
    var team: Team
    var points: Int
    var goalsScored: Int
    var goalsConceded: Int
}
