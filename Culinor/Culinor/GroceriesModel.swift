//
//  GroceriesModel.swift
//  APP
//
//  Created by Mason Huang on 2024/6/9.
//

import Foundation

struct Groceries: Identifiable {
    var id = UUID()
    var title: String
    var price: Int
    var imageName: String
    var quantity: Int = 0
    var isSelected: Bool = false
}

class GroceriesManager: ObservableObject {
    @Published var groceries: [Groceries] = [
        Groceries(title: "Apple", price: 3, imageName: "apple"),
        Groceries(title: "Banana", price: 2, imageName: "banana"),
        Groceries(title: "Orange", price: 4, imageName: "orange"),
        Groceries(title: "Chicken", price: 5, imageName: "chicken"),
        Groceries(title: "Beef", price: 10, imageName: "beef"),
        Groceries(title: "Pork", price: 8, imageName: "pork"),
        Groceries(title: "Milk", price: 2, imageName: "milk"),
        Groceries(title: "Bread", price: 1, imageName: "bread"),
        Groceries(title: "Eggs", price: 3, imageName: "eggs"),
        Groceries(title: "Grapes", price: 6, imageName: "grapes"),
        Groceries(title: "Watermelon", price: 7, imageName: "watermelon"),
        Groceries(title: "Strawberry", price: 5, imageName: "strawberry"),
        Groceries(title: "Mushroom", price: 4, imageName: "mushroom"),
        Groceries(title: "Carrot", price: 2, imageName: "carrot"),
        Groceries(title: "Spinach", price: 3, imageName: "spinach")
    ]
}
