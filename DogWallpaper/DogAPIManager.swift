//
//  DogAPIManager.swift
//  DogWallpaper
//
//  Created by Azim Talukdar on 01/03/24.
//

import Foundation


struct DogResponse: Codable {
    let message: String
    let status: String
}

enum NetworkError: Error {
    case invalidURL
    case networkError
    case jsonParsingError
}

class DogAPIManager {
    func fetchRandomDogImage(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.networkError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let dogData = try decoder.decode(DogResponse.self, from: data)
                completion(.success(URL(string: dogData.message)!))
            } catch {
                completion(.failure(NetworkError.jsonParsingError))
            }
        }.resume()
    }
}

