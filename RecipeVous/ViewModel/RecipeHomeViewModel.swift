//
//  RecipeHomeViewModel.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import Foundation
import Combine

class RecipeHomeViewModel: ObservableObject {
    @Published var recipes: [Recipe]
    var service: RecipeService
    init(recipes: [Recipe] = [Recipe](), service: RecipeService) {
        self.recipes = recipes
        self.service = service
    }
    
    @MainActor
    func loadRecipes(for url: URL = URL(string: RecipeVousConstants.recipesUrl)!) async {
        let recipesFromApi = await service.getRecipes(for: url)
        if !recipes.isEmpty && recipesFromApi.isEmpty {
        }
        else {
            recipes = recipesFromApi
        }
    }
}
