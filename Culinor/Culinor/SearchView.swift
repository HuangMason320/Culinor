//
//  SearchView.swift
//  APP
//
//  Created by Mason Huang on 2024/6/5.
//
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var showModal = false
    @FocusState private var isSearchFieldFocused: Bool
    @StateObject private var groceriesManager = GroceriesManager()
    
    @State private var selectedQuantity = 0
    @State private var totalPrice = 0
    @State private var showCartView = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .padding(.leading, 10)
                    TextField("Search for ingredients or stores", text: $searchText)
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
                                            Text("Cancel")
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
                                            Text("Cancel")
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
                
                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color.chart)
                        .padding(.leading)
                    Text("Current location: 新竹市 東區")
                        .font(.caption)
                        .foregroundColor(Color.text)
                    Spacer()
                }
                .padding()
                
                if searchText.isEmpty {
                    ScrollView {
                        VStack {
                            SectionView(title: "Suggested for you", products: Array(groceriesManager.groceries.prefix(5)), addToCart: addToCart)
                            
                            Divider()
                            
                            SectionView(title: "Best Selling", products: Array(groceriesManager.groceries.dropFirst(5).prefix(5)), addToCart: addToCart)
                            
                            Divider()
                            
                            SectionView(title: "Groceries", products: Array(groceriesManager.groceries.dropFirst(10).prefix(5)), addToCart: addToCart)
                        }
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("Search Result")
                            .font(.headline)
                            .padding(.leading)
                        
                        ScrollView {
                            VStack {
                                ForEach(filteredProducts()) { product in
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Image(product.imageName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                            VStack(alignment: .leading) {
                                                Text(product.title)
                                                    .font(.subheadline)
                                                Text("$\(product.price)")
                                                    .font(.subheadline)
                                            }
                                            Spacer()
                                            Button(action: {
                                                addToCart(product: product)
                                            }) {
                                                Image(systemName: "plus.circle")
                                                    .foregroundColor(.blue)
                                            }
                                        }
                                        Divider()
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                
                Spacer()
                
                Button(action: {
                    showCartView = true
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.systemGray6))
                            .frame(height: 60)
                            .cornerRadius(10)
                            .padding(.horizontal, 10)
                        
                        HStack {
                            Text("Items: \(selectedQuantity)")
                                .font(.headline)
                                .padding(.leading, 20)
                                .foregroundColor(Color.text)
                            
                            Spacer()
                            
                            Text("Total: $\(totalPrice)")
                                .font(.headline)
                                .padding(.trailing, 20)
                                .foregroundColor(Color.text)
                        }
                    }
                }
                .padding(.bottom, 20)
                .sheet(isPresented: $showCartView) {
                    CartView(cartItems: Binding.constant(groceriesManager.groceries.filter { $0.isSelected }), totalPrice: $totalPrice, updateCart: updateCart)
                }
            }
            .padding(.top)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Search")
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
    
    func filteredProducts() -> [Groceries] {
        return groceriesManager.groceries.filter { $0.title.contains(searchText) }
    }
    
    func addToCart(product: Groceries) {
        if let index = groceriesManager.groceries.firstIndex(where: { $0.id == product.id }) {
            groceriesManager.groceries[index].quantity += 1
            groceriesManager.groceries[index].isSelected = true
            selectedQuantity += 1
            totalPrice += product.price
        }
    }
    
    func updateCart(product: Groceries, quantity: Int) {
        if let index = groceriesManager.groceries.firstIndex(where: { $0.id == product.id }) {
            let difference = quantity - groceriesManager.groceries[index].quantity
            groceriesManager.groceries[index].quantity = quantity
            selectedQuantity += difference
            totalPrice += difference * product.price
        }
    }
}

struct SectionView: View {
    let title: String
    let products: [Groceries]
    let addToCart: (Groceries) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(products) { product in
                        VStack {
                            Image(product.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Text(product.title)
                                .font(.subheadline)
                            Text("$\(product.price)")
                                .font(.subheadline)
                            HStack {
                                Spacer()
                                Button(action: {
                                    addToCart(product)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(Color.chart)
                                }
                            }
                        }
                        .padding()
                        .background(Color.background)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
}

struct CartView: View {
    @Binding var cartItems: [Groceries]
    @Binding var totalPrice: Int
    var updateCart: (Groceries, Int) -> Void

    var body: some View {
        VStack {
            Text("Shopping Cart")
                .font(.title3)
                .bold()
                .padding()
            List {
                ForEach($cartItems) { $item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                            Text("$\(item.price)")
                                .font(.subheadline)
                        }
                        Spacer()
                        HStack {
                            Button(action: {
                                if item.quantity > 0 {
                                    item.quantity -= 1
                                    updateCart(item, item.quantity)
                                }
                            }) {
                                Image(systemName: "minus")
//                                    .padding(5)
                                    .foregroundColor(Color.chart)
//                                    .background(Color.gray.opacity(0.2))
//                                    .clipShape(Circle())
                            }
                            Text("\(item.quantity)")
                                .padding(.horizontal)
                            Button(action: {
                                item.quantity += 1
                                updateCart(item, item.quantity)
                            }) {
                                Image(systemName: "plus")
//                                    .padding(5)
                                    .foregroundColor(Color.chart)
//                                    .background(Color.gray.opacity(0.2))
//                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
            
            Divider()
                .padding(.vertical)

            HStack {
                Text("Total:")
                    .font(.headline)
                Spacer()
                Text("$\(totalPrice)")
                    .font(.headline)
            }
            .padding()

            Button(action: {
                // Checkout action
            }) {
                Text("Checkout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationTitle("Cart")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SearchView()
}
