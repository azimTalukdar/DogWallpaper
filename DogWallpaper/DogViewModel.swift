//
//  DogViewModel.swift
//  DogWallpaper
//
//  Created by Azim Talukdar on 01/03/24.
//

import Foundation

class DogViewModel: ObservableObject {
    private let dogAPIManager: DogAPIManager
    
    @Published var imageURL: URL?
    @Published var errorMessage: String?
    
    init(dogAPIManager: DogAPIManager = DogAPIManager()) {
        self.dogAPIManager = dogAPIManager
    }
    
    func fetchRandomDogImage() {
        dogAPIManager.fetchRandomDogImage { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageURL):
                    self.imageURL = imageURL
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
