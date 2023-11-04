//
//  __ToDoTaskApp.swift
//  3-ToDoTask
//
//  Created by Yorgi Del Rio on 10/20/23.
//

import SwiftUI

@main
struct __ToDoTaskApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
