//
//  RecipeRepository.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import Foundation

class RecipeRepository: Repository {
    typealias T = RecipeResult
    
    var url: URL?
    var urlRequest: URLRequest?

    func getRecipes(with url: URL) async -> [Recipe] {
        self.url = url
        self.urlRequest = URLRequest(url: url)
        if let recipeResult = await getDataObject() {
            return recipeResult.recipes
        }
        return [Recipe]()
    }
    
    func getDataObject() async -> RecipeResult? {
        do {
            let result = await getData()
            switch (result) {
            case .success(let data):
                return try decoder.decode(RecipeResult.self, from: data)
            case .failure(let error):
                print("Error retrieving Recipes: \(error)")
                return nil
            }
        }
        catch {
            print("Error decoding recipes: \(error)")
            return nil
        }
    }
    
    func getData() async -> Result<Data, Error> {
        guard let _ = self.url, let urlRequest = self.urlRequest else {
            return .failure(URLError(.badURL))
        }
        // if the url response is cached, return it
        //This threw a failed cast SIGABRT error
        if let response = session.configuration.urlCache?.cachedResponse(for: urlRequest) {
            return .success(response.data)
        }
        // else make a network call
        do {
            return .success(try await session.data(for: urlRequest).0)
        }
        catch {
            return .failure(error)
        }
    }
}
