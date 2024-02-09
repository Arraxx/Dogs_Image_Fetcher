//
//  CachedGeneratedImages.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import SwiftUI

struct CachedGeneratedImages: View {
    @State var check : Bool = true
    var body: some View {
        VStack {
            Text("My Recent Generated Dogs!")
                .font(.title2)
                .bold()
                .padding()
            
            Spacer()
            
            // Scrollview to show stored images in DB
            if check{
                ScrollView {
                    ForEach(DatabaseManagerOperations.shared.fetchFromDB(), id:\.self){ val in
                        AsyncImage(url: URL(string: val)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(minWidth: 200, maxWidth: 200, minHeight: 200, maxHeight: 200)
                            case .failure:
                                Text("Failed to load image")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 200, height: 200)
                    }
                }
            }
            
            Spacer()
            
            // Clear all the Images from DB
            Button(action : {
                DatabaseManagerOperations.shared.deleteAllItemsFromDB(DatabaseManagerOperations.shared.fetchFromDB())
                self.check = false
            } ){
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 150, height: 40)
                    .overlay(
                        Text("clear")
                            .foregroundStyle(Color.white)
                    )
            }
        }
    }
}

#Preview {
    CachedGeneratedImages()
}
