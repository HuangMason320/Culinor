import SwiftUI

struct ListView: View {
    @State private var searchText = ""
    @State private var showModal = false
    @ObservedObject var recipeManager: RecipeManager
    @FocusState private var isSearchFieldFocused: Bool
    @State private var showAllRecipes = false

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipeManager.recipes
        } else {
            return recipeManager.recipes.filter { recipe in
                recipe.title.contains(searchText) || recipe.ingredients.contains { ingredient in
                    ingredient.contains(searchText)
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                        TextField("Search for recipes", text: $searchText)
                            .padding(7)
                            .padding(.leading, -5)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 10)
                            .focused($isSearchFieldFocused)
                            .overlay(
                                HStack {
                                    Spacer()
                                    if !searchText.isEmpty {
                                        Button(action: {
                                            self.searchText = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 10)
                                        }
                                        
                                        if isSearchFieldFocused {
                                            Button(action: {
                                                isSearchFieldFocused = false
                                            }) {
                                                Text("取消")
                                                    .foregroundColor(Color.chart)
                                                    .padding(.trailing, 10)
                                            }
                                        }
                                    } else {
                                        Button(action: {
                                            print("Recording button tapped")
                                        }) {
                                            Image(systemName: "mic.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 10)
                                        }
                                        if isSearchFieldFocused {
                                            Button(action: {
                                                isSearchFieldFocused = false
                                            }) {
                                                Text("取消")
                                                    .foregroundColor(Color.chart)
                                                    .padding(.trailing, 10)
                                            }
                                        }
                                    }
                                }
                            )
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .padding(.top)

                    if searchText.isEmpty {
                        HStack {
                            Text("Recent View")
                                .bold()
                                .font(.title3)
                                .padding(.leading)
                                .padding(.top)
                            Spacer()
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(recipeManager.recipes.prefix(3)) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                        RecipeCardView(recipe: recipe)
                                    }
                                }
                            }
                            .padding(.leading)
                            .padding(.trailing, 10)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Suggested for you")
                                .bold()
                                .font(.title3)
                                .padding(.leading)
                                .padding(.top)
                            Spacer()
                        }
                    }

                    ForEach(showAllRecipes || !searchText.isEmpty ? filteredRecipes : Array(filteredRecipes.dropFirst(3).prefix(4))) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRowView(recipe: recipe)
                        }
                    }

                    .padding(.leading)
                    
                    // "View More" button at the bottom
                    if !showAllRecipes && searchText.isEmpty {
                        Button(action: {
                            showAllRecipes = true
                        }) {
                            Text("View More")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.chart)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Recipe")
                            .font(.title)
                            .bold()
                    }
                    .padding(.top, 9)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showModal = true
                        print("User profile tapped")
                    } label: {
                        Image("user_profile")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60)
                    }
                    .sheet(isPresented: $showModal) {
                        AccountView()
                    }
                }
            }
        }
    }
}

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack {
                GeometryReader { geometry in
                    if geometry.frame(in: .global).minY <= 0 {
                        Image(recipe.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .offset(y: geometry.frame(in: .global).minY / 2)
                    } else {
                        Image(recipe.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
                .frame(height: 300)

                VStack(alignment: .leading, spacing: 16) {
                    Text(recipe.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(recipe.description)
                        .font(.body)
                    
                    Divider()
                    
                    Text("Steps")
                        .font(.headline)
                        .padding(.top, 2)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                            Text("\(index + 1). \(step)")
                                .font(.body)
                                .padding(.vertical, 2)
                        }
                    }
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                Text(ingredient)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    
                    Text("Source from: ChatGPT")
                        .font(.footnote)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RecipeCardView: View {
    var recipe: Recipe

    var body: some View {
        VStack {
            Image(recipe.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 175, height: 125)
                .clipped()
                .cornerRadius(10)
            Text(recipe.title)
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(.black)
        }
        .frame(width: 150)
        .padding(.top, 5)
        .padding(.horizontal)
    }
}

struct RecipeRowView: View {
    var recipe: Recipe

    var body: some View {
        HStack {
            Image(recipe.imageName)
                .resizable()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(recipe.headline)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
        Divider()
    }
}

#Preview {
    ListView(recipeManager: RecipeManager())
}
