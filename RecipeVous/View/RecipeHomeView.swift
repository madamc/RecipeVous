//
//  SwiftUIView.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import SwiftUI

struct RecipeHomeView: View {
    @ObservedObject var vm: RecipeHomeViewModel
    var body: some View {
        Section("Mon Recipes!") {
            VStack(alignment: .leading) {
                List {
                    ScrollView {
                        if vm.recipes.isEmpty {
                            Text("No recipes to show. Try refreshing to retrieve some")
                        }
                        ForEach(vm.recipes, id: \.self) { recipe in
                            NavigationLink(value: recipe) {
                                RecipeRowView(vm: RecipeRowViewModel(recipe: recipe, service: vm.service))
                            }
                        }
                    }
                }.refreshable {
                    getDataFromAPI()
                }
                .navigationDestination(for: Recipe.self) { recipe in
                    RecipeDetailView(vm: RecipeDetailViewModel(recipe: recipe, service: vm.service))
                }
            }
            .navigationTitle("It's recipe time!")
        }
    }
    
    func getDataFromAPI() {
        Task {
            await vm.loadRecipes()
        }
    }
}

//#Preview {
//    RecipeHomeView()
//}
