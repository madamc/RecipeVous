//
//  RecipeVousTests.swift
//  RecipeVousTests
//
//  Created by Adam Mitchell on 1/30/25.
//
import Foundation
import Testing
import UIKit
@testable import RecipeVous

enum RecipeVousTestConstants {
    static let emptyRecipesUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    static let malformedRecipeUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    static let validRecipeImageUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/ff52841a-df5b-498c-b2ae-1d2e09ea658d/large.jpg"
}

struct RecipeVousTests {
    var service: RecipeService
    var homeVM: RecipeHomeViewModel
    var detailVM: RecipeDetailViewModel
    
    var mockRepo = MockRepo()
    var recipe = Recipe(cuisine: "a", name: "b", photo_url_large: "c", photo_url_small: "d", source_url: nil, uuid: "e", youtube_url: nil)
    
    init() {
        self.service = RecipeService()
        let homeVM = RecipeHomeViewModel(service: service)
        let detailVM = RecipeDetailViewModel(recipe: recipe,service: service)
        homeVM.service = service
        detailVM.service = service
        self.homeVM = homeVM
        self.detailVM = detailVM
    }
}

struct RepositoryTests {
    var mockRepo: MockRepo
    
    init() {
        self.mockRepo = MockRepo()
    }
    
    @Test("getData returns a Result type corresponding to input type")
    func getDataReturnsResult() async {
        let result = await mockRepo.getData()
        let type = type(of: result)
        let typ2 = Result<Data, Error>.self
        #expect(type.self == typ2.self)
    }
    
    @Test("Returns expected Result<String> type based on String input",arguments: [true, false])
    func repoReturnsExpectedType(inputBool: Bool) async {
        mockRepo.returnString = inputBool
        let failure = Result<Data, Error>.failure(NSError(domain: "TestError", code: 0))
        var failureError: NSError!
        switch (failure) {
        case .success( _):
            break
        case .failure(let error as NSError):
            failureError = error
        }
        let success = Result<Data, Error>.success(Data(mockRepo.mockRepoString.utf8))
        let result = await mockRepo.getData()
        switch (result) {
        case .success(let data):
            #expect(try! success.get() == data)
        case .failure(let error as NSError):
            #expect(failureError == error)
        }
    }
}

struct ServiceTests {
    var service: RecipeService
    
    init() {
        service = RecipeService()
    }
    
    @Test("Returns an object with the type [Recipe] whether a valid URL or invalid url", arguments: [
        URL(string: RecipeVousConstants.recipesUrl)!,
        URL(string: RecipeVousTestConstants.emptyRecipesUrl)!,
        URL(string: RecipeVousTestConstants.malformedRecipeUrl)!,
        URL(string: "BadURL")!,
    ])
    func serviceReturnsRecipes(inputURL: URL) async {
        let recipes1 = await service.getRecipes(for: inputURL)
        let recipes2 = [Recipe]()
        #expect(type(of: recipes1) == type(of: recipes2))
    }
    
    @Test("Returns an UIImage whether a valid URL or invalid url or invalid data", arguments: [
        URL(string: RecipeVousTestConstants.validRecipeImageUrl)!,
        URL(string: RecipeVousTestConstants.malformedRecipeUrl)!,
        URL(string: "BadURL")!,
    ])
    func serviceReturnsImage(inputURL: URL) async {
        let image1 = await service.getImage(for: inputURL)
        let image2 = UIImage(systemName: "square.and.arrow.up")!
        #expect(type(of: image1) == type(of: image2))
    }
}

struct ViewModelTests {
    var service: RecipeService
    var homeVM: RecipeHomeViewModel
    var detailVM: RecipeDetailViewModel
    var recipe: Recipe
    
    init() {
        recipe = Recipe(cuisine: "a", name: "b", photo_url_large: "c", photo_url_small: "d", source_url: nil, uuid: "e", youtube_url: nil)
        self.service = RecipeService()
        let homeVM = RecipeHomeViewModel(service: service)
        let detailVM = RecipeDetailViewModel(recipe: recipe,service: service)
        self.homeVM = homeVM
        self.detailVM = detailVM
    }
    //Home VM
    @Test("Home VM updates the recipes when loadRecipes() is called")
    func homePopulatesRecipes() async {
        let homeRecipeCount = homeVM.recipes.count
        await homeVM.loadRecipes()
        let newHomeRecipeCount = homeVM.recipes.count
        #expect(homeRecipeCount < newHomeRecipeCount)
    }
    
    @Test("Home VM doesn't update the recipes if recipes is already populated and the result of the update call has a count of 0", arguments: [
        URL(string: RecipeVousTestConstants.emptyRecipesUrl)!,
        URL(string: RecipeVousTestConstants.malformedRecipeUrl)!,
        URL(string: "BadURL")!,
    ])
    func homeDoesntPopulateRecipes(inputURL: URL) async {
        homeVM.recipes.append(recipe)
        let homeRecipeCount = homeVM.recipes.count
        await homeVM.loadRecipes(for: inputURL)
        let newRecipes = await service.getRecipes(for: inputURL)
        let newHomeRecipeCount = homeVM.recipes.count
        #expect(homeRecipeCount == newHomeRecipeCount && homeRecipeCount > newRecipes.count)
    }
    //Detail
    @Test("Detail VM updates image when loadRecipes is called")
    func detailPopulatesImage() async {
        detailVM.imageUrl = URL(string: RecipeVousTestConstants.malformedRecipeUrl)!
        let image1 = detailVM.image
        await detailVM.loadRecipeImage()
        let image2 = detailVM.image
        #expect(image1 != image2 && image1 == nil)
    }
    
    @Test("Detail VM doesn't update image if resulting image is nil", arguments:
    [
        URL(string: RecipeVousTestConstants.malformedRecipeUrl)!,
        URL(string: "BadURL")!,
    ])
    func detailDoesntPopulateRecipes(inputUrl: URL) async {
        detailVM.imageUrl = inputUrl
        detailVM.image = UIImage(systemName: "square.and.arrow.up")
        let image1 = detailVM.image
        await detailVM.loadRecipeImage()
        let image2 = detailVM.image
        #expect(image1 == image2 && image1 != nil)
    }
}
