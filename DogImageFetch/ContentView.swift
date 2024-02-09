//
//  ContentView.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.imageURL, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {

        LandingPageView()
            .environment(\.managedObjectContext, viewContext)
        
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
