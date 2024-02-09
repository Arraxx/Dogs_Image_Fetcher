//
//  APIOperations.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import Foundation
import CoreData

class APIOperations : ObservableObject {
    
    @Published var imagesData : [String] = DatabaseManagerOperations.shared.fetchFromDB()
    
    func fetchDogAPI(completion : @escaping(DogsImageModel) -> Void){
        
        guard let url = URL(string: dogsAPI) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data,_,error) in
            
            if error != nil { print("Getting error fetching API")}
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(DogsImageModel.self, from: data)
                // operations for adding and deletion are called from here
                DispatchQueue.main.async {
                    if(self.imagesData.count < limit) {
                        self.imagesData.append(decodedData.message)
                        DatabaseManagerOperations.shared.addItem(decodedData.message)
                    } else {
                        let firstVal = self.imagesData[0]
                        self.imagesData.remove(at: 0)
                        print("calling deletion  \([firstVal])")
                        DatabaseManagerOperations.shared.deleteAllItemsFromDB([firstVal])
                        self.imagesData.append(decodedData.message)
                        DatabaseManagerOperations.shared.addItem(decodedData.message)
                    }
                    completion(decodedData)
                }
            } catch {
                print("Error in decoding data")
            }
            
        }
        dataTask.resume()
    }
}
