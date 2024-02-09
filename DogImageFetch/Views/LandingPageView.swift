//
//  LandingPageView.swift
//  DogImageFetch
//
//  Created by Arrax on 07/02/24.
//

import SwiftUI

struct LandingPageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        NavigationStack{
            VStack (spacing : 400){
                HStack{
                    Text("Random Dog Generator")
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                }
                VStack(spacing : 20){
                    NavigationLink(destination: ImageDisplayView()
                        .environment(\.managedObjectContext, viewContext)) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 250,height: 50)
                            .overlay(
                                Text("Generate Dogs!")
                                    .foregroundStyle(Color.white)
                            )
                    }
                    NavigationLink(destination: CachedGeneratedImages()
                        .environment(\.managedObjectContext, viewContext)) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 300,height: 50)
                            .overlay(
                                Text("My Recently Generated Dogs!")
                                    .foregroundStyle(Color.white)
                            )
                    }
                }
            }
        }
    }
}

#Preview {
    LandingPageView()
}
