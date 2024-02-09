//
//  DatabaseManagerOperations.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import SwiftUI
import CoreData

class DatabaseManagerOperations {
    
    static let shared : DatabaseManagerOperations = DatabaseManagerOperations()
    private init() { }
    let persistenceController = PersistenceController.shared
    
    //MARK: All Database Operations
    // Addition in Database
    func addItem(_ url : String) {
        withAnimation {
            let newItem = Item(context: persistenceController.container.viewContext)
            newItem.imageURL = url

            do {
                print("Added in Database!")
                try persistenceController.container.viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // fetch data from Database
    func fetchFromDB() -> [String] {
        var urls: [String] = []

        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            let fetchedItems = try persistenceController.container.viewContext.fetch(fetchRequest)
            urls = fetchedItems.compactMap { $0.imageURL }
        } catch {
            print("Error fetching items: \(error.localizedDescription)")
        }
        return urls
    }
    
    // Delete from Database
    func deleteAllItemsFromDB(_ urlArr: [String]) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imageURL IN %@", urlArr)

        do {
            let fetchedItems = try persistenceController.container.viewContext.fetch(fetchRequest)
            for item in fetchedItems {
                persistenceController.container.viewContext.delete(item)
            }
            try persistenceController.container.viewContext.save()
        } catch {
            print("Error deleting items: \(error.localizedDescription)")
        }
    }
}
