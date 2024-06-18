//
//  RecipeModel.swift
//  APP
//
//  Created by Mason Huang on 2024/6/8.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    var title: String
    var headline: String
    var description: String
    var ingredients: [String]
    var steps: [String]
    var imageName: String
}

class RecipeManager: ObservableObject {
    @Published var recipes: [Recipe] = [
        Recipe(
            title: "Miso Soup",
            headline: "Traditional Japanese Soup",
            description: "A simple and comforting soup made with dashi broth, miso paste, tofu, and seaweed.",
            ingredients: ["dashi broth", "miso paste", "tofu", "wakame seaweed", "green onions"],
            steps: [
                "Prepare dashi broth according to package instructions.",
                "Bring dashi broth to a boil and reduce to a simmer.",
                "Add miso paste to the broth and stir until dissolved.",
                "Cut tofu into small cubes and add to the soup.",
                "Add wakame seaweed and cook for a few minutes until rehydrated.",
                "Garnish with chopped green onions and serve hot."
            ],
            imageName: "miso_soup"
        ),
        Recipe(
            title: "Pad Thai",
            headline: "Famous Thai Noodle Dish",
            description: "Stir-fried rice noodles with shrimp, tofu, peanuts, scrambled eggs, and bean sprouts.",
            ingredients: ["rice noodles", "shrimp", "tofu", "eggs", "bean sprouts", "peanuts", "green onions", "garlic", "fish sauce", "tamarind paste", "sugar", "lime"],
            steps: [
                "Soak rice noodles in warm water until softened, then drain.",
                "In a wok, heat oil and cook shrimp until pink, then set aside.",
                "Add tofu and cook until golden brown, then set aside.",
                "Scramble eggs in the wok and set aside.",
                "Add garlic and cook until fragrant.",
                "Stir in fish sauce, tamarind paste, and sugar.",
                "Add softened noodles and mix well.",
                "Add shrimp, tofu, scrambled eggs, bean sprouts, and green onions.",
                "Cook until everything is heated through.",
                "Garnish with peanuts and lime wedges before serving."
            ],
            imageName: "pad_thai"
        ),
        Recipe(
            title: "Caesar Salad",
            headline: "Crisp and Refreshing Salad",
            description: "A salad of romaine lettuce, croutons, and Parmesan cheese dressed with a tangy Caesar dressing.",
            ingredients: ["romaine lettuce", "croutons", "Parmesan cheese", "Caesar dressing"],
            steps: [
                "Wash and chop romaine lettuce.",
                "In a large bowl, combine lettuce, croutons, and Parmesan cheese.",
                "Add Caesar dressing and toss to coat evenly.",
                "Serve immediately."
            ],
            imageName: "caesar_salad"
        ),
        Recipe(
            title: "Spaghetti Carbonara",
            headline: "Classic Italian Pasta Dish",
            description: "A quick and easy pasta dish with eggs, cheese, pancetta, and pepper.",
            ingredients: ["spaghetti", "eggs", "Parmesan cheese", "pancetta", "black pepper", "salt"],
            steps: [
                "Cook spaghetti according to package instructions until al dente.",
                "In a bowl, whisk eggs and Parmesan cheese together.",
                "In a pan, cook pancetta until crispy.",
                "Add cooked spaghetti to the pan with pancetta.",
                "Remove from heat and quickly stir in egg mixture.",
                "Season with black pepper and salt.",
                "Serve immediately."
            ],
            imageName: "spaghetti_carbonara"
        ),
        Recipe(
            title: "Chicken Tikka Masala",
            headline: "Popular Indian Curry",
            description: "Tender chicken pieces cooked in a rich, creamy tomato sauce.",
            ingredients: ["chicken", "yogurt", "tomato puree", "onions", "garlic", "ginger", "garam masala", "cumin", "coriander", "turmeric", "chili powder"],
            steps: [
                "Marinate chicken in yogurt and spices for at least 30 minutes.",
                "In a large pan, cook onions, garlic, and ginger until soft.",
                "Add marinated chicken and cook until browned.",
                "Stir in tomato puree and additional spices.",
                "Simmer until chicken is cooked through and sauce is thickened.",
                "Serve with rice or naan."
            ],
            imageName: "chicken_tikka_masala"
        ),
        Recipe(
            title: "Beef Stroganoff",
            headline: "Russian Comfort Food",
            description: "A hearty dish with sautéed beef, mushrooms, and a creamy sauce served over noodles.",
            ingredients: ["beef", "mushrooms", "onions", "garlic", "sour cream", "beef broth", "butter", "flour", "egg noodles"],
            steps: [
                "Cook egg noodles according to package instructions.",
                "In a pan, cook beef until browned, then set aside.",
                "In the same pan, cook onions, garlic, and mushrooms until soft.",
                "Sprinkle flour over the vegetables and cook for 1-2 minutes.",
                "Slowly stir in beef broth and bring to a boil.",
                "Reduce heat and stir in sour cream.",
                "Add beef back to the pan and heat through.",
                "Serve over cooked egg noodles."
            ],
            imageName: "beef_stroganoff"
        ),
        Recipe(
            title: "Margherita Pizza",
            headline: "Classic Italian Pizza",
            description: "Simple yet delicious pizza with tomatoes, mozzarella cheese, and fresh basil.",
            ingredients: ["pizza dough", "tomato sauce", "mozzarella cheese", "fresh basil", "olive oil", "salt"],
            steps: [
                "Preheat oven to 475°F (245°C).",
                "Roll out pizza dough on a floured surface.",
                "Spread tomato sauce over the dough.",
                "Top with mozzarella cheese and fresh basil.",
                "Drizzle with olive oil and sprinkle with salt.",
                "Bake for 10-12 minutes or until crust is golden and cheese is bubbly.",
                "Slice and serve hot."
            ],
            imageName: "margherita_pizza"
        ),
        Recipe(
            title: "Chocolate Chip Cookies",
            headline: "Classic American Cookies",
            description: "Chewy and soft cookies loaded with chocolate chips.",
            ingredients: ["flour", "butter", "sugar", "brown sugar", "eggs", "vanilla extract", "baking soda", "salt", "chocolate chips"],
            steps: [
                "Preheat oven to 350°F (175°C).",
                "In a bowl, cream together butter, sugar, and brown sugar.",
                "Beat in eggs and vanilla extract.",
                "In another bowl, combine flour, baking soda, and salt.",
                "Gradually add dry ingredients to wet ingredients.",
                "Stir in chocolate chips.",
                "Drop dough by spoonfuls onto a baking sheet.",
                "Bake for 10-12 minutes or until edges are golden.",
                "Cool on wire racks before serving."
            ],
            imageName: "chocolate_chip_cookies"
        ),
        Recipe(
            title: "Vegetable Stir Fry",
            headline: "Quick and Healthy Meal",
            description: "Colorful mix of vegetables stir-fried in a savory sauce.",
            ingredients: ["broccoli", "bell peppers", "carrots", "snow peas", "garlic", "soy sauce", "ginger", "sesame oil", "cornstarch"],
            steps: [
                "Chop vegetables into bite-sized pieces.",
                "In a wok, heat sesame oil and cook garlic and ginger until fragrant.",
                "Add vegetables and stir-fry until tender-crisp.",
                "In a small bowl, mix soy sauce and cornstarch with a bit of water.",
                "Pour sauce over vegetables and cook until thickened.",
                "Serve hot."
            ],
            imageName: "vegetable_stir_fry"
        ),
        Recipe(
            title: "Guacamole",
            headline: "Fresh Mexican Dip",
            description: "A creamy and flavorful avocado dip with tomatoes, onions, lime juice, and cilantro.",
            ingredients: ["avocados", "tomatoes", "onions", "lime juice", "cilantro", "salt"],
            steps: [
                "Mash avocados in a bowl.",
                "Stir in chopped tomatoes, onions, lime juice, and cilantro.",
                "Season with salt to taste.",
                "Serve with tortilla chips or as a topping for tacos."
            ],
            imageName: "guacamole"
        )
    ]
}
