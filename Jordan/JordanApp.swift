//
//  JordanApp.swift
//  Jordan
//
//  Created by Kevin Lima on 07/11/2022.
//

import SwiftUI

@main
struct JordanApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
