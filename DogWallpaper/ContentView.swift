//
//  ContentView.swift
//  DogWallpaper
//
//  Created by Azim Talukdar on 01/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = DogViewModel()
    
    var body: some View {
        VStack {
            if let imageURL = viewModel.imageURL {
                RemoteImage(url: imageURL)
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView()
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchRandomDogImage()
        }
    }
}

#Preview {
    ContentView()
}
