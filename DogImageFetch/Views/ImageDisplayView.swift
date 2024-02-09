//
//  ImageDisplayView.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import SwiftUI

struct ImageDisplayView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var dogURL : String = ""
    @ObservedObject var objAPIOberations : APIOperations = APIOperations()
    var body: some View {
        VStack {
            Text("Generate Dogs")
                .font(.title2)
                .bold()
                .padding()
            
            Spacer()
            
            if !dogURL.isEmpty {
                AsyncImage(url: URL(string: dogURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 150, maxWidth: 300, minHeight: 150, maxHeight: 300)
                    case .failure:
                        Text("Failed to load image")
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 300, height: 300)
            }
            
            Spacer()
            
            // On every button tap fetch data and store it in db.
            Button(action : { objAPIOberations.fetchDogAPI(){ _ in
                dogURL = objAPIOberations.imagesData.last ?? "" }}
            ){
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 150, height: 40)
                    .overlay(
                        Text("Generate!")
                            .foregroundStyle(Color.white)
                    )
            }
        }
    }
}

#Preview {
    ImageDisplayView()
}
