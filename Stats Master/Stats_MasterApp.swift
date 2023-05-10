//
//  Stats_MasterApp.swift
//  Stats Master
//
//  Created by KJ on 5/10/23.
//

import SwiftUI

@main
struct Stats_MasterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
