//
//  DogImageFetchApp.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import SwiftUI

@main
struct DogImageFetchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
