//
//  ContentView.swift
//  RecipeVous
//
//  Created by Adam Mitchell on 1/30/25.
//

import SwiftUI

struct ContentView: View {  
    var recipeService = RecipeService()
    var body: some View {
            NavigationStack {
                RecipeHomeView(vm: RecipeHomeViewModel(service: recipeService))
                
            }
    }
}

#Preview {
    ContentView()
}
